import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';


class ChooseFileItem extends StatelessWidget {
  final String fileName;
  const ChooseFileItem({Key? key,required this.fileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: 8),
      decoration: BoxDecoration(
          color: MyColor.liteGreyColor,
          borderRadius:const  BorderRadius.all(Radius.circular(Dimensions.paddingSize25)),
          border: Border.all(color: MyColor.borderColor,width: 1.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: 3),
            decoration: BoxDecoration(color:MyColor.primaryColor600, borderRadius: BorderRadius.circular(Dimensions.paddingSize25)),
            alignment: Alignment.center,
            child: Text(MyStrings.chooseFile.tr, textAlign: TextAlign.center, style: interRegularDefault.copyWith(color: MyColor.getPrimaryColor(), fontWeight: FontWeight.w500, fontSize: Dimensions.fontSmall12)),
          ),
          const SizedBox(width: Dimensions.space15,),
          Expanded(
            flex: 5,
            child: TextField(
              readOnly: true,
              cursorColor: MyColor.getTextColor(),
              style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: fileName.tr),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 16),
                  hintText: fileName.tr,
                  hintStyle: interRegularSmall.copyWith(color: MyColor.hintTextColor, height: 1.452,overflow: TextOverflow.ellipsis),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none
              ),
            ),
          ),

        ],
      ),
    );
  }
}
