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

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(HomeController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    // Get the top padding (notch height)
    double notchHeight = MediaQuery.of(context).padding.top;

    // Check if there's a notch by verifying the top padding
    bool hasNotch = notchHeight > 0;

    // Adjust height based on whether the device has a notch or not
    double appBarHeightDynamic = notchHeight > 55 ? 40 : notchHeight > 50 ? 50 :  notchHeight > 45 ? 45 : 70;
    double appBarHeight = hasNotch ? 120 + appBarHeightDynamic : 160;

    return GetBuilder<HomeController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: Scaffold(
          backgroundColor: controller.isLoading ? MyColor.colorWhite : MyColor.colorWhite,
          body: controller.isLoading ? const CustomLoader() : controller.noInternet?
          NoDataFoundScreen(
            isNoInternet: true,
            press:(value){
              if(value){
                controller.changeNoInternetStatus(false);
                controller.loadData();
              }
            },
          ) :SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(color: MyColor.primaryColor,
              backgroundColor: MyColor.colorWhite,
              onRefresh: () async {
                await controller.loadData();
              },
              child: CustomScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent, // Set backgroundColor to transparent to avoid any color conflicts
                    expandedHeight: appBarHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [MyColor.primaryColor2, MyColor.primaryColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          left: Dimensions.space15,
                          right: Dimensions.space15,
                          top: Dimensions.space60,
                        ),
                        child: const HomeScreenTop(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Transform.translate(
                        offset: const Offset(0, 0), // If need change x, y position
                        child: Container(
                            decoration: const BoxDecoration(
                              color: MyColor.colorWhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: const HomeScreenItemsSection()
                        )
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
