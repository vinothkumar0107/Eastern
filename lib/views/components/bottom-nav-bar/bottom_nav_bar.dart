import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class CustomBottomNav extends StatefulWidget {

  final int currentIndex;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex
  }) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {

  var bottomNavIndex = 0;

  List<String> iconList = [MyImages.homeIcon, MyImages.supportIcon, MyImages.transferIcon2, MyImages.historyIcon, MyImages.menuIcon];
  final textList = [MyStrings.home, MyStrings.support, MyStrings.transfer,MyStrings.history, MyStrings.menu];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      height: 65,
      elevation: 10,
      shadow:Shadow(
        color: MyColor.colorGrey2,
        offset: Offset(0, 2), // horizontal & vertical offset of shadow
        blurRadius: 2,        // softness of shadow
      ),
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconList[index],
              height: 18, width: 18,
              color: isActive ? MyColor.primaryColor : MyColor.colorGrey,
            ),
            const SizedBox(height: Dimensions.space5),
            Text(
              textList[index].tr,
              style: interRegularExtraSmall.copyWith(color: isActive ? MyColor.primaryColor : MyColor.colorGrey, fontWeight: FontWeight.w600, fontSize: Dimensions.fontDefault)
            )
          ],
        );
      },
      backgroundColor: MyColor.colorWhite,
      gapLocation: GapLocation.none,
      leftCornerRadius: 0,
      rightCornerRadius: 0,
      onTap: (index) {
        _onTap(index);
      },
      activeIndex: bottomNavIndex,
    );
  }

  void _onTap(int index) {
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAndToNamed(RouteHelper.homeScreen);
      }
    }
    else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.offAndToNamed(RouteHelper.ticketScreen);
      }
    }
    else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.offAndToNamed(RouteHelper.transferScreen);
      }
    }
    else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.offAndToNamed(RouteHelper.transactionScreen);
      }
    }
    else if (index == 4) {
      if (!(widget.currentIndex == 4)) {
        Get.offAndToNamed(RouteHelper.menuScreen);
      }
    }
  }

}
