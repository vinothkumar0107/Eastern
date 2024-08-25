import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/transfer/other_bank_transfer_controller.dart';
import 'package:eastern_trust/data/repo/transfer_repo/beneficiaries_repo/beneficiaries_repo.dart';
import 'package:eastern_trust/data/repo/transfer_repo/transfer_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/screens/transfer/other_bank_transfer_screen/widget/other_bank_list_item.dart';

import 'widget/add_other_bank_beneficiary_bottom_sheet.dart';

class TransferOtherBankScreen extends StatefulWidget {

  const TransferOtherBankScreen({Key? key}) : super(key: key);

  @override
  State<TransferOtherBankScreen> createState() => _TransferOtherBankScreenState();
}

class _TransferOtherBankScreenState extends State<TransferOtherBankScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<OtherBankTransferController>().hasNext()){
        Get.find<OtherBankTransferController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BeneficiaryRepo(apiClient: Get.find()));
    Get.put(TransferRepo(apiClient: Get.find()));
    final controller = Get.put(OtherBankTransferController(repo: Get.find(),beneficiaryRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {

    return GetBuilder<OtherBankTransferController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.containerBgColor,
      appBar: CustomAppBar(title: MyStrings.transferToOtherBank,  isShowActionBtn: true,
          isTitleCenter: false,
          press: (){
            AddOtherBankBeneficiariesBottomSheet().showBottomSheet(context);
          },
          actionText: MyStrings.addNew,actionIcon: Icons.add,isActionIconAlignEnd: false),
      body: controller.isLoading?const CustomLoader():controller.beneficiaryList.isEmpty?const NoDataFoundScreen():Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.screenPaddingH, vertical: Dimensions.screenPaddingV),
          child: ListView.builder(
              controller: scrollController,
              itemCount: controller.beneficiaryList.length+1,
              itemBuilder: (context,index){

                if (index == controller.beneficiaryList.length) {
                  return controller.hasNext()
                      ? const CustomLoader(isPagination: true,)
                      : const SizedBox();
                }
                return TransferOtherBankListItem(
                    shortName: controller.beneficiaryList[index].shortName??'',
                    accountName: controller.beneficiaryList[index].accountName??'',
                    accountNumber: controller.beneficiaryList[index].accountNumber??'',
                    bankName: controller.beneficiaryList[index].beneficiaryOf?.name??'',
                    index: index
                );
              })
      ),
    ));
  }
}
