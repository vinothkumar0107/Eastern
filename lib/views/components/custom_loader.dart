import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'indicator/indicator.dart';

class CustomLoader extends StatelessWidget {

  final bool isFullScreen;
  final bool isPagination;
  final double strokeWidth;
  final bool circularLoader;

  const CustomLoader({
    Key? key,
    this.isFullScreen = false,
    this.isPagination = false,
    this.strokeWidth = 1,
    this.circularLoader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFullScreen?SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: SpinKitThreeBounce(
          color: MyColor.primaryColor,
          size: 18.0,
        )
      ),
    ):circularLoader ? Center(
        child: SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(color: MyColor.colorWhite,strokeWidth: strokeWidth)
        )
    ): isPagination?Center(child: Padding(
        padding: const EdgeInsets.all(10),
        child: LoadingIndicator(strokeWidth: strokeWidth,))):
    const Center(
      child: SpinKitThreeBounce(
        color: MyColor.primaryColor,
        size: 18.0,
      )
    );
  }
}
