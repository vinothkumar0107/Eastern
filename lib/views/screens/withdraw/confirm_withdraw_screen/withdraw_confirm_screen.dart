import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/withdraw/withdraw_confirm_controller.dart';
import 'package:eastern_trust/data/model/withdraw/withdraw_preview_response_model.dart';
import 'package:eastern_trust/data/repo/account/profile_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/checkbox/custom_check_box.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/custom_radio_button.dart';
import 'package:eastern_trust/views/components/row_item/form_row.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'widget/choose_file_list_item.dart';

class WithdrawConfirmScreen extends StatefulWidget {

  const WithdrawConfirmScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawConfirmScreen> createState() => _WithdrawConfirmScreenState();
}

class _WithdrawConfirmScreenState extends State<WithdrawConfirmScreen> {

  @override
  void initState() {
    String trxId = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawConfirmController(repo: Get.find(), profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.trxId=trxId;
      controller.initData();
    });
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<WithdrawConfirmController>(builder: (controller)=>Scaffold(
        backgroundColor: MyColor.colorWhite,
        appBar: const CustomAppBar(title: MyStrings.withdrawConfirm),
        body: controller.isLoading?const CustomLoader():SingleChildScrollView(
          padding: Dimensions.previewPaddingHV,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 25),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: MyColor.colorWhite,
                borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                border: Border.all(color: MyColor.borderColor,width: 1)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.formList.length,
                    itemBuilder: (ctx,index){
                      FormModel? model=controller.formList[index];
                      return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          model.type=='text'?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                  hintText: '${((model.name??'').capitalizeFirst)?.tr}',
                                  needLabel: true,
                                  needOutlineBorder: true,
                                  labelText:( model.name??'').tr,
                                  isRequired: model.isRequired=='optional'?false:true,
                                  onChanged: (value){
                                    controller.changeSelectedValue(value, index);
                                  }),
                              const SizedBox(height: 10,),
                            ],
                          ):model.type=='textarea'?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                  needLabel: true,
                                  needOutlineBorder: true,
                                  labelText: (model.name??'').tr,
                                  isRequired: model.isRequired=='optional'?false:true,
                                  hintText: '${((model.name??'').capitalizeFirst)?.tr}',
                                  onChanged: (value){
                                    controller.changeSelectedValue(value, index);
                                  }),
                              const SizedBox(height: 10,),
                            ],
                          ):model.type=='select'?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                              CustomDropDownTextField(list: model.options??[],onChanged: (value){
                                controller.changeSelectedValue(value,index);
                              },selectedValue: model.selectedValue,),
                            ],
                          ):model.type=='radio'?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                              CustomRadioButton(title:model.name,selectedIndex:controller.formList[index].options?.indexOf(model.selectedValue??'')??0,list: model.options??[],onChanged: (selectedIndex){
                                controller.changeSelectedRadioBtnValue(index,selectedIndex);
                              },),
                            ],
                          ):model.type=='checkbox'?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                              CustomCheckBox(selectedValue:controller.formList[index].cbSelected,list: model.options??[],onChanged: (value){
                                controller.changeSelectedCheckBoxValue(index,value);
                              },),
                            ],
                          ):model.type=='file'?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                              Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                  child: SizedBox(
                                    child:InkWell(
                                        onTap: (){
                                          controller.pickFile(index);
                                        }, child: ChooseFileItem(fileName: model.selectedValue??MyStrings.chooseFile.tr,)),
                                  )
                              )
                            ],
                          ):const SizedBox(),

                          const SizedBox(height: 5,),

                        ],
                      );
                    }
                ),
                const SizedBox(height: Dimensions.space25),
                controller.submitLoading ?
                const Center(child:RoundedLoadingBtn()) :
                RoundedButton(
                  color: MyColor.getButtonColor(),
                  press: () {
                    controller.submitConfirmWithdrawRequest();
                  },
                  text: MyStrings.submit.tr,
                  textColor: MyColor.getButtonTextColor(),
                ),
              ],
            ),
          ),
        )
    )
    );
  }
}
