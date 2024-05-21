import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/views/components/circle_widget/circle_button_with_icon.dart';
import 'package:eastern_trust/views/components/column/label_column.dart';


class OtherBankBeneficiaryListItem extends StatelessWidget {

  final VoidCallback press;
  final String accountName;
  final String accountNumber;
  final String shortName;
  final String bankName;
  final String image;
  final int index;


  const OtherBankBeneficiaryListItem({
    Key? key,
    required this.press,
    required this.accountName,
    required this.accountNumber,
    required this.shortName,
    required this.bankName,
    required this.image,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
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
                Row(
                  children: [
                    CircleButtonWithIcon(
                      isAsset: true,
                      isIcon: false,
                      bg: MyColor.transparentColor,
                      borderColor: Colors.transparent,
                      press: () {},
                      circleSize: 20,
                      imageSize: 20,
                      padding: 0,
                      imagePath:image,
                    ),
                    const SizedBox(width: Dimensions.space5,),
                    Text(shortName,style: interSemiBoldSmall.copyWith(fontSize: Dimensions.fontLarge,fontWeight: FontWeight.w500),),
                  ],
                ),
                Text(bankName,style: interSemiBoldSmall.copyWith(fontSize: Dimensions.fontLarge,fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: Dimensions.space15,),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Expanded(flex: 5, child: LabelColumn(header: MyStrings.accountNumber, body: accountNumber)),
                 const SizedBox(width: 20),
                 LabelColumn(alignmentEnd:true,header: MyStrings.accountName, body: accountName),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
