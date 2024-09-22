import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';



class CustomDropDownTextField extends StatefulWidget {
  final String? title, selectedValue;
  final List<String>? list;
  final ValueChanged? onChanged;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  const CustomDropDownTextField({Key? key,
    this.title,
    this.selectedValue,
    this.list,
    this.backgroundColor = MyColor.liteGreyColor,
    this.borderColor = MyColor.liteGreyColorBorder,
    this.borderWidth = 0.5,
    this.onChanged, }) : super(key: key);

  @override
  State<CustomDropDownTextField> createState() => _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    widget.list?.removeWhere((element) => element.isEmpty);
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:45,
            decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius:const  BorderRadius.all(Radius.circular(Dimensions.paddingSize25)),
              border: Border.all(color: widget.borderColor,width: widget.borderWidth)
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left:20,
                  right: 10,
                  top: 5,
                  bottom: 5
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                hint: Text(
                  widget.selectedValue??'',
                  style:interRegularLarge.copyWith(color: MyColor.getTextColor(),  fontSize: Dimensions.fontDefault),
                ), // Not necessary for Option 1
                value: widget.selectedValue,
                dropdownColor: MyColor.colorGrey1,
                onChanged: widget.onChanged,
                icon: const Icon(Icons.arrow_drop_down,color: MyColor.colorGrey,),
                items: widget.list!.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value.tr,
                      style: interRegularLarge.copyWith(color:MyColor.colorBlack),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
