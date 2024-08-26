import 'dart:io';

import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/controller/account/profile_controller.dart';
import 'package:eastern_trust/data/controller/tickets/reply_ticket_controller.dart';
import 'package:eastern_trust/data/model/dynamic_form/form.dart';
import 'package:eastern_trust/data/repo/tickets/reply_ticket_repo.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';
import 'package:eastern_trust/views/screens/account/edit-profile/widget/profile_image.dart';
import 'package:eastern_trust/views/screens/transfer/wire_transfer_screen/widget/wire_transfer_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/deposit/add_new_deposit_controller.dart';
import 'package:eastern_trust/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:eastern_trust/data/repo/deposit/deposit_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/text-field/custom_amount_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field2.dart';
import 'package:eastern_trust/views/screens/deposits/new_deposit/info_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eastern_trust/data/controller/tickets/create_ticket_controller.dart';
import 'package:eastern_trust/views/screens/tickets/create_ticket/create_ticket.dart';
import 'package:eastern_trust/data/repo/tickets/create_ticket_repo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/repo/tickets/ticket_list_repo.dart';
import '../../components/snackbar/show_custom_snackbar.dart';
import '../../components/support-tickets/ticket-replied-list-view.dart';


class ReplyTicketScreen extends StatefulWidget {

  final Ticket selectedReply;
  const ReplyTicketScreen({Key? key,  required this.selectedReply}) : super(key: key);

  @override
  State<ReplyTicketScreen> createState() => _ReplyTicketScreenState();
}

class _ReplyTicketScreenState extends State<ReplyTicketScreen> {

  String? _selectedValue ="Item 1";
  String? _fileName;
  final List<String> _dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  XFile? imageFile;
  List<String> selectedFiles = [];
  List<File> selectedFilesData = [];
  final ImagePicker _picker = ImagePicker();

  final GlobalKey _bottomViewKey = GlobalKey();
  double _bottomViewHeight = 100.0;

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReplyTicketRepo(apiClient: Get.find()));
    final controller = Get.put(ReplyTicketController(replyTicketRepo: Get.find(), onReplyComplete: () {  }));
    controller.isLoading = false;
    controller.selectedFiles = selectedFiles;
    controller.selectedFilesData = selectedFilesData;
    super.initState();
    requestPermissions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something on load initially
      controller.ticketId = widget.selectedReply.ticket.toString();
      controller.getViewTicketData();
      _calculateBottomViewHeight();

    });
    addNewChooseFileView();
  }

  Future<void> requestPermissions() async {
    await [
      Permission.storage,
      Permission.camera,
    ].request();
  }

  @override
  void dispose() {
    Get.find<ReplyTicketController>().clearData();
    super.dispose();
  }
  void _refreshList() {
    setState(() {
      selectedFilesData.clear();
      selectedFiles.clear();
      addNewChooseFileView();
    });
  }
  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void addNewChooseFileView() {
    setState(() {
      if (selectedFiles.length < 5) {
        selectedFiles.add(MyStrings.uploadDocument);
        // selectedFilesData.add(File(""));
      } else {
        // Optional: Show a message or disable adding more items
        // if the maximum count (5) is reached.
        CustomSnackBar.error(errorList: [MyStrings.youHaveAddedMaximumFiles]);
      }
    });
    dismissKeyboard();
  }

  void removeFile(int index)  {
    setState(() {
      selectedFiles.removeAt(index);
      if (selectedFilesData.length > index){
        selectedFilesData.removeAt(index);
      }
    });
  }

  void chooseFile(int index) {
    showFileSelectionSheet(index);
    dismissKeyboard();
  }

  void showFileSelectionSheet(int index) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: MyColor.primaryColor2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text(MyStrings.chooseImage),
              onTap: () {
                Navigator.pop(context);
                chooseImage(context, index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text(MyStrings.chooseDocument),
              onTap: () {
                Navigator.pop(context);
                chooseDocuments(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text(MyStrings.cancel),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  void chooseDocuments(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx', 'pdf'],
    );
    if (result != null) {
      // Convert PlatformFile to File
      File attachmentData = File(result.files.single.path!);
      setState(() {
        if (index >= 0 && index <= selectedFilesData.length) {
          selectedFiles[index] = result.files.single.name;
          if (index < selectedFilesData.length){
            selectedFilesData[index] = attachmentData;
          }else{
            selectedFilesData.insert(index, attachmentData);
          }
        } else {
          selectedFiles[index] = result.files.single.name;
          selectedFilesData.add(attachmentData);
        }
      });
    }
  }

  void chooseImage(BuildContext context, int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null && image.path.isNotEmpty) {
      // uploadFile(File(image.path));
      final file = File(image.path);
      if (await file.exists()) {
        setState(() {
          if (index >= 0 && index <= selectedFilesData.length) {
            selectedFiles[index] = image.name;
            if (index < selectedFilesData.length){
              selectedFilesData[index] = file;
            }else{
              selectedFilesData.insert(index, file);
            }
          } else {
            selectedFiles[index] = image.name;
            selectedFilesData.add(file);
          }
        });
      } else {
        print("File does not exist at path: ${image.path}");
      }
    }
  }

  String getStatusFromCode() {
    int code = widget.selectedReply.status;
    switch (code) {
      case 0:
        return MyStrings.open;
      case 1:
        return MyStrings.answered;
      case 2:
        return MyStrings.customerReply;
      case 3:
        return MyStrings.closed;
      default:
        return ' ';
    }
  }

  Color getStatusColorFromCode() {
    int code = widget.selectedReply.status;
    switch (code) {
      case 0:
        return MyColor.greenSuccessColor;
      case 1:
        return MyColor.purpleColor;
      case 2:
        return MyColor.pendingColor;
      case 3:
        return MyColor.redCancelTextColor;
      default:
        return Colors.white;
    }
  }

  String getTicketId() {
    return widget.selectedReply.ticket.toString();
  }

  String getId() {
    return widget.selectedReply.id.toString();
  }

  String getSubject() {
    return widget.selectedReply.subject.toString();
  }

  Future<void> _showCloseTicketConfirmationDialog(BuildContext context) async {
    bool? shouldClose = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(MyStrings.confirmAlert),
          content: const Text(MyStrings.areYouSureCloseTicket),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User pressed 'No'
              },
              child: const Text(MyStrings.no),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User pressed 'Yes'
              },
              child: const Text(MyStrings.yes),
            ),
          ],
        );
      },
    );

    if (shouldClose ?? false) {
      // Perform the close ticket action
      final controller = Get.put(ReplyTicketController(replyTicketRepo: Get.find(), onReplyComplete: () { }));
      controller.ticketId = getId();
      controller.closeTicket();
    }
  }

  void _calculateBottomViewHeight() {
    final RenderBox? renderBox = _bottomViewKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _bottomViewHeight = renderBox.size.height; // Get the height of the bottom view
      });
    }
  }

