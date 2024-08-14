import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/deposit/deposit_history_controller.dart';
import 'package:eastern_trust/views/components/text-field/search_text_field.dart';

class DepositHistoryTop extends StatefulWidget {
  const DepositHistoryTop({Key? key}) : super(key: key);

  @override
  State<DepositHistoryTop> createState() => _DepositHistoryTopState();
}

class _DepositHistoryTopState extends State<DepositHistoryTop> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DepositController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.symmetric(horizontal:  Dimensions.space15,vertical: Dimensions.space15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
          color: MyColor.getCardBg(),
          boxShadow: MyUtil.getBottomSheetShadow(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(MyStrings.transactionNumber.tr, style: interRegularSmall.copyWith(color: MyColor.labelTextColor, fontWeight: FontWeight.w500)),
            const SizedBox(height: Dimensions.space5 + 3),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: SearchTextField(
                        needOutlineBorder: true,
                        controller: controller.searchController,
                        onChanged: (value){
                          return;
                        },
                        hintText: 'Enter TRX No',
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimensions.space10),
                  InkWell(
                    onTap: () {
                      controller.searchDepositTrx();
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10),
                        color: MyColor.primaryColor,
                      ),
                      child: const Icon(Icons.search_outlined, color:  MyColor.colorWhite, size: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
