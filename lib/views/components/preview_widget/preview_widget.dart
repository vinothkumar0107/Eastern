import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import '../../../core/utils/dimensions.dart';

class PreviewWidget extends StatefulWidget {

  final String? header;
  final String? header2;
  final List<Widget>previewItem;
  final int initialView;
  final Color bgColor;

  const PreviewWidget({
    Key? key,
    this.header,
    this.header2,
    required this.previewItem,
    this.initialView = 2,
    this.bgColor = Colors.transparent
  }) : super(key: key);

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.bgColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.header!=null && widget.header2!=null?Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
            decoration: const BoxDecoration(
              color: MyColor.primaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
            ), child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.header.toString().tr,style: interSemiBold.copyWith(fontSize: Dimensions.fontLarge,color: MyColor.colorWhite)),
                  widget.header2!=null?Text(widget.header2.toString().tr,style: interRegularDefault.copyWith(color: MyColor.colorRed),):const SizedBox(),
                ],
              )): const SizedBox.shrink(),

          const SizedBox(height: 25,),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.previewItem.length,
              itemBuilder: (context,index){
                return widget.previewItem[index];
              }),
          ),
        ],
      ),
    );
  }
}
