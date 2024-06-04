import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRadioButton extends StatefulWidget {

  final String? title, selectedValue;
  final int selectedIndex;
  final List<String> list;
  final ValueChanged? onChanged;

  const CustomRadioButton({Key? key,
    this.title,
    this.selectedIndex=0,
    this.selectedValue,
    required this.list,
    this.onChanged, }) : super(key: key);

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
                    title: Text(widget.list[index].tr),
                    selected: index==widget.selectedIndex,
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
