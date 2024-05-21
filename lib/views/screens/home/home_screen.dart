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
    return GetBuilder<HomeController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: SafeArea(
          child: Scaffold(
              backgroundColor: MyColor.colorWhite,
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
                      backgroundColor:  MyColor.primaryColor,
                      expandedHeight: 90,
                      flexibleSpace:  FlexibleSpaceBar(
                      background: Container(
                          decoration: const BoxDecoration(
                            color: MyColor.primaryColor,
                            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(Dimensions.space15),bottomRight:Radius.circular(Dimensions.space15))
                          ),
                          padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space20),
                          child: const HomeScreenTop(),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: MyColor.colorWhite,
                        ),
                        child: const HomeScreenItemsSection()
                      )
                    )
                  ],
            ),
                ),
              ),
            bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
          ),
        ),
      ),
    );
  }
}
