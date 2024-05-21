import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_icons.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';


class AlreadyVerifiedWidget extends StatefulWidget {
  final bool isPending;
  const AlreadyVerifiedWidget({Key? key,this.isPending=false}) : super(key: key);

  @override
  State<AlreadyVerifiedWidget> createState() => _AlreadyVerifiedWidgetState();
}

class _AlreadyVerifiedWidgetState extends State<AlreadyVerifiedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:  const EdgeInsets.all(Dimensions.space20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColor.getScreenBgColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(widget.isPending?MyIcons.pendingIcon:MyIcons.verifiedIcon,height: 100,width: 100,fit: BoxFit.cover,),
          const SizedBox(height: 25,),
          Text(widget.isPending?MyStrings.kycUnderReviewMsg.tr:MyStrings.kycAlreadyVerifiedMsg.tr,style: interRegularDefault.copyWith(color: MyColor.getTextColor(),fontSize: Dimensions.fontExtraLarge,)),
          const SizedBox(height: 40,)
        ],
      ),
    );
  }
}
