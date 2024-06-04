import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/transfer/other_bank_transfer_controller.dart';
import 'package:eastern_trust/views/components/divider/custom_divider.dart';
import 'package:eastern_trust/views/screens/transfer/other_bank_transfer_screen/widget/other_bank_details_bottom_sheet.dart';

import '../../../../components/column/label_column.dart';
import 'other_bank_transfer_bottom_sheet.dart';

class TransferOtherBankListItem extends StatelessWidget {


  final String shortName;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final bool isExpand;
  final int index;

  const TransferOtherBankListItem({
    Key? key,
    required this.shortName,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.index,
    this.isExpand = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherBankTransferController>(builder: (controller)=>InkWell(
      onTap: (){
        OtherBankTransferDetailsBottomSheet().showSheet(context, index);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.cardMargin),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12),
        decoration: BoxDecoration(color: MyColor.colorWhite,boxShadow: MyUtil.getCardShadow(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelColumn(header: MyStrings.accountName, body: accountName),
                LabelColumn(alignmentEnd:true,header: MyStrings.shortName, body: shortName)
              ],
            ),
            const CustomDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelColumn(header: MyStrings.bank, body: bankName),
                    InkWell(
                      onTap: (){
                        OtherBankTransferBottomSheet().transferBottomSheet(context, index);
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
                    ),
                  ],
                ),
          ],
        ),
      ),
    ));
  }
}
