import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import '../../../core/utils/dimensions.dart';

class OTPFieldWidget extends StatelessWidget {
  const OTPFieldWidget({Key? key,required this.onChanged}) : super(key: key);

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: interRegularDefault.copyWith(color: MyColor.getTextColor()),
        length: 6,
        textStyle: interRegularDefault.copyWith(color: MyColor.getTextColor()),
        obscureText: false,
        obscuringCharacter: '*',
        blinkWhenObscuring: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderWidth: 1,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 40,
            fieldWidth: 40,
            inactiveColor:  MyColor.getBorderColor(),
            inactiveFillColor: MyColor.transparentColor,
            activeFillColor: MyColor.transparentColor,
            activeColor: MyColor.getPrimaryColor(),
            selectedFillColor: MyColor.containerBgColor,
            selectedColor: MyColor.primaryColor
        ),
        cursorColor: MyColor.colorBlack,
        animationDuration:
        const Duration(milliseconds: 100),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        beforeTextPaste: (text) {
          return true;
        },
        onChanged: (value) => onChanged!(value),
      ),
    );
  }
}
