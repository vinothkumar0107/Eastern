import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_icons.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/alert-dialog/exit_dialog.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  final bool isShowBackBtn;
  final bool isShowActionBtn;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;
  final String actionText;
  final IconData actionIcon;
  final VoidCallback? press;
  final bool isActionIconAlignEnd;
  final Color bgColor;
  final bool isForceBackHome;
  final bool isNeedActionButtonText;


  const CustomAppBar(
      {Key? key,
      this.isProfileCompleted = false,
      this.fromAuth = false,
      this.isTitleCenter = true,
      this.isShowBackBtn = true,
      required this.title,
      this.actionText = '',
      this.actionIcon= Icons.format_list_bulleted,
      this.press,
      this.bgColor = MyColor.primaryColor,
      this.isActionIconAlignEnd = false,
      this.isForceBackHome = false,
      this.isShowActionBtn = false,
      this.isNeedActionButtonText = false})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification = false;

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn
        ?
    AppBar(
      scrolledUnderElevation: 0,
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: MyColor.primaryColor2,
      //     statusBarIconBrightness: Brightness.light,
      //     systemNavigationBarColor: MyColor.navigationBarColor,
      //     systemNavigationBarIconBrightness: Brightness.dark),
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
      leading: widget.isShowBackBtn
          ? IconButton(
          onPressed: () {
            if (widget.fromAuth) {
              Get.offAllNamed(RouteHelper.loginScreen);
            } else if (widget.isProfileCompleted) {
              showExitDialog(Get.context!);
            } else {
              String previousRoute = Get.previousRoute;
              if (previousRoute == '/splash-screen' || widget.isForceBackHome == true) {
                Get.offAndToNamed(RouteHelper.homeScreen);
              } else {
                Get.back();
              }
            }
          },
          icon: const Icon(Icons.arrow_back,
              color: MyColor.colorWhite, size: 20))
          : const SizedBox.shrink(),
      backgroundColor: MyColor.primaryColor,
      titleSpacing: 0,
      title: Text(widget.title.tr,
          style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite)),
      centerTitle: widget.isTitleCenter,
      actions: [
        widget.isShowActionBtn
            ? widget.isNeedActionButtonText ? Row(
          mainAxisAlignment: MainAxisAlignment.end, // Aligns the button to the right
          children: [
            Container(
              height: 25,
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5), // Margin around the button
              padding: const EdgeInsets.symmetric(horizontal: 0), // Horizontal padding inside the button
              decoration: BoxDecoration(
                color: MyColor.colorWhite, // Background color of the button
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: TextButton(
                onPressed: widget.press,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15), // Add padding to align the text properly
                  minimumSize: Size.zero, // Ensures no minimum size constraint
                  alignment: Alignment.center, // Center the text inside the button
                ),
                child: Text(
                  widget.actionText,
                  style: interRegularDefault.copyWith(
                    color: MyColor.red, // Customize text color
                  ),
                ),
              ),
            ),
          ],
        )
            : GestureDetector(
          onTap: widget.press,
          child: Container(
            margin: const EdgeInsetsDirectional.only(end: 7,bottom: 7,top: 7),
            padding: const EdgeInsets.all(Dimensions.space7),
            decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
            child:  Icon(widget.actionIcon, color: MyColor.primaryColor, size: 15),
          ),
        ) : const SizedBox.shrink(),
        const SizedBox(
          width: 10,
        )
      ],
    )
        :
    AppBar(
      scrolledUnderElevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [MyColor.primaryColor2, MyColor.primaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: MyColor.primaryColor,
      //     statusBarIconBrightness: Brightness.light,
      //     systemNavigationBarColor: MyColor.navigationBarColor,
      //     systemNavigationBarIconBrightness: Brightness.dark),
      elevation: 0,
      backgroundColor: widget.bgColor,
      centerTitle: widget.isTitleCenter,
      titleSpacing: 0,
      title: Text(widget.title.tr,
          style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite)),
      actions: [
        widget.isShowActionBtn
            ? widget.isNeedActionButtonText ?
        Row(
          mainAxisAlignment: MainAxisAlignment.end, // Aligns the button to the right
          children: [
            Container(
              height: 25,
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5), // Margin around the button
              padding: const EdgeInsets.symmetric(horizontal: 0), // Horizontal padding inside the button
              decoration: BoxDecoration(
                color: MyColor.colorWhite, // Background color of the button
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: TextButton(
                onPressed: widget.press,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15), // Add padding to align the text properly
                  minimumSize: Size.zero, // Ensures no minimum size constraint
                  alignment: Alignment.center, // Center the text inside the button
                ),
                child: Text(
                  widget.actionText,
                  style: interRegularDefault.copyWith(
                    color: MyColor.red, // Customize text color
                  ),
                ),
              ),
            ),
          ],
        ) :
        InkWell(
            onTap: () {
              Get.toNamed(RouteHelper.notificationScreen)
                  ?.then((value) {
                setState(() {
                  hasNotification = false;
                });
              });
            },
            child: SvgPicture.asset(
              hasNotification
                  ? MyIcons.activeNotificationIcon
                  : MyIcons.inActiveNotificationIcon,
              height: 28,
              width: 28,
            ))
            : const SizedBox.shrink(),
        const SizedBox(width: 10)
      ],
      automaticallyImplyLeading: false,
    );
  }
}
