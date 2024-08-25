import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/transfer/wire_transfer_controller.dart';
import 'package:eastern_trust/data/repo/transfer_repo/transfer_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/screens/transfer/wire_transfer_screen/widget/wire_transfer_form.dart';



class WireTransferScreen extends StatefulWidget {
  const WireTransferScreen({Key? key}) : super(key: key);

  @override
  State<WireTransferScreen> createState() => _WireTransferScreenState();
}

class _WireTransferScreenState extends State<WireTransferScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransferRepo(apiClient: Get.find()));
    final controller = Get.put(WireTransferController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
    });

  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<WireTransferController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.getScreenBgColor1(),
      appBar: const CustomAppBar(title: MyStrings.wireTransfer, isTitleCenter: false,),
      body: controller.isLoading? const CustomLoader():controller.noInternet?
      NoDataFoundScreen(isNoInternet: true,
          press: (value){
            controller.initData();
            controller.changeNoInternetStatus(false);
          }):
      SingleChildScrollView(
        child: Container(
          padding: Dimensions.screenPaddingHV,
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: Dimensions.space15),
              WireTransferForm()
            ],
          ),
        ),
      ),
    ));
  }

}
