import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/fdr/fdr_list_controller.dart';
import 'package:eastern_trust/views/components/alert-dialog/warning_alert_dialog.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';
import '../../../../components/column/bottom_sheet_column.dart';

class FdrListBottomSheet{

   void bottomSheet(BuildContext context, int index){
     CustomBottomSheet(child: GetBuilder<FDRListController>(builder: (controller)=>Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         const BottomSheetTopRow(header: MyStrings.fdrDetails),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Expanded(
                 flex: 1,
                 child: BottomSheetColumn(
                   header: MyStrings.plan,
                   body: controller.fdrList[index].plan?.name??'',
                 )
             ),
             Expanded(
               flex: 1,
               child: BottomSheetColumn(
                 alignmentEnd: true,
                 header: MyStrings.fdrNo,
                 body: controller.fdrList[index].fdrNumber??'',
               )
             ),
           ],
         ),

         const SizedBox(height: Dimensions.space20),

         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Expanded(
               flex: 1,
               child: BottomSheetColumn(
                 header: MyStrings.amount,
                 body: '${controller.currencySymbol}${Converter.formatNumber(controller.fdrList[index].amount??'')}',
               )
             ),
             Expanded(
                 flex: 1,
                 child: BottomSheetColumn(
                   alignmentEnd: true,
                   header: MyStrings.profit,
                   body: '${controller.currencySymbol}${Converter.formatNumber(controller.fdrList[index].profit??'')}',
                 )
             ),
           ],
         ),

         const SizedBox(height: Dimensions.space20),

         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Expanded(
                 flex: 1,
                 child: BottomSheetColumn(
                   header: MyStrings.nextInstallment,
                   body: DateConverter.isoStringToLocalDateOnly(controller.fdrList[index].nextInstallmentDate??''),
                 )
             ),
             Expanded(
                 flex: 1,
                 child: BottomSheetColumn(
                   alignmentEnd: true,
                   header: MyStrings.lockInPeriod,
                   body: DateConverter.nextReturnTime(controller.fdrList[index].lockedDate??''),
                 )
             ),
           ],
         ),
         const WidgetDivider(),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Visibility(
               visible: controller.canClose(index),
               child: Expanded(
                 child: controller.isCloseFDRLoading?const RoundedLoadingBtn():
                 RoundedButton(
                     color:MyColor.colorBlack,
                     textColor:MyColor.colorWhite,
                     text:MyStrings.closed,
                     press: () {
                       showDialog(context: context, builder: (context){
                         return WarningAlertDialog(
                           header: MyStrings.closeThisFdr,
                           body: MyStrings.closeFDRMsg,
                             onPressed: (){
                              controller.closeFDR(index);
                              Get.back();
                             });
                       });
                     }),
               ),
             ),
             SizedBox(width:controller.canClose(index)?Dimensions.space15:0),
             Expanded(child: RoundedButton(
                 color:MyColor.primaryColor,
                 text:MyStrings.installments,
                 press: () {
                   String dpsNumber = controller.fdrList[index].fdrNumber??'';
                   Get.toNamed(RouteHelper.fdrInstallmentLogScreen,arguments: dpsNumber);
                 }))
           ],
         )
       ],
     ))).customBottomSheet(context);
  }
}