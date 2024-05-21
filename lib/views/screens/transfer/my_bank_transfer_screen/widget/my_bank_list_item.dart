import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:eastern_trust/views/components/column/card_column.dart';
import 'package:eastern_trust/views/components/divider/custom_divider.dart';

import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/style.dart';
import 'my_bank_transfer_bottom_sheet.dart';

class MyBankTransferListItem extends StatelessWidget {

  final String accountName;
  final String accountNumber;
  final String shortName;
  final int index;

  const MyBankTransferListItem({
    Key? key,
    required this.accountName,
    required this.accountNumber,
    required this.shortName,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBankTransferController>(builder: (controller)=>InkWell(
      onTap: (){

      },
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.cardMargin),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12),
        decoration: BoxDecoration(
          color: MyColor.colorWhite,
          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
          boxShadow: MyUtil.getCardShadow()
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardColumn(header: MyStrings.accountName, body: accountName),
                CardColumn(alignmentEnd:true,header: MyStrings.shortName, body: shortName)
              ],
            ),
            const CustomDivider(),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                    CardColumn(header: MyStrings.accountNumber, body: accountNumber),
                    const SizedBox(width: 35),
                    InkWell(
                      onTap: (){
                        MyBankTransferBottomSheet().transferBottomSheet(context, index);
                     },
                   child: Container(
                     padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                         color: MyColor.primaryColor),
                     child:Row(
                       children: [
                         SvgPicture.asset(
                           MyImages.sendIcon,
                           color: MyColor.textColor,
                           height: 11,width: 11,
                         ),
                         const SizedBox(width: Dimensions.space7),
                         Text(
                           MyStrings.transfer.tr,
                           style: interRegularDefault.copyWith(color: MyColor.colorWhite,fontSize: Dimensions.fontSmall12),
                         )
                       ],
                     )
                   ),
                 )
                  ],
                ),
          ],
        ),
      ),
    ));
  }
}
