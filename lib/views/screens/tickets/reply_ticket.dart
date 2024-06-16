import 'dart:io';

import 'package:eastern_trust/data/controller/account/profile_controller.dart';
import 'package:eastern_trust/data/model/dynamic_form/form.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';
import 'package:eastern_trust/views/screens/account/edit-profile/widget/profile_image.dart';
import 'package:eastern_trust/views/screens/transfer/wire_transfer_screen/widget/wire_transfer_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/deposit/add_new_deposit_controller.dart';
import 'package:eastern_trust/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:eastern_trust/data/repo/deposit/deposit_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/text-field/custom_amount_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field2.dart';
import 'package:eastern_trust/views/screens/deposits/new_deposit/info_widget.dart';
import 'package:image_picker/image_picker.dart';


class ReplyTicketScreen extends StatefulWidget {

  const ReplyTicketScreen({Key? key}) : super(key: key);

  @override
  State<ReplyTicketScreen> createState() => _ReplyTicketScreenState();
}

class _ReplyTicketScreenState extends State<ReplyTicketScreen> {

  String? _selectedValue ="Item 1";
  String? _fileName;
  final List<String> _dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  XFile? imageFile;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor2(),
          appBar: const CustomAppBar(title: MyStrings.createTicket),
          body:  SingleChildScrollView(
              padding: Dimensions.screenPaddingHV1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: MyColor.getScreenBgColor2(),
                    borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
                ),
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                          hintText: MyStrings.subject.capitalizeFirst!.tr,
                          needLabel: true,
                          needOutlineBorder: true,
                          labelText:MyStrings.subject.capitalizeFirst!.tr,
                          isRequired: true,
                          onChanged: (value){
                            // controller.changeSelectedValue(value, index);
                          }),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          LabelText(text: MyStrings.priority.tr,required: true,),
                          const SizedBox(height: 10),

                          CustomDropDownTextField(selectedValue:_selectedValue,
                            list: _dropdownItems,onChanged:(value) {

                              setState(() {
                                _selectedValue = value;
                              });
                          },
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                          hintText: MyStrings.message.capitalizeFirst!.tr,
                          needLabel: true,
                          needOutlineBorder: true,
                          labelText:MyStrings.message.capitalizeFirst!.tr,
                          isRequired: true,
                          onChanged: (value){
                            // controller.changeSelectedValue(value, index);
                          }),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () {
                          _openGallery(context);
                        },
                        child: Text('+ Add New'),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Attachments ',
                          style:interSemiBoldSmall.copyWith(color: MyColor.colorBlack),
                          children: <TextSpan>[
                            TextSpan(
                              text: MyStrings.fileSize,
                              style:interMediumSmall.copyWith(color: MyColor.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                          hintText: "",
                          needLabel: true,
                          needOutlineBorder: true,
                          labelText:"",

                          isRequired: false,
                          onChanged: (value){
                            // controller.changeSelectedValue(value, index);
                          }),
                      const SizedBox(height: 10),
                      Text(
                        'Allowed File Extensions: .jpg, .jpeg, .png, .pdf, .doc, .docx',
                        style:interMediumSmall.copyWith(color: MyColor.colorGrey,),
                      ),

                      // controller.paymentMethod?.name!=MyStrings.selectOne?const InfoWidget():const SizedBox(),
                      const SizedBox(height: 35),
                      // controller.submitLoading?const RoundedLoadingBtn():
                      RoundedButton(
                        text: MyStrings.submit,
                        textColor: MyColor.textColor,
                        width: double.infinity,
                        press: (){
                          // controller.submitDeposit();
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );

  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      Get.find<ProfileController>().imageFile = File(pickedFile!.path);
      imageFile = pickedFile;
    });
  }

}

