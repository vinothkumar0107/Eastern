import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/utils/my_color.dart';
import 'indicator/indicator.dart';

class CustomImageLoader extends StatelessWidget {

  final bool isFullScreen;
  final bool isPagination;
  final double strokeWidth;
  final Color loaderColor;
  final double loaderSize;

  const CustomImageLoader({
    Key? key,
    this.isFullScreen = false,
    this.isPagination = false,
    this.strokeWidth = 1,
    this.loaderColor = MyColor.primaryColor,
    this.loaderSize = 20
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFullScreen ? SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: SpinKitThreeBounce(
            color: loaderColor,
            size: loaderSize,
          )
      ),
    ):
    isPagination?Center(child: Padding(
        padding: const EdgeInsets.all(10),
        child: LoadingIndicator(strokeWidth: strokeWidth,))): Center(
        child: SpinKitFadingCube(
          color: loaderColor,
          size: loaderSize,
        )
    );
  }
}
