import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/data/controller/home/home_controller.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
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
                    Expanded(child: controller.moduleList[1]),
                    Expanded(child: controller.moduleList[3]),
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
                              Expanded(child: controller.moduleList[1]),
                              Expanded(child: controller.moduleList[2]),
                              Expanded(child: controller.moduleList[3]),
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
