import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';

class CustomAmountTextField extends StatefulWidget {

  const CustomAmountTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.chargeText='',
    required this.currency,
    required this.onChanged,
    this.autoFocus = false,
    this.required = false,
    this.inputAction,
  }) : super(key: key);

  final String chargeText;
  final String labelText;
  final String hintText;
  final String currency;
  final bool autoFocus;
  final bool required;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final TextInputAction? inputAction;

  @override
  State<CustomAmountTextField> createState() => _CustomAmountTextFieldState();
}

class _CustomAmountTextFieldState extends State<CustomAmountTextField> {

  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText(text: widget.labelText.tr,required: widget.required),
        const SizedBox(height: 8),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: 8),
          decoration: BoxDecoration(
            color: MyColor.transparentColor,
            border: Border.all(color: isFocus ? MyColor.primaryColor : MyColor.borderColor, width: 1),
            borderRadius: BorderRadius.circular(25)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: FocusScope(
                  child: Focus(
                    onFocusChange: (focus){
                      setState(() {
                        isFocus = focus;
                      });
                    },
                    child: TextField(
                      cursorColor: MyColor.primaryColor,
                      controller: widget.controller,
                      autofocus: widget.autoFocus,
                      style: interRegularLarge.copyWith(color: MyColor.colorBlack, fontSize: Dimensions.fontDefault),
                      //textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      textInputAction: widget.inputAction,
                      onChanged: widget.onChanged,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 13),
                          hintText: widget.hintText.tr,
                          hintStyle: interRegularDefault.copyWith(color: MyColor.getGreyText(), fontWeight: FontWeight.w500),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 48,
                padding: const EdgeInsets.all(Dimensions.space5),
                decoration: BoxDecoration(color: MyColor.transparentColor, borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: Text(widget.currency.tr, textAlign: TextAlign.center, style: interRegularDefault.copyWith(color: MyColor.fieldDisableBorderColor, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
