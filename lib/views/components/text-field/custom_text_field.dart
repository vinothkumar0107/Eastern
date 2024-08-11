import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';

class CustomTextField extends StatefulWidget {

  final String? labelText;
  final String? hintText;
  final String? suffixText;
  final Function? onChanged;
  final Function? onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool needLabel;
  final bool readOnly;
  final bool isRequired;
  final String prefixText;
  final Color disableColor;
  final int maxiLines;

 const CustomTextField({
    Key? key,
    this.labelText,
    this.suffixText,
    this.readOnly = false,
    required this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.needLabel = true,
    this.prefixText = '',
    this.disableColor =  MyColor.borderColor,
    this.isRequired = false,
    this.maxiLines = 1

  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return widget.needOutlineBorder ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.needLabel ? LabelText(text: widget.labelText.toString(),required: widget.isRequired,) : const SizedBox(),
        widget.needLabel?const SizedBox(height: Dimensions.textToTextSpace): const SizedBox(),
        TextFormField(
          readOnly: widget.readOnly,
          style: interRegularDefault.copyWith(color: MyColor.colorBlack),
          cursorColor: MyColor.primaryColor,
          controller: widget.controller,
          autofocus: false,
          textInputAction: widget.inputAction,
          enabled: widget.isEnable,
          focusNode: widget.focusNode,
          validator: widget.validator,
          keyboardType: widget.textInputType,
          obscureText: widget.isPassword?obscureText:false,
          maxLines: widget.maxiLines,
          decoration: InputDecoration(
            errorMaxLines: 2,
            isDense: false,
            prefixIcon: widget.prefixText.isEmpty?null:Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(color: MyColor.primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius)
              ),
              child: Text(widget.prefixText,style: interRegularDefault.copyWith(color:MyColor.primaryColor),),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
            hintText: widget.hintText!=null?widget.hintText!.tr:'',
            hintStyle: interRegularSmall.copyWith(color: MyColor.getGreyText()),
            fillColor: MyColor.colorWhite,
            filled: true,
            border: OutlineInputBorder(borderSide: BorderSide(color: widget.disableColor,width: .5),
                borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.primaryColor,width: 1), borderRadius: BorderRadius.circular(Dimensions.paddingSize25)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.disableColor,width: 1), borderRadius: BorderRadius.circular(Dimensions.paddingSize25)),
            suffixIcon: widget.isShowSuffixIcon
                ? widget.isPassword
                ? IconButton(
                icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.getGreyText(), size: 16),
                onPressed: _toggle)
                : widget.isIcon
                ? IconButton(
              onPressed: widget.onSuffixTap,
              icon:  Icon(
                widget.isSearch ? Icons.search_outlined : widget.isCountryPicker ? Icons.arrow_drop_down_outlined:Icons.camera_alt_outlined,
                size: 25,
                color: MyColor.primaryColor,
              ),
            )
                : widget.suffixText != null ? Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(widget.suffixText ?? "",style: interMediumDefault,textAlign: TextAlign.center),
                ) : Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(color: MyColor.getPrimaryColor(),
                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
              child: Text(widget.prefixText,style: interRegularDefault.copyWith(color:MyColor.colorWhite),))
                : null,
          ),
          onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
          onChanged: (text)=> widget.onChanged!(text),
        )
      ],
    ) : TextFormField(
      readOnly: widget.readOnly,
      style: interRegularDefault.copyWith(color: MyColor.colorWhite),
      cursorColor: MyColor.colorWhite,
      controller: widget.controller,
      autofocus: false,
      textInputAction: widget.inputAction,
      enabled: widget.isEnable,
      focusNode: widget.focusNode,
      validator: widget.validator,
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword?obscureText:false,
      maxLines: widget.maxiLines,
      decoration: InputDecoration(
        errorMaxLines: 2,
        prefixIcon: widget.prefixText.isEmpty?null:Container(
          width: 60,
          decoration: BoxDecoration(color:MyColor.colorWhite,
              border:Border(bottom: BorderSide(color: MyColor.colorWhite))),
          child: Align(
            alignment: Alignment.center,
              child: Text(widget.prefixText,style: interRegularDefault.copyWith(color:MyColor.primaryColor),)),
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
        labelText:  widget.labelText?.tr,
        labelStyle: interRegularDefault.copyWith(color: MyColor.colorWhite),
        hintStyle: interRegularSmall.copyWith(color: MyColor.colorWhite),
        fillColor: MyColor.transparentColor,
        filled: true,
        border: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.borderColor)),
        disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: widget.disableColor)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.primaryColor)),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.borderColor)),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
            ? IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.colorWhite, size: 16),
            onPressed: _toggle)
            : widget.isIcon
            ? IconButton(
          onPressed: widget.onSuffixTap,
          icon:  Icon(
            widget.isSearch ? Icons.search_outlined : widget.isCountryPicker ? Icons.arrow_drop_down_outlined:Icons.camera_alt_outlined,
            size: 25,
            color: MyColor.primaryColor,
          ),
        )
            : null
            : null,
      ),
      onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) :widget.onSubmitted!=null?widget.onSubmitted!(text):null,
      onChanged: (text)=> widget.onChanged!(text),
    );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}