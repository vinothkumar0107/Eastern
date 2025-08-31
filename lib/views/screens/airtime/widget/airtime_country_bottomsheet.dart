import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/airtime/airtime_controller.dart';

import '../../../components/custom_cash_network_image.dart';
import '../../../components/image_loader.dart';
import '../../../components/no_data/no_data_found.dart';

class AirtimeCountryBottomSheet{

  static void bottomSheet(BuildContext context, AirtimeController controller){
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
                  child: controller.countryList.isNotEmpty ? ListView.builder(itemCount:controller.countryList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                    print(controller.countryList[index].flagUrl);
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              controller.onCountryTap(controller.countryList[index]);
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
                              child: Row(
                                children: [
                                  SvgPicture.network(
                                    width: 20,
                                    height: 20,
                                    placeholderBuilder: (context) => const CustomImageLoader(),
                                    controller.countryList[index].flagUrl ?? ""
                                  ),
                                  const SizedBox(width: Dimensions.space10,),
                                  Text(
                                      controller.countryList[index].name.toString().tr,
                                      style: interRegularDefault.copyWith(color: MyColor.getTextColor())
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      ) : const NoDataWidget(title: MyStrings.comingSoon,isNeedHeight: true,imageHeight: 0,fontSize: Dimensions.fontHeader1,),
                )
              ],
            ),
          );
        }
    );
  }
}