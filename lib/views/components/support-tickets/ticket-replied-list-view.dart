

import 'dart:ffi';

import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        bottomRight: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      color: MyColor.liteGreyColor,
    ) : BoxDecoration(
      border: Border.all(color: MyColor.colorGrey, width: 0.0),
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(10),
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      color: MyColor.primaryColor.withOpacity(0.95),
    );
  }


  @override
  Widget build2(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
        color: getAdminColor(),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              '${getReplierName()}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: interRegularDefault.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontLarge ),
            ),
          ),

          const SizedBox(width: 10.0),

          Container(
            padding: const EdgeInsets.all(10.0),
            width: 1.0,
            height: 70,
            color: Colors.grey,
          ),
          const SizedBox(width: 10.0),
          Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Posted on ${messages?.ticket.lastReply ?? " "}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: interRegularDefault.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontDefault ),
              ),
              const SizedBox(height: 5.0),
              Text(
                messages?.message ?? " ",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: interRegularSmall.copyWith(color:MyColor.getGreyText(),fontSize: Dimensions.fontDefault ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                height: 25,
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
                          'Attachment ${index + 1}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: interRegularDefault.copyWith(color:MyColor.primaryColor,fontSize: Dimensions.fontDefault ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          ),
        ],
      ),
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
                                'Document_${index + 1}',
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

              const SizedBox(height: 2),
              Text(
                messages?.ticket.lastReply ?? " ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: getAdminStatus() ? TextAlign.left : TextAlign.right,
                style: interRegularLarge.copyWith(
                  color: MyColor.colorGrey,
                  fontSize: Dimensions.fontSmall,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );

  }
}