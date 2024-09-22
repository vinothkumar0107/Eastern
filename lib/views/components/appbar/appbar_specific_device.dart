

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/my_color.dart';



class AppBarSpecificScreen {

  static PreferredSizeWidget? buildAppBar() {
    if (Platform.isAndroid || Platform.isIOS) {
      return AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 0, // Hides the toolbar height
        foregroundColor: MyColor.primaryColor2,
        backgroundColor: MyColor.primaryColor2,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: MyColor.primaryColor2,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: MyColor.navigationBarColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      return null; // No AppBar on iOS
    }
  }
}


class GradientView extends StatefulWidget {
  final double gradientViewHeight;
  final bool isStaticHeight;
  final double staticHeightGradient;

  const GradientView({
    Key? key,
    this.gradientViewHeight = 3.5,
    this.isStaticHeight = false,
    this.staticHeightGradient = 0,
  }) : super(key: key);


  @override
  State<GradientView> createState() => _GradientViewState();
}

class _GradientViewState extends State<GradientView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.isStaticHeight ? widget.staticHeightGradient:MediaQuery.of(context).size.height / widget.gradientViewHeight, // Half of the screen height
          decoration: BoxDecoration(
            gradient: MyColor.getBackgroundGradient(),
          ),
        ),
        Expanded(
          child: Container(
            color: MyColor.getScreenBgColor2(), // Use the same color for the bottom half
          ),
        ),
      ],
    );
  }
}

