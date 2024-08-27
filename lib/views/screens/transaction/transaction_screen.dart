import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/transaction/transaction_controller.dart';
import 'package:eastern_trust/data/repo/account/transaction_log_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/transaction/widget/bottom_sheet.dart';
import 'package:eastern_trust/views/screens/transaction/widget/custom_transaction_card.dart';
import 'package:eastern_trust/views/screens/transaction/widget/filter_row_widget.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<TransactionController>().loadTransaction();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<TransactionController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller = Get.put(TransactionController(transactionRepo: Get.find()));

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
    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: GetBuilder<TransactionController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.containerBgColor,
          appBar: AppBar(
            backgroundColor: MyColor.primaryColor,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [MyColor.primaryColor2, MyColor.primaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            centerTitle: true,
            leading: const SizedBox(),
            title: Text(MyStrings.transactionHistory.tr, style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite)),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: Dimensions.space15),
                child: GestureDetector(
                  onTap: (){
                    controller.changeSearchIcon();
                  },
                  child: Container(
                    height: 30, width: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
                    child: controller.isSearch ? const Icon(
                        Icons.clear,
                        color: MyColor.primaryColor,
                        size: 15
                    ) : Image.asset(
                        MyImages.filter,
                        color: MyColor.primaryColor,
                        height: 15, width: 15
                    ),
                  ),
                ),
              )
            ],
          ),
          body: controller.isLoading ? const CustomLoader() : Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: controller.isSearch,
                  child: Container(
                    padding:  const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                    margin: const EdgeInsets.only(bottom: Dimensions.cardMargin),
                    decoration: BoxDecoration(
                        color: MyColor.getCardBg(),
                        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                        boxShadow: MyUtil.getBottomSheetShadow()
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelText(text:MyStrings.type, textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400)),
                                  const SizedBox(height: Dimensions.space10),
                                  SizedBox(
                                    height: 40,
                                    child: FilterRowWidget(
                                        fromTrx: true,
                                        bgColor: Colors.transparent,
                                        text: controller.selectedTrxType.isEmpty ? MyStrings.trxType : controller.selectedTrxType,
                                        press: () {
                                          showTrxBottomSheet(controller.transactionTypeList,1,MyStrings.selectTrxType,context: context);
                                        }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: Dimensions.space15),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelText(text:MyStrings.remark, textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400)),
                                  const SizedBox(height: Dimensions.space10),
                                  SizedBox(
                                    height: 40,
                                    child: FilterRowWidget(
                                        fromTrx: true,
                                        bgColor: Colors.transparent,
                                        text: Converter.replaceUnderscoreWithSpace(controller.selectedRemark.isEmpty? MyStrings.any : controller.selectedRemark),
                                        press: () {
                                          showTrxBottomSheet(controller.remarksList.map((e) => e.remark.toString()).toList(),2,MyStrings.selectRemarks,context: context);
                                        }
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.space15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelText(text: MyStrings.trxNo, textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400)),
                                  const SizedBox(height: Dimensions.space10),
                                  SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      cursorColor: MyColor.primaryColor,
                                      style: interSemiBoldDefault.copyWith(color: MyColor.colorBlack, fontSize: Dimensions.fontSize14),
                                      keyboardType: TextInputType.text,
                                      controller: controller.trxController,
                                      decoration: InputDecoration(
                                          hintText: 'Enter TRX No',
                                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                          hintStyle: interMediumDefault.copyWith(color: MyColor.bodyTextColor, fontSize: Dimensions.fontSize14),
                                          filled: true,
                                          fillColor: MyColor.transparentColor,
                                          border: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.colorGrey, width: 0.5),
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.colorGrey, width: 0.5),
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.primaryColor, width: 0.5),
                                              borderRadius: BorderRadius.all(Radius.circular(20.0)))
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: Dimensions.space10),
                            InkWell(
                              onTap: () {
                                controller.filterData();
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                padding:
                                const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    color: MyColor.primaryColor,
                                ),
                                child: const Icon(
                                    Icons.search_outlined,
                                    color: MyColor.colorWhite,
                                    size: 18
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                    child: controller.transactionList.isEmpty && controller.filterLoading == false ? const Center(
                      child: NoDataFoundScreen(),
                    ):  controller.filterLoading ? const CustomLoader() :
                    Container(
                      padding: EdgeInsets.only(left: Dimensions.paddingSize15, right: Dimensions.paddingSize15, top: controller.isSearch?0:Dimensions.paddingSize15),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.transactionList.length + 1,
                          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                          itemBuilder: (context, index){
                            if(controller.transactionList.length == index){
                              return controller.hasNext() ? Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(5),
                                  child: const CustomLoader()
                              ) : const SizedBox();
                            }
                            return  GestureDetector(
                              onTap: (){
                                controller.changeExpandIndex(index);
                              },
                              child: CustomTransactionCard(
                                  index: index,
                                  expandIndex:controller.expandIndex,
                                  trxType: controller.transactionList[index].trxType??'',
                                  detailsText: controller.transactionList[index].details ?? "",
                                  trxData: controller.transactionList[index].trx ?? "",
                                  dateData: DateConverter.isoToLocalDateAndTime(controller.transactionList[index].createdAt ?? ""),
                                  amountData: "${controller.transactionList[index].trxType} ${Converter.formatNumber(controller.transactionList[index].amount.toString())} ${controller.transactionList[index].currency??''}",
                                  postBalanceData: "${Converter.formatNumber(controller.transactionList[index].postBalance.toString())} ${controller.transactionList[index].currency??''}"
                              ),
                            );
                          },
                        ),
                      )
                    ),
                    )
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
        ),
      ),
    );
  }


}
