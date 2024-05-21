import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/auth/auth/registration_controller.dart';

class CountryBottomSheet{

  static void bottomSheet(BuildContext context, RegistrationController controller){
    showModalBottomSheet(
        isScrollControlled:true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height*.8,
            padding: const EdgeInsets.all(15),
            decoration:  const BoxDecoration(
                color: MyColor.colorWhite,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
            ),
            child: Column(
              children: [
                const SizedBox(height: 8,),
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColor.colorGrey.withOpacity(0.4),
                    ),

                  ),
                ),
                const SizedBox(height: 15,),
                Flexible(
                  child: ListView.builder(itemCount:controller.countryList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){

                              controller.countryController.text = controller.countryList[index].country??'';
                              controller.setCountryNameAndCode(controller.countryList[index].country??'',
                              controller.countryList[index].countryCode??'', controller.countryList[index].dialCode??'');

                              Navigator.pop(context);
                              controller.setMobileFocus();

                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: MyColor.getCardBg(),
                                 border:Border.all(width: .5,color: MyColor.primaryColor.withOpacity(.1)),
                                 boxShadow: MyUtil.getBottomSheetShadow()
                              ),
                              child: Text(
                                  '+${controller.countryList[index].dialCode}  ${controller.countryList[index].country.toString().tr}',
                                  style: interRegularDefault.copyWith(color: MyColor.getTextColor())
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        }
    );
  }
}