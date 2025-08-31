import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class DashboardAnimatedButtonWithText extends StatefulWidget {

  final Widget child;
  final VoidCallback onTap;
  final String buttonName;
  final double height, width;
  final Color backgroundColor;

  const DashboardAnimatedButtonWithText({
    Key? key,
    required this.buttonName,
    required this.child,
    required this.onTap,
    required this.height,
    required this.width,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<DashboardAnimatedButtonWithText> createState() => _DashboardAnimatedButtonWithText();
}

class _DashboardAnimatedButtonWithText extends State<DashboardAnimatedButtonWithText> with SingleTickerProviderStateMixin{

  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _scale = 1 - _controller.value;

    return  Center(
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: _tapDown,
        onTapUp: _tapUp,
        child: Transform.scale(
          scale: _scale,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the children in the Row
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: MyColor.appPrimaryColorSecondary2,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: Dimensions.space10),
                          _animatedButton(),
                          const SizedBox(width: Dimensions.space10),
                          Text(widget.buttonName.tr, textAlign: TextAlign.center, style: interRegularDefault.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w600, fontSize: Dimensions.fontMediumLarge)),
                        ],
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

      ),
    );
  }

  Widget  _animatedButton() {
    return Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            shape: BoxShape.circle
        ),
        child: widget.child
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }
  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}