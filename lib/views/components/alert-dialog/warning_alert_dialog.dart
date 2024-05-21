import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/divider/custom_divider.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:eastern_trust/views/components/text/default_text.dart';

class WarningAlertDialog extends StatelessWidget {

  final VoidCallback onPressed;
  final String header;
  final String body;
  const WarningAlertDialog({Key? key,this.header='',this.body = '', required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(

      insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space40 * 1.5),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius * 2)),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),// use this scroll physics for removing height  issues
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius * 2)
          ),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SvgPicture.asset(MyImages.warningIcon, height: 50, width: 50),
              BottomSheetTopRow(header: header,bottomSpace: 0,),
              const CustomDivider(space: 20,),
              DefaultText(text: body,textColor: Colors.black,),
              const CustomDivider(space: 20,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Expanded(
                   child: RoundedButton(
                     verticalPadding: 12,
                     press:(){
                       Get.back();
                     },
                     text: MyStrings.no,
                     color: MyColor.redCancelTextColor,
                   ),
                 ),
                const SizedBox(width: 20,),
                Expanded(child:  RoundedButton(
                  verticalPadding: 12,
                  press: onPressed,
                  text: MyStrings.yes,
                )),
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
