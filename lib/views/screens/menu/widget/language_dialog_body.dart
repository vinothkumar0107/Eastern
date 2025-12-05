
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/messages.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/localization/localization_controller.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/language/language_model.dart';
import 'package:eastern_trust/data/repo/auth/general_setting_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

import '../../../../../core/helper/shared_preference_helper.dart';
import '../../../../core/utils/dimensions.dart';

class LanguageDialogBody extends StatefulWidget {
  final List<LanguageModel>langList ;
  final bool fromSplashScreen;
  const LanguageDialogBody({Key? key,required this.langList,this.fromSplashScreen = false}) : super(key: key);

  @override
  State<LanguageDialogBody> createState() => _LanguageDialogBodyState();
}

class _LanguageDialogBodyState extends State<LanguageDialogBody> {

  int pressIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Text(MyStrings.selectALanguage,style: interRegularDefault.copyWith(color:MyColor.getTextColor(),fontSize: Dimensions.fontLarge),),),
          const SizedBox(height: Dimensions.space15,),
          Flexible(child: ListView.builder(
              shrinkWrap: true,
              itemCount:  widget.langList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: ()async{
                    setState(() {
                      pressIndex = index;
                    });
                    String languageCode = widget.langList[index].languageCode;
                    final repo = Get.put(GeneralSettingRepo(apiClient: Get.find()));
                    final localizationController = Get.put(LocalizationController(sharedPreferences: Get.find()));
                    ResponseModel response = await repo.getLanguage(languageCode);
                    if(response.statusCode == 200){
                      try{
                        Map<String,Map<String,String>> language = {};
                        var resJson = jsonDecode(response.responseJson);
                        await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, response.responseJson);
                        var value = resJson['data']['language_data'] as Map<String,dynamic>;
                        Map<String,String> json = {};
                        value.forEach((key, value) {
                          json[key] = value.toString();
                        });

                        language['${widget.langList[index].languageCode}_${'US'}'] = json;

                        Get.clearTranslations();
                        Get.addTranslations(Messages(languages: language).keys);

                        Locale local = Locale(widget.langList[index].languageCode,'US');
                        localizationController.setLanguage(local);
                        if(widget.fromSplashScreen){
                          Get.offAndToNamed(RouteHelper.loginScreen,);
                        }else{
                          Get.back();
                        }
                      }catch(e){
                        CustomSnackBar.error(errorList: [e.toString()]);
                        Get.back();
                      }

                    } else{
                      CustomSnackBar.error(errorList: [response.message]);
                      setState(() {
                        pressIndex=-1;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                    decoration: BoxDecoration(color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    child: pressIndex==index?const  Center(
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(color: MyColor.primaryColor)),
                    ): Row(
                      children: [
                        Image.network(
                          widget.langList[index].imageUrl,   // server image URL
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.flag);   // fallback icon if image fails
                          },
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            widget.langList[index].languageName.tr,
                            style: interRegularDefault.copyWith(
                              color: MyColor.getTextColor(),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )

                  ),
                );
              })),
        ],
      ),
    );
  }
}
