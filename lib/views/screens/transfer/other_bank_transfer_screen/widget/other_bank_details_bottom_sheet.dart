import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/transfer/other_bank_transfer_controller.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/column/label_column.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';

import '../../../../../data/model/transfer/beneficiary/other_bank_beneficiary_response_model.dart';

class OtherBankTransferDetailsBottomSheet{

  void showSheet(BuildContext context,int index){
    CustomBottomSheet(child: GetBuilder<OtherBankTransferController>(builder: (controller)=> Column(
      children: [
        const BottomSheetTopRow(header: MyStrings.beneficiaryDetails),
        SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount:controller.beneficiaryList[index].details?.length??0,
            itemBuilder: (BuildContext context, int detailsIndex) {
              Details? details = controller.beneficiaryList[index].details?[detailsIndex];
              return Container(
                margin: const EdgeInsets.only(bottom: Dimensions.space15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4)
                ),
                child:
                details?.type=='file'?InkWell(
                  onTap: (){
                    controller.downloadAttachment(details?.value??'',context);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(details?.name.toString().capitalizeFirst??'',style: interLightDefault.copyWith(color: MyColor.bodyTextColor),overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.file_download,size: 17,color: MyColor.primaryColor,),
                          const SizedBox(width: 12),
                          Text(MyStrings.attachment.tr,style: interRegularDefault.copyWith(color: MyColor.primaryColor),)
                        ],
                      ),
                    ],
                  ),
                ):LabelColumn(
                    header:(details?.name??'').capitalizeFirst??'',
                    body: details?.value.toString()??''),
              );},),
        )
      ],
    ))).customBottomSheet(context);
  }

}