import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/views/components/divider/custom_divider.dart';

class LatestTransactionListItem extends StatelessWidget {

  final String trx;
  final String date;
  final String amount;
  final String postBalance;
  final String currency;
  final VoidCallback onPressed;
  final bool isShowDivider;
  final bool isCredit;

  const LatestTransactionListItem({
    Key? key,
    required this.onPressed,
    required this.isCredit,
    required this.trx,
    required this.date,
    required this.amount,
    required this.postBalance,
    this.isShowDivider = false,
    this.currency = ''
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
          onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: MyColor.liteGreyColorBorder, // Border color
              width: 1.0, // Border width
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 10, // Blur radius
                offset: const Offset(0, 3), // Shadow offset
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 35, width: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: isCredit?MyColor.greenSuccessColor.withOpacity(0.17):MyColor.colorRed.withOpacity(0.2),
                              shape: BoxShape.circle
                          ),
                          child: isCredit?Image.asset(MyImages.greenArrowUp, height: 20, width: 20,fit: BoxFit.cover,):Image.asset(MyImages.redArrowDown, height: 20, width: 20,fit: BoxFit.cover,)
                      ),
                      const SizedBox(width: Dimensions.space12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(trx,
                            style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600, fontSize: Dimensions.fontLarge),
                          ),
                          const SizedBox(height: Dimensions.space10),
                          SizedBox(
                            width: 150,
                            child: Text(
                              date,
                              style: interRegularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.5), fontSize: Dimensions.fontDefault),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Flexible(
                    child: Text(
                        amount,
                        overflow: TextOverflow.ellipsis,
                        style: interRegularDefault.copyWith(color: isCredit?MyColor.greenSuccessColor: MyColor.colorRed, fontWeight: FontWeight.w600)
                    ),
                  )
                ],
              ),
              isShowDivider?
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.space5),
                child:  CustomDivider(space: 20,borderColor: MyColor.bgColor1,),
              ): const SizedBox(height: Dimensions.space20)
            ],
          ),
        )
      );
  }
}
