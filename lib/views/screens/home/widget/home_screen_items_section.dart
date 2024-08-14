import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/data/controller/home/home_controller.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';
import 'package:eastern_trust/views/screens/home/widget/latest_transaction_list_item.dart';
import 'package:eastern_trust/views/screens/home/widget/top_buttons.dart';

import 'latest_transaction.dart';

class HomeScreenItemsSection extends StatefulWidget {

  const HomeScreenItemsSection({Key? key}) : super(key: key);

  @override
  State<HomeScreenItemsSection> createState() => _HomeScreenItemsSectionState();
}

class _HomeScreenItemsSectionState extends State<HomeScreenItemsSection> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        decoration: BoxDecoration(
          color: MyColor.getCardBg(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TopButtons(),
              const SizedBox(height: Dimensions.space15),
              const LatestTransaction(),
              controller.debitsLists.isEmpty ? const NoDataWidget(topMargin: 60) : ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: controller.debitsLists.length,
                itemBuilder: (context, index) => LatestTransactionListItem(
                  isShowDivider:false,
                  isCredit:controller.debitsLists[index].trxType=='+'?true:false,
                  trx: controller.debitsLists[index].trx ?? "",
                  date: '${DateConverter.isoStringToLocalDateOnly(controller.debitsLists[index].createdAt ?? "")}, ${DateConverter.isoStringToLocalTimeOnly(controller.debitsLists[index].createdAt ?? "")}',
                  amount: "${controller.currencySymbol}${Converter.formatNumber(controller.debitsLists[index].amount ?? "")}",
                  postBalance: "${Converter.formatNumber(controller.debitsLists[index].postBalance ?? "")} ${controller.currency}",
                  onPressed: (){

                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