// need to remove
  @override
  Widget build2(BuildContext context) {
    return GetBuilder<ReplyTicketController>(
        builder: (controller) =>  Scaffold(
          backgroundColor: MyColor.getScreenBgColor2(),
          appBar: const CustomAppBar(title: MyStrings.replyTicket, isTitleCenter: false,),

          body:  controller.isLoading
              ? const CustomLoader() :
          SingleChildScrollView(
            padding: Dimensions.screenPaddingHV1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: MyColor.getScreenBgColor2(),
                borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Ticket: ',
                          style: interRegularDefault.copyWith(color:MyColor.primaryColor2,fontSize: Dimensions.fontDefault),
                          children: <TextSpan>[
                            TextSpan(
                              text: getTicketId(),
                              style: interRegularLarge.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontDefault)),
                          ]
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2), // Padding inside the border
                        decoration: BoxDecoration(
                          color: getStatusColorFromCode().withOpacity(0.2), // Background color
                          border: Border.all(
                            color: getStatusColorFromCode(), // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSize25), // Border radius
                        ),
                        child: Text(
                          getStatusFromCode(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: interRegularSmall.copyWith(color:getStatusColorFromCode(),fontSize: Dimensions.fontSmall12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: 'Subject: ',
                            style: interRegularDefault.copyWith(color:MyColor.primaryColor2,fontSize: Dimensions.fontDefault),
                            children: <TextSpan>[
                              TextSpan(
                                  text: getSubject(),
                                  style: interRegularLarge.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontDefault)),
                            ]
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                      hintText:
                      MyStrings.message.capitalizeFirst!.tr,
                      needLabel: true,
                      needOutlineBorder: true,
                      controller: controller.messageController,
                      labelText:
                      MyStrings.message.capitalizeFirst!.tr,
                      isRequired: true,
                      maxiLines: 3,
                      disableColor: MyColor.getGreyText(),
                      onChanged: (value) {
                        // controller.changeSelectedValue(value, index);
                      }),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget> [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.primaryColor, // Background color
                          foregroundColor: MyColor.textColor, // Text color
                        ),
                        onPressed:addNewChooseFileView,
                        //_openGallery(context);
                        child: Row(
                          children: [
                            Text('+ ${MyStrings.addNew}', style: interRegularDefault.copyWith(color:MyColor.colorWhite,fontSize: Dimensions.fontLarge ))
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: '${MyStrings.attachment}s ',
                        style: interSemiBoldSmall.copyWith(
                            color: MyColor.colorBlack),
                        children: <TextSpan>[
                          TextSpan(
                            text: MyStrings.fileSize,
                            style: interMediumSmall.copyWith(
                                color: MyColor.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: selectedFiles.length,
                      itemBuilder: (ctx, index) {
                        bool isFirstItem = index == 0;
                        return ChooseFileView(
                          key: Key('ChooseFileView_$index'),
                          selectedFileName: selectedFiles[index],
                          chooseFile: () => chooseFile(index),
                          removeFile: isFirstItem ? null : () => removeFile(index),
                        );
                      }),
                  const SizedBox(height: 0),
                  Text(
                    MyStrings.allowedFileExtensionHint,
                    style: interMediumSmall.copyWith(
                      color: MyColor.colorBlack,
                    ),
                  ),
                  const SizedBox(height: 20),
                  controller.submitLoading?const RoundedLoadingBtn():
                  RoundedButton(
                    text: MyStrings.reply,
                    textColor: MyColor.textColor,
                    width: double.infinity,
                    press: () {
                      controller.selectedFilesData = selectedFilesData;
                      controller.selectedFiles = selectedFiles;
                      controller.ticketId = getTicketId();
                      controller.id = getId();
                      controller.onReplyComplete = _refreshList;
                      controller.submitTicket();
                      dismissKeyboard();
                    },
                  ),
                  const SizedBox(height: 20),
                  controller.closeLoading?const RoundedLoadingBtn():
                  RoundedButton(
                    text: MyStrings.closeTicket,
                    textColor: MyColor.textColor,
                    color: MyColor.red,
                    width: double.infinity,
                    press: () {
                      _showCloseTicketConfirmationDialog(context);
                      dismissKeyboard();
                    },
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.replyModel.messages?.length ?? 0,
                      itemBuilder: (ctx, index) {
                        bool isFirstItem = index == 0;
                        return RepliedListView(
                          key: Key('RepliedListView_$index'),
                          messages: controller.replyModel.messages?[index],
                          callback: () => {},
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReplyTicketController>(
      builder: (controller) =>  Scaffold(
        backgroundColor: MyColor.colorGrey,
        appBar: const CustomAppBar(title: MyStrings.replyTicket, isTitleCenter: false,),

        body:  controller.isLoading
            ? const CustomLoader() :
        Column(
          children: [
            // Scrollable content will take up all available space above the bottom view
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(Dimensions.screenPadding),
                width: MediaQuery.of(context).size.width,
                  color: MyColor.liteGreyColorBorder,
                child: Container(
                  padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: MyColor.getScreenBgColor2(),
                    borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
                  ),
                  child: SingleChildScrollView(
                    padding: Dimensions.screenPaddingHV1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: 'Ticket Id: ',
                                  style: interRegularLarge.copyWith(color:MyColor.getGreyText(),fontSize: Dimensions.fontDefault),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: getTicketId(),
                                        style: interRegularLarge.copyWith(color:MyColor.getGreyText(),fontSize: Dimensions.fontDefault)),
                                  ]
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2), // Padding inside the border
                              decoration: BoxDecoration(
                                color: getStatusColorFromCode().withOpacity(0.2), // Background color
                                border: Border.all(
                                  color: getStatusColorFromCode(), // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(Dimensions.paddingSize25), // Border radius
                              ),
                              child: Text(
                                getStatusFromCode(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: interRegularSmall.copyWith(color:getStatusColorFromCode(),fontSize: Dimensions.fontSmall12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: 'Subject: ',
                                  style: interRegularLarge.copyWith(color:MyColor.getGreyText(),fontSize: Dimensions.fontDefault),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: getSubject(),
                                        style: interRegularLarge.copyWith(color:MyColor.getGreyText(),fontSize: Dimensions.fontDefault)),
                                  ]
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: controller.replyModel.messages?.length ?? 0,
                            itemBuilder: (ctx, index) {
                              bool isFirstItem = index == 0;
                              return RepliedListView(
                                key: Key('RepliedListView_$index'),
                                messages: controller.replyModel.messages?[index],
                                callback: () => {},
                              );
                            }),
                      ],
                    ),
                  ),
                )
              )
            ),
            
            // Bottom fixed section
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: MyColor.getScreenBgColor2(),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2), // Shadow above the fixed area
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Allows dynamic height
                children: [
                  const SizedBox(height: Dimensions.paddingSize5),
                  CustomTextField(
                      hintText:
                      '${MyStrings.message.capitalizeFirst!.tr} *',
                      needLabel: false,
                      needOutlineBorder: true,
                      controller: controller.messageController,
                      labelText:
                      MyStrings.message.capitalizeFirst!.tr,
                      isRequired: true,
                      maxiLines: 1,
                      disableColor: MyColor.getGreyText(),
                      backgroundColor: MyColor.colorWhite,
                      onChanged: (value) {
                        // controller.changeSelectedValue(value, index);
                      }),
                  const SizedBox(height: Dimensions.paddingSize15),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Expanded(child: Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 0,right: Dimensions.paddingSize10),
                             child: RichText(
                               textAlign: TextAlign.start,
                               text: TextSpan(
                                 text: MyStrings.fileSize,
                                 style: interMediumSmall.copyWith(
                                     color: MyColor.primaryColor2),
                               ),
                             ),
                           ),
                         ],
                       ),),
                       InkWell(
                         onTap: () {
                           addNewChooseFileView();
                         },
                         child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             const Icon(
                               Icons.add_box_outlined,
                               color: MyColor.primaryColor,
                               size: 15, // Set icon size
                             ),
                             const SizedBox(width: 5,),
                             Text(MyStrings.addNew, style: interRegularDefault.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontDefault,fontWeight: FontWeight.w600)),
                             const SizedBox(width: 15,)
                           ],
                         ),

                       ),
                     ],
                   ),
                  const SizedBox(height: Dimensions.paddingSize10),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: selectedFiles.length,
                      itemBuilder: (ctx, index) {
                        bool isFirstItem = index == 0;
                        return ChooseFileView(
                          key: Key('ChooseFileView_$index'),
                          selectedFileName: selectedFiles[index],
                          chooseFile: () => chooseFile(index),
                          removeFile: isFirstItem ? null : () => removeFile(index),
                        );
                      }),
                  controller.submitLoading?const RoundedLoadingBtn():
                  RoundedButton(
                    text: MyStrings.reply,
                    textColor: MyColor.textColor,
                    width: double.infinity,
                    press: () {
                      controller.selectedFilesData = selectedFilesData;
                      controller.selectedFiles = selectedFiles;
                      controller.ticketId = getTicketId();
                      controller.id = getId();
                      controller.onReplyComplete = _refreshList;
                      controller.submitTicket();
                      dismissKeyboard();
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSize20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//Need to remove
// class RepliedListView2 extends StatelessWidget {
//   final VoidCallback callback;
//   final MessageReply? messages;
//
//   const RepliedListView2({
//     required this.callback,
//     this.messages,
//     Key? key,
//   }) : super(key: key);
//
//   String? getReplierName() {
//     String? status = messages?.adminId == 1 ? '${messages?.admin.name}\n\nStaff'
//         : messages?.ticket.name;
//     return status;
//   }
//   Color getAdminColor() {
//     Color color = (messages?.adminId == 1 ? MyColor.paybillBaseColor.withOpacity(0.3)
//         : Colors.white);
//     return color;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 5.0),
//       padding: const EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey, width: 1.0),
//         borderRadius: BorderRadius.circular(5.0),
//         color: getAdminColor(),
//       ),
//       child: Row(
//         children: <Widget>[
//           SizedBox(
//             width: 100,
//             child: Text(
//               '${getReplierName()}',
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.right,
//               style: interRegularDefault.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontLarge ),
//             ),
//           ),
//
//           const SizedBox(width: 10.0),
//
//           Container(
//             padding: const EdgeInsets.all(10.0),
//             width: 1.0,
//             height: 70,
//             color: Colors.grey,
//           ),
//           const SizedBox(width: 10.0),
//           Expanded(child:
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Posted on ${messages?.ticket.lastReply ?? " "}',
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: interRegularDefault.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontDefault ),
//               ),
//               const SizedBox(height: 5.0),
//               Text(
//                 messages?.message ?? " ",
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 style: interRegularSmall.copyWith(color:MyColor.getGreyText(),fontSize: Dimensions.fontDefault ),
//               ),
//               const SizedBox(height: 5.0),
//               SizedBox(
//                 height: 25,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: messages?.attachments.length ?? 0,
//                   itemBuilder: (ctx, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8.0), // Add trailing padding
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => DocumentViewer(
//                                 url: '${UrlContainer.assetViewBaseUrl}${messages?.attachments[index].attachment ?? " "}', attachmentName: 'Attachment ${index + 1}', // Replace with your URL
//                               ),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Attachment ${index + 1}',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: interRegularDefault.copyWith(color:MyColor.primaryColor,fontSize: Dimensions.fontDefault ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    print("Web url $url");
    return SafeArea(child: Scaffold(
      appBar: const CustomAppBar(title: 'Attachments'),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    ),
    );
  }
}

class DocumentViewer extends StatefulWidget {
  final String url;
  final String attachmentName;

  const DocumentViewer({super.key, required this.url, required this.attachmentName});

  @override
  _DocumentViewerState createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  bool isImage = false;

  @override
  void initState() {
    super.initState();
    checkIfImage();
  }

  void checkIfImage() {
    final uri = Uri.parse(widget.url);
    final path = uri.path.toLowerCase();
    if (path.endsWith('.png') || path.endsWith('.jpg') ||
        path.endsWith('.jpeg') || path.endsWith('.gif')) {
      setState(() {
        isImage = true;
      });
    } else {
      setState(() {
        isImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: CustomAppBar(title: widget.attachmentName),
      body: WebView(
        initialUrl: isImage
            ? widget.url
            : 'https://docs.google.com/viewer?url=${widget.url}&embedded=true',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    )
    );
  }
}



