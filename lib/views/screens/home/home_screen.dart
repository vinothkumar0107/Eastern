import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/data/controller/home/home_controller.dart';
import 'package:eastern_trust/data/repo/home/home_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/home/widget/home_screen_items_section.dart';
import 'package:eastern_trust/views/screens/home/widget/home_screen_top.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// before remove
class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(HomeController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
      controller.updateScrollStatus();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Screen is visible again
      final controller = Get.find<HomeController>();
      controller.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double notchHeight = MediaQuery.of(context).padding.top;
    bool hasNotch = notchHeight > 0;
    double appBarHeightDynamic =
    notchHeight > 55 ? 40 : notchHeight > 50 ? 50 : notchHeight > 45 ? 45 : 70;
    double appBarHeight = hasNotch ? 120 + appBarHeightDynamic : 160;

    return GetBuilder<HomeController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: Scaffold(
          backgroundColor: MyColor.colorWhite,
          body: controller.isLoading
              ? const CustomLoader()
              : controller.noInternet
              ? NoDataFoundScreen(
            isNoInternet: true,
            press: (value) {
              if (value) {
                controller.changeNoInternetStatus(false);
                controller.loadData();
              }
            },
          )
              : SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              color: MyColor.primaryColor,
              backgroundColor: MyColor.colorWhite,
              onRefresh: () async {
                await controller.loadData();
              },
              child: CustomScrollView(
                controller: scrollController,
                physics: controller.isContentScrollable
                    ? const ClampingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                slivers: [
                  /// 🔹 SliverAppBar with TradingViewTicker on top
                  SliverAppBar(
                    pinned: false,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    expandedHeight: controller.homeTopModuleList.isEmpty
                        ? 120
                        : appBarHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColor.primaryColor2,
                              MyColor.primaryColor,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          left: Dimensions.space15,
                          right: Dimensions.space15,
                          top: Dimensions.space60,
                          bottom: Dimensions.space10,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// Existing top widget
                            const Expanded(
                              child: HomeScreenTop(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Main content
                  SliverToBoxAdapter(
                    child: Transform.translate(
                      offset: const Offset(0, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: MyColor.colorWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: const HomeScreenItemsSection(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
        ),
      ),
    );
  }
}


