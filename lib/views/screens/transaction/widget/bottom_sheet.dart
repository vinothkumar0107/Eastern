import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/transaction/transaction_controller.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';

showTrxBottomSheet(List<String>? list, int callFrom,String header, {required BuildContext context}){

  if (list != null && list.isNotEmpty) {
    CustomBottomSheet(
      backgroundColor: MyColor.getScreenBgColor1(),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetTopRow(header: header,bgColor: MyColor.colorWhite,),
        SizedBox(
          child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      String selectedValue = list[index];
                      final controller= Get.find<TransactionController>();
                      if(callFrom==1){
                        controller.changeSelectedTrxType(selectedValue);
                        controller.filterData();
                      }else if(callFrom==2){
                        controller.changeSelectedRemark(selectedValue);
                        controller.filterData();
                      }
                      Navigator.pop(context);
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.getCardBg()
                      ),
                      child: Text(
                        ' ${callFrom ==2 ? Converter.replaceUnderscoreWithSpace(list[index].capitalizeFirst??''):list[index]}',
                        style: interRegularDefault.copyWith(fontSize: Dimensions.fontDefault),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    )).customBottomSheet(context);
  }
}