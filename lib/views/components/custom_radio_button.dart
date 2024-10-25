import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/my_color.dart';
import '../../core/utils/style.dart';

class CustomRadioButton extends StatefulWidget {

  final String? title, selectedValue;
  final int selectedIndex;
  final List<String> list;
  final ValueChanged? onChanged;
  final double fontSize;

  const CustomRadioButton({Key? key,
    this.title,
    this.selectedIndex=0,
    this.selectedValue,
    required this.list,
    this.onChanged,
    this.fontSize = 15}) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {


  @override
  Widget build(BuildContext context) {

    if(widget.list.isEmpty){
      return Container();
    }
    return Column(
      children: [
        widget.title!=null?const SizedBox():Text(widget.title??''),
        Column(
            children: List<RadioListTile<int>>.generate(
                widget.list.length,
                    (int index){
                  return RadioListTile<int>(
                    value: index,
                    groupValue: widget.selectedIndex,
                    title: Text(
                      widget.list[index].tr,
                      style: interRegularDefault.copyWith(color: MyColor.colorBlack ,fontSize: widget.fontSize
                      ),

                    ),
                    selected: index==widget.selectedIndex,
                    activeColor: MyColor.primaryColor,
                    onChanged: (int? value) {
                      setState((){
                        if(value!=null){
                          widget.onChanged!(index);
                        }

                      });
                    },
                  );
                }
            )
        ),
      ],
    );
  }
}
