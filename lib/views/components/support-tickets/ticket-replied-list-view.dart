

import 'dart:ffi';

import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/helper/date_converter.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';
import '../../../core/utils/url.dart';
import '../../../data/repo/tickets/reply_ticket_repo.dart';
import '../../screens/tickets/reply_ticket.dart';

class RepliedListView extends StatelessWidget {
  final VoidCallback callback;
  final MessageReply? messages;

  const RepliedListView({
    required this.callback,
    this.messages,
    Key? key,
  }) : super(key: key);

  String? getReplierName() {
    String? status = messages?.adminId == 1 ? '${messages?.admin.name}\n\nStaff'
        : messages?.ticket.name;
    return status;
  }
  Color getAdminColor() {
    Color color = (messages?.adminId == 1 ? MyColor.liteGreyColor.withOpacity(0.3)
        : MyColor.primaryColor.withOpacity(0.8));
    return color;
  }
  bool getAdminStatus(){
    return (messages?.adminId == 1 ? true : false);
  }

  BoxDecoration getBackgroundView(){
    return messages?.adminId == 1 ?  BoxDecoration(
      border: Border.all(color: MyColor.colorGrey, width: 0.1),
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(Dimensions.paddingSize15),
        topRight: Radius.circular(Dimensions.paddingSize15),
        bottomLeft: Radius.circular(Dimensions.paddingSize15),
      ),
      color: MyColor.colorGrey.withOpacity(0.2),
    ) : BoxDecoration(
      border: Border.all(color: MyColor.colorGrey, width: 0.0),
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(Dimensions.paddingSize15),
        topLeft: Radius.circular(Dimensions.paddingSize15),
        bottomLeft: Radius.circular(Dimensions.paddingSize15),
      ),
      color: MyColor.primaryColor.withOpacity(0.95),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns the message to the top
      children: [
        getAdminStatus() ? SvgPicture.asset(
          MyImages.supportIcon,
          height: 16,
          width: 16,
          color: MyColor.getPrimaryColor(),
        ): const SizedBox.shrink(),
        getAdminStatus() ? const SizedBox(width: 10): const SizedBox.shrink(),
        Expanded(
          child: Column(
            crossAxisAlignment: getAdminStatus() ? CrossAxisAlignment.start : CrossAxisAlignment.end, // Aligns message to the left
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: getBackgroundView(),
                child: Column(
                  crossAxisAlignment: getAdminStatus() ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Text(
                      messages?.message ?? " ",
                      maxLines: null, // Allows text to expand dynamically
                      overflow: TextOverflow.visible, // Ensures all text is shown
                      textAlign: getAdminStatus() ? TextAlign.left : TextAlign.right,
                      style: interRegularLarge.copyWith(
                        color: getAdminStatus() ? MyColor.colorBlack : MyColor.colorWhite,
                        fontSize: Dimensions.fontSmall12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: (messages?.attachments.length ?? 0) > 0 ? 25 : 0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: messages?.attachments.length ?? 0,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0), // Add trailing padding
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DocumentViewer(
                                      url: '${UrlContainer.assetViewBaseUrl}${messages?.attachments[index].attachment ?? " "}', attachmentName: 'Attachment ${index + 1}', // Replace with your URL
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Attachment_${index + 1}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: interRegularDefault.copyWith(color:MyColor.green,fontSize: Dimensions.fontSmall12 ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 3),
              Text(

                DateConverter.convertIsoToString(messages?.createdAt??''),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: getAdminStatus() ? TextAlign.left : TextAlign.right,
                style: interRegularLarge.copyWith(
                  color: MyColor.colorGrey2,
                  fontSize: Dimensions.fontSmall,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSize15),
            ],
          ),
        ),
      ],
    );

  }
}