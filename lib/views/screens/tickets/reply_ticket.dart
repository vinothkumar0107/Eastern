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
    controller.replyModel = ReplyTicketData();
    controller.isLoading = true;
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


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReplyTicketController>(
      builder: (controller) =>  Scaffold(
        backgroundColor: MyColor.colorGrey,
        appBar: CustomAppBar(title: MyStrings.replyTicket, isTitleCenter: false,isNeedActionButtonText: true, actionText: MyStrings.close,
          isShowActionBtn: true, press: () {
              _showCloseTicketConfirmationDialog(context);
              dismissKeyboard();
            },
        ),

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
                        const SizedBox(height: 2),
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
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const SizedBox(height: Dimensions.paddingSize15),
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
                  Platform.isAndroid ? const SizedBox(height: Dimensions.paddingSize25) : const SizedBox.shrink(),
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
                  const SizedBox(height: Dimensions.paddingSize10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: const CustomAppBar(title: 'Attachments'),
  //     body: WebView(
  //       initialUrl: url,
  //       javascriptMode: JavascriptMode.unrestricted,
  //     ),
  //   );
  // }
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Attachments'),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class DocumentViewer extends StatefulWidget {
  final String url;
  final String attachmentName;

  const DocumentViewer({
    super.key,
    required this.url,
    required this.attachmentName,
  });

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  late final WebViewController _controller;
  bool isImage = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkIfImage();
    initWebView();
  }

  void checkIfImage() {
    final path = Uri.parse(widget.url).path.toLowerCase();
    isImage = path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.gif');
  }

  void initWebView() {
    final String displayUrl = isImage
        ? widget.url
        : 'https://docs.google.com/viewer?url=${widget.url}&embedded=true';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(displayUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.attachmentName),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

// Need to remove

// class DocumentViewer extends StatefulWidget {
//   final String url;
//   final String attachmentName;
//
//   const DocumentViewer({super.key, required this.url, required this.attachmentName});
//
//   @override
//   _DocumentViewerState createState() => _DocumentViewerState();
// }
//
// class _DocumentViewerState extends State<DocumentViewer> {
//   bool isImage = false;
//
//   @override
//   void initState() {
//     super.initState();
//     checkIfImage();
//   }
//
//   void checkIfImage() {
//     final uri = Uri.parse(widget.url);
//     final path = uri.path.toLowerCase();
//     if (path.endsWith('.png') || path.endsWith('.jpg') ||
//         path.endsWith('.jpeg') || path.endsWith('.gif')) {
//       setState(() {
//         isImage = true;
//       });
//     } else {
//       setState(() {
//         isImage = false;
//       });
//     }
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return  Scaffold(
//   //     appBar: CustomAppBar(title: widget.attachmentName),
//   //     body: WebView(
//   //       initialUrl: isImage
//   //           ? widget.url
//   //           : 'https://docs.google.com/viewer?url=${widget.url}&embedded=true',
//   //       javascriptMode: JavascriptMode.unrestricted,
//   //     ),
//   //   );
//   // }
// }



