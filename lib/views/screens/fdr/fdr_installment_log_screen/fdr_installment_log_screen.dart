import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/fdr/fdr_installment_log_controller.dart';
import 'package:eastern_trust/data/repo/fdr/fdr_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found.dart';
import 'package:eastern_trust/views/screens/fdr/fdr_installment_log_screen/widget/bottom_sheet.dart';
import 'package:eastern_trust/views/screens/loan/loan_installment_log/widget/installment_log_list_item.dart';

class FDRInstallmentLogScreen extends StatefulWidget {

  const FDRInstallmentLogScreen({Key? key}) : super(key: key);

  @override
  State<FDRInstallmentLogScreen> createState() => _FDRInstallmentLogScreenState();
}

class _FDRInstallmentLogScreenState extends State<FDRInstallmentLogScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<FDRInstallmentLogController>().hasNext()){
        Get.find<FDRInstallmentLogController>().loadPaginationData();
      }
    }
  }


  @override
  void initState() {
    String trxId = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FDRRepo(apiClient: Get.find()));
    final controller = Get.put(FDRInstallmentLogController(fdrRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fdrId = trxId;
      controller.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<FDRInstallmentLogController>(builder: (controller)=>Scaffold(
        backgroundColor: MyColor.getScreenBgColor1(),
        appBar: CustomAppBar(title: MyStrings.fdrInstallments,isShowActionBtn:true,actionIcon: Icons.info_outline,actionText: MyStrings.fdrInfo,press: (){
          FDRInstallmentBottomSheet().bottomSheet(context);
        },),
        body: controller.isLoading?const CustomLoader() : controller.installmentLogList.isEmpty?const NoDataWidget():Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(Dimensions.screenPadding),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            itemCount: controller.installmentLogList.length+1,
            separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
            itemBuilder: (context, index){
              if(controller.installmentLogList.length==index){
                return controller.hasNext()?const CustomLoader(isPagination:true): const SizedBox();
              }
              return InstallmentLogItem(
                  serialNumber: '${index+1}',
                  installmentDate: controller.installmentLogList[index].installmentDate??'',
                  giveOnDate: controller.installmentLogList[index].givenAt??'',
                  delay: DateConverter.delayDate(controller.installmentLogList[index].installmentDate,controller.installmentLogList[index].givenAt)
              );
            },
          ),
        ),
      ))
    );
  }
}
