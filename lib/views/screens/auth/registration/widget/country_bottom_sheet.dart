import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/auth/auth/registration_controller.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../data/model/country_model/country_model.dart';

class CountryBottomSheet{

  static void bottomSheet2(BuildContext context, RegistrationController controller){
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

  static void bottomSheet(BuildContext context, RegistrationController controller) {
    TextEditingController searchController = TextEditingController();
    List<Countries> filteredCountryList = controller.countryList;

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: MyColor.colorWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 15),

                  // Search TextField
                  TextField(
                    controller: searchController,
                    style: interSemiBoldLarge.copyWith(color: MyColor.colorBlack,decorationColor:MyColor.primaryColor),
                    decoration: InputDecoration(
                      hintText: MyStrings.searchCountry.tr,
                      hintStyle: interSemiBoldLarge.copyWith(color: MyColor.getGreyText(),decorationColor:MyColor.primaryColor),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.borderColor,width: 1),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSize25)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.primaryColor,width: 1), borderRadius: BorderRadius.circular(Dimensions.paddingSize25)),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.borderColor,width: 1), borderRadius: BorderRadius.circular(Dimensions.paddingSize25)),

                      contentPadding: const EdgeInsets.symmetric(vertical: 15), // Adjust height by changing vertical padding
                    ),
                    onChanged: (value) {
                      // Update the filtered country list
                      setState(() {
                        filteredCountryList = controller.countryList.where((country) {
                          return country.country!.toLowerCase().contains(value.toLowerCase());
                        }).toList();
                      });
                    },
                  ),


                  const SizedBox(height: 15),

                  // Country List
                  Flexible(
                    child: ListView.builder(
                      itemCount: filteredCountryList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.countryController.text = filteredCountryList[index].country ?? '';
                              controller.setCountryNameAndCode(
                                filteredCountryList[index].country ?? '',
                                filteredCountryList[index].countryCode ?? '',
                                filteredCountryList[index].dialCode ?? '',
                              );

                              Navigator.pop(context);
                              controller.setMobileFocus();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: MyColor.getCardBg(),
                                border: Border.all(width: 0.5, color: MyColor.primaryColor.withOpacity(0.1)),
                                boxShadow: MyUtil.getBottomSheetShadow(),
                              ),
                              child: Text(
                                '+${filteredCountryList[index].dialCode}  ${filteredCountryList[index].country.toString().tr}',
                                style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


}