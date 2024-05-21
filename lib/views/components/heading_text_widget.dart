import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

import 'text/header_text.dart';


class HeadingTextWidget extends StatelessWidget {
  final String header;
  final String body;
  const HeadingTextWidget({Key? key,required this.header,required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height *.025,
        ), // 4%
         HeaderText(text: header),
        const SizedBox(height: 5,),
        Text(body.tr,style: interRegularDefault.copyWith(color: MyColor.colorWhite),),
        SizedBox(
          height: MediaQuery.of(context).size.height *.03,
        ),
      ],
    );
  }
}
