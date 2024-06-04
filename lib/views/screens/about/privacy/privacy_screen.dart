import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/privacy/privacy_controller.dart';
import 'package:eastern_trust/data/repo/privacy_repo/privacy_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/animated_widget/expanded_widget.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/category_button.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';


class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PrivacyRepo(apiClient: Get.find()));
    final controller = Get.put(PrivacyController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.containerBgColor,
        appBar: const CustomAppBar(
          title: MyStrings.policies,
          isShowActionBtn: false,
        ),
        body: GetBuilder<PrivacyController>(
          builder: (controller) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const CustomLoader()
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space20),
                  child: SizedBox(
                    height: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          controller.policyList.length,
                              (index) => Row(
                            children: [
                              CategoryButton(
                                  color: controller.selectedIndex == index
                                      ? MyColor.primaryColor
                                      : MyColor.colorWhite,
                                  horizontalPadding: 8,
                                  verticalPadding: 7,
                                  textSize: Dimensions.fontDefault,
                                  text: controller.policyList[index].dataValues?.title ?? '',
                                  textColor: controller.selectedIndex == index
                                      ? MyColor.colorWhite:MyColor.colorBlack,
                                  press: () {
                                    controller.changeIndex(index);
                                  }),
                              const SizedBox(width: Dimensions.space10)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space10),
                Expanded(
                    child:  SingleChildScrollView(
                        child: ExpandedSection(
                        expand: true,
                        child:  Container(
                            padding: const EdgeInsets.all(Dimensions.space15),
                            width: double.infinity,
                            child: HtmlWidget(
                                controller.selectedHtml,
                                textStyle: interRegularDefault.copyWith(color: MyColor.textColor),
                                onLoadingBuilder: (context, element, loadingProgress) => const CustomLoader(isFullScreen: true,)
                            )
                        )
                    )
                  )
                )
              ],
            ),
          ),
        )
    );
  }
}
