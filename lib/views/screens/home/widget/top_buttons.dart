import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/data/controller/home/home_controller.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState123 extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return controller.moduleList.length == 8
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Expanded(child: controller.moduleList[0]),
                    Expanded(child: controller.moduleList[2]),
                    Expanded(child: controller.moduleList[3]),
                    Expanded(child: controller.moduleList[4]),

                  ],
                ),
                const SizedBox(height: Dimensions.space20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Expanded(child: controller.moduleList[4]),
                    // Expanded(child: controller.moduleList[5]),
                    // Expanded(child: controller.moduleList[6]),
                    // Expanded(child: controller.moduleList[7]),
                  ],
                )
              ],
            )
          : controller.moduleList.length == 4
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(child: controller.moduleList[0]),
              Expanded(child: controller.moduleList[2]),
              Expanded(child: controller.moduleList[3]),
              // Expanded(child: controller.moduleList[4]),

            ],
          ),
          const SizedBox(height: Dimensions.space20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(child: controller.moduleList[4]),
              // Expanded(child: controller.moduleList[5]),
              // Expanded(child: controller.moduleList[6]),
              // Expanded(child: controller.moduleList[7]),
            ],
          )
        ],
      )
          : controller.moduleList.length == 6
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(child: controller.moduleList[0]),
              Expanded(child: controller.moduleList[2]),
              Expanded(child: controller.moduleList[3]),
              Expanded(child: controller.moduleList[4]),
              Expanded(child: controller.moduleList[5]),

            ],
          ),
          const SizedBox(height: Dimensions.space20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(child: controller.moduleList[4]),
              // Expanded(child: controller.moduleList[5]),
              // Expanded(child: controller.moduleList[6]),
              // Expanded(child: controller.moduleList[7]),
            ],
          )
        ],
      )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.moduleList.length > 4
                    ? Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          ...controller.moduleList
                              .getRange(0, 4)
                              .map((item) => SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            32 -
                                            24) /
                                        4,
                                    // 32 is the total horizontal padding, 24 is the total horizontal spacing
                                    child: item,
                                  ))
                              .toList(),
                          ...controller.moduleList
                              .getRange(4, controller.moduleList.length)
                              .map((item) => SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            32 -
                                            24) /
                                        4,
                                    child: item,
                                  ))
                              .toList(),
                        ],
                      )
                    : controller.moduleList.length == 4
                    ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Expanded(child: controller.moduleList[0]),
                              // Expanded(child: controller.moduleList[1]),
                              Expanded(child: controller.moduleList[2]),
                              Expanded(child: controller.moduleList[3]),
                              // Expanded(child: controller.moduleList[4]),
                            ],
                          )
                    : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: controller.moduleList[0]),
                              Expanded(child: controller.moduleList[1]),
                              Expanded(
                                child:controller.moduleList.length==3?controller.moduleList[2]:const SizedBox(),
                              ),
                              const Expanded(
                                child:SizedBox(),
                              ),
                            ],
                          ),
              ],
            );
    });
  }
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      final moduleList = controller.moduleList;

      if (moduleList.isEmpty) return const SizedBox();

      // Adjust the number of items per row here 👇
      const int itemsPerRow = 3;
      final double totalSpacing = 24.0; // total spacing between items in a row
      final double horizontalPadding = 32.0; // left + right padding
      final double itemWidth = (MediaQuery.of(context).size.width -
          horizontalPadding -
          totalSpacing) /
          itemsPerRow;

      // Split list into multiple rows
      List<Row> rows = [];
      for (int i = 0; i < moduleList.length; i += itemsPerRow) {
        final rowItems = moduleList.skip(i).take(itemsPerRow).toList();
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowItems
                .map(
                  (item) => SizedBox(width: itemWidth, child: item),
            )
                .toList(),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i != rows.length - 1)
              const SizedBox(height: Dimensions.space20),
          ],
          const SizedBox(height: Dimensions.space20),
        ],
      );
    });
  }
}
