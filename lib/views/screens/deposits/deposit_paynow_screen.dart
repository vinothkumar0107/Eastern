import 'package:eastern_trust/data/controller/deposit/deposite_paynow_controller.dart';
import 'package:eastern_trust/views/screens/deposits/widget/deposit_paynow_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/deposit/deposit_history_controller.dart';
import '../../../data/model/authorized/deposit/deposit_insert_response_model.dart';
import '../../../data/model/authorized/deposit/deposit_method_response_model.dart';
import '../../../data/repo/deposit/deposit_repo.dart';
import '../../../data/services/api_service.dart';
import '../../components/animated_widget/expanded_widget.dart';
import '../../components/appbar/appbar_specific_device.dart';
import '../../components/bottom_sheet/custom_bottom_notification.dart';
import '../../components/buttons/rounded_button.dart';
import '../../components/buttons/rounded_loading_button.dart';
import '../../components/custom_loader.dart';
import '../../components/will_pop_widget.dart';


class DepositsPayNowScreen extends StatefulWidget {
  final DepositInsertResponseModel depositInsertModel;
  final Methods? paymentMethod;
  const DepositsPayNowScreen({Key? key,
    required this.depositInsertModel,
    required this.paymentMethod}) : super(key: key);

  @override
  State<DepositsPayNowScreen> createState() => _DepositsPayNowScreenState();
}

class _DepositsPayNowScreenState extends State<DepositsPayNowScreen> {

  final ScrollController scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  bool isForm = true;
  // for test will be removed
  final String htmlData = '<div style=\"text-align: center;\"><span style=\"font-weight: bolder;\"><span style=\"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; text-align: start;\"><font color=\"#0099ff\"><br></font></span></span></div><div style=\"text-align: center;\"><div dir=\"ltr\" style=\"border: 0px; font-style: inherit; font-variant: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; margin: 0px; padding: 0px; vertical-align: baseline;\"><b style=\"\"><font color=\"#0066ff\">0x2949Da9Af081d99dc0CF0e36aCc06982712A03C4</font></b></div></div><div style=\"text-align: center;\"><span style=\"font-size: 1rem; text-align: var(--bs-body-text-align);\"><font color=\"#000000\">Please make a deposit to this wallet, your account shall be funded within 3 hours maximum depending on network and blockchain confirmation.</font></span><br></div><div style=\"text-align: center;\"><span style=\"color: var(--bs-body-color); font-size: 1rem; text-align: var(--bs-body-text-align);\"><br></span></div><div style=\"text-align: center;\"><span style=\"font-weight: bolder;\"><span style=\"font-size: 1rem; text-align: var(--bs-body-text-align);\"><font color=\"#000000\">Scan QR Code</font></span></span></div><div style=\"text-align: center;\"><span style=\"font-weight: bolder;\"><span style=\"color: var(--bs-body-color); font-size: 1rem; text-align: var(--bs-body-text-align);\"><br></span></span></div><div style=\"text-align: center;\"><img src=\"https://i.imgur.com/Pt1Ilh3.jpeg\" width=\"819\"><span style=\"font-weight: bolder;\"><span style=\"color: var(--bs-body-color); font-size: 1rem; text-align: var(--bs-body-text-align);\"><br></span></span></div>';
  String? qrData = '';
  String? currency = "USD";
  String? finalAmt = "";
  List<Field> updatedFields = [];

  @override
  void initState() {
    isForm = widget.depositInsertModel.data?.deposit?.methodCode == "1000" ? true : false;
    currency = widget.depositInsertModel.data?.deposit?.methodCurrency;
    finalAmt = widget.depositInsertModel.data?.deposit?.finalAmount;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    Get.put(DepositPayNowController(depositRepo: Get.find()));
    final controller = Get.put(DepositPayNowController(depositRepo: Get.find()));
    qrData = widget.depositInsertModel.data?.formData?.gateway?.description;
    updateFieldsForm();
    controller.formList = updatedFields;

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });

  }

  void updateFieldsForm(){
    if (widget.depositInsertModel.data?.fields?.isNotEmpty ?? false){
      widget.depositInsertModel.data?.fields?.forEach((element) {
        if (element.type == 'select') {
          bool? isEmpty = element.options?.isEmpty;
          bool empty = isEmpty ?? true;
          if (element.options != null && empty != true) {
            element.options?.insert(0, MyStrings.selectOne);
            element.selectedValue = element.options?.first;
            updatedFields.add(element);
          }
        }else{
          updatedFields.add(element);
        }
      });
    }
  }

  @override
  void dispose() {
    Get.find<DepositPayNowController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositPayNowController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBarSpecificScreen.buildAppBar(),
            backgroundColor: MyColor.appPrimaryColorSecondary2,
            body: Stack(
              children: [
                const GradientView(gradientViewHeight: 6.5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Text(
                            MyStrings.deposit,
                            textAlign: TextAlign.left,
                            style: interBoldOverLarge.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)
                        ),
                      ),
                      // To keep the title centered, you can add an empty `SizedBox`
                      const SizedBox(width: 48.0),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,  // Makes the card take up the full width
                              child: Card(
                                color: MyColor.colorWhite,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "$currency $finalAmt",
                                        style: interSemiBoldLarge.copyWith(
                                          color: MyColor.green,
                                          fontSize: Dimensions.fontHeader1,
                                        ),
                                      ),
                                      Text(
                                        "${widget.paymentMethod?.name}",
                                        style: interMediumLarge.copyWith(
                                          color: MyColor.colorBlack,
                                          fontSize: Dimensions.fontSmall12,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Standing processing time is 3 banking days",
                                        style: interMediumLarge.copyWith(
                                          color: MyColor.colorGrey,
                                          fontSize: Dimensions.fontSmall,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.space10),
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                color: MyColor.colorWhite,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      !isForm ? ExpandedSection(
                                          expand: true,
                                          child:  Container(
                                              padding: const EdgeInsets.all(Dimensions.space15),
                                              width: double.infinity,
                                              child: HtmlWidget(
                                                  qrData ?? " ",
                                                  textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack),
                                                  onLoadingBuilder: (context, element, loadingProgress) => const CustomLoader(isFullScreen: true,)
                                              )
                                          )
                                      ) : const SizedBox.shrink(),
                                      DepositPayNowForm(depositInsertModel: widget.depositInsertModel),
                                    ],

                                  )
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.space10),
                            controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                              press: () {
                                controller.submitKycData(context, widget.depositInsertModel.data?.formData?.trx ?? "");
                                // if(formKey.currentState!.validate()){
                                //   showCustomBottomSheetNotification(
                                //     context: context,
                                //     icon: 'tick',
                                //     title: 'Success', message: 'Your operation was completed successfully.',
                                //     buttonText: 'Done',
                                //     onButtonPressed: () {
                                //       Navigator.pop(context);
                                //       // Navigator.pop(context);
                                //     },
                                //   );
                                //
                                //
                                // }
                              },
                              text: MyStrings.payNow.tr,
                              textColor: MyColor.colorWhite,
                              color: MyColor.appPrimaryColorSecondary2,
                            ),
                            const SizedBox(height: Dimensions.space20),
                             // Add spacing if needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}