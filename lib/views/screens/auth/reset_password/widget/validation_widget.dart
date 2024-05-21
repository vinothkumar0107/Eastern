
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/data/model/auth/error_model.dart';
import 'validation_chip_widget.dart';


class ValidationWidget extends StatelessWidget {

  final List<ErrorModel>list;
  final bool fromReset;

  const ValidationWidget({Key? key,required this.list,this.fromReset = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 6),
        Wrap(
          children: list
              .map((item) =>  ChipWidget(name: item.text.tr,hasError: item.hasError,)
          ).toList(),
        ),
        fromReset?const SizedBox(height: Dimensions.textFieldToTextFieldSpace,):const SizedBox()
      ],
    );
  }
}
