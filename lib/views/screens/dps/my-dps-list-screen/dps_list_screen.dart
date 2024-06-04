import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/dps/dps_list_controller.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/column/bottom_sheet_column.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';

import 'widget/list_card.dart';

class DPSListScreen extends StatefulWidget {

  const DPSListScreen({Key? key}) : super(key: key);

  @override
  State<DPSListScreen> createState() => _DPSListScreenState();
}

class _DPSListScreenState extends State<DPSListScreen> {


  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<DPSListController>().hasNext()){
        Get.find<DPSListController>().loadPaginationData();
      }
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DPSListController>(builder: (controller)=>
    controller.isLoading?const CustomLoader():controller.dpsList.isEmpty?const NoDataWidget():ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      controller: scrollController,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.dpsList.length+1,
      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
      itemBuilder: (context, index) {
        if(controller.dpsList.length==index){
          return controller.hasNext()?const CustomLoader(isPagination:true): const SizedBox();
        }
        return DPSListCard(
          onPressed: () {
            CustomBottomSheet(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BottomSheetTopRow(header: MyStrings.dpsInformation),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: BottomSheetColumn(header: MyStrings.amount, body: '${controller.currencySymbol}${Converter.formatNumber(controller.dpsList[index].perInstallment??'')}') ),
                    Expanded(
                      flex: 5,
                      child: BottomSheetColumn(alignmentEnd:true,header: MyStrings.payInstallment, body: "${MyStrings.per} ${controller.dpsList[index].installmentInterval} ${MyStrings.days}".tr) ),
                  ],
                ),
                const SizedBox(height: Dimensions.space20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: BottomSheetColumn(header: MyStrings.totalInstallment, body: controller.dpsList[index].totalInstallment??'') ),
                    Expanded(
                      flex: 5,
                      child: BottomSheetColumn(alignmentEnd:true,header: MyStrings.givenInstallment, body: controller.dpsList[index].givenInstallment??'') ),
                  ],
                ),
                const SizedBox(height: Dimensions.space20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child:BottomSheetColumn(header: MyStrings.interestRate, body: '${Converter.roundDoubleAndRemoveTrailingZero(controller.dpsList[index].interestRate??'0')}%') ),
                    Expanded(
                      flex: 5,
                      child:BottomSheetColumn(alignmentEnd:true,header: MyStrings.nextInstallment, body: DateConverter.isoStringToLocalDateOnly(controller.dpsList[index].nextInstallment?.installmentDate??'')) ),
                  ],
                ),
                const SizedBox(height: Dimensions.space20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child:BottomSheetColumn(header: MyStrings.afterMatureYouGet,
                          body: "${controller.currencySymbol}${Converter.formatNumber(controller.dpsList[index].plan?.finalAmount??'')}") ),
                  ],
                ),
                const SizedBox(height: Dimensions.space30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: controller.isWithdrawEnable(index),
                      child: Expanded(
                        child: controller.isWithdrawLoading?
                        const RoundedLoadingBtn():RoundedButton(
                            color:MyColor.colorBlack,
                            textColor:MyColor.colorWhite,
                            text:MyStrings.withdraw,
                            press: () {
                               controller.makeDPSWithdraw(index);
                            }),
                      ),
                    ),
                    const SizedBox(width:Dimensions.space15),
                    Expanded(child: RoundedButton(
                      color:MyColor.primaryColor,
                      text:MyStrings.installments,
                      press: () {
                        String dpsNumber = controller.dpsList[index].dpsNumber??'';
                        Get.toNamed(RouteHelper.dpsInstallmentLogScreen,arguments: dpsNumber);
                      }))
                  ],
                )
              ],
            )).customBottomSheet(context);
          },
          statusColor:  controller.getStatusAndColor(index,isStatus: false),
          currency: controller.currency,
          plan: controller.dpsList[index].plan?.name??'',
          status: controller.getStatusAndColor(index),
          amount: controller.dpsList[index].perInstallment??'',
          dpsNumber: controller.dpsList[index].dpsNumber??'',
        );
      }
    ),
    );
  }
}