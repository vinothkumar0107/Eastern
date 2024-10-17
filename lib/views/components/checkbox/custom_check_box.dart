import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class CustomCheckBox extends StatefulWidget {

  final List<String>?  selectedValue;
  final List<String> list;
  final ValueChanged? onChanged;
  final double fontSize;

  const CustomCheckBox({Key? key,
    this.selectedValue,
    required this.list,
    this.onChanged,
    this.fontSize = 15.0}) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {


  @override
  Widget build(BuildContext context) {

    if(widget.list.isEmpty){
      return Container();
    }
    return Column(
      children: [
        Column(
            children: List<CheckboxListTile>.generate(
                widget.list.length,
                    (int index){
                  List<String>?s=widget.selectedValue;
                  bool selected_=s!=null?s.contains(widget.list[index]):false;
                  return CheckboxListTile(
                    value: selected_,
                    activeColor: MyColor.primaryColor,
                    title: Text(widget.list[index].tr,style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontSize: widget.fontSize)),
                    onChanged: (bool? value) {
                      setState((){
                        if(value!=null){
                          widget.onChanged!('${index}_$value');
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
