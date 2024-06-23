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


class ReplyTicketScreen extends StatefulWidget {

  final Ticket selectedReply;
  const ReplyTicketScreen({Key? key, required this.selectedReply}) : super(key: key);

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


  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReplyTicketRepo(apiClient: Get.find()));
    final controller = Get.put(ReplyTicketController(replyTicketRepo: Get.find()));
    controller.isLoading = false;
    super.initState();
    requestPermissions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something on load initially
      controller.ticketId = widget.selectedReply.ticket.toString();
      controller.getViewTicketData();

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

  void addNewChooseFileView() {
    setState(() {
      if (selectedFiles.length < 5) {
        selectedFiles.add('No file chosen');
        selectedFilesData.add(File(""));
      } else {
        // Optional: Show a message or disable adding more items
        // if the maximum count (5) is reached.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have added maximum number of files'),
              behavior: SnackBarBehavior.floating),

        );
        // CustomSnackBar.error(errorList: ['You have added maximum number of files']);
      }
    });
  }

  void removeFile(int index)  {
    setState(() {
      selectedFiles.removeAt(index);
      selectedFilesData.removeAt(index);
    });
  }

  void chooseFile(int index) {
    // Replace this with your file selection logic
    // setState(() {
    //   selectedFiles[index] = 'Selected File: Example.txt'; // Example file name
    //   _openGallery(context);
    // });

    // chooseImage(index);
    showFileSelectionSheet(index);
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
              title: const Text('Choose Image'),
              onTap: () {
                Navigator.pop(context);
                chooseImage(context, index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Choose Document'),
              onTap: () {
                Navigator.pop(context);
                chooseDocuments(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
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
      setState(() {
        selectedFiles[index] = result.files.single.name;
      });
      selectedFilesData.add(File(result.files.single.path!));
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
            selectedFilesData.insert(index, file);
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReplyTicketController>(
        builder: (controller) =>  SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor2(),
          appBar: const CustomAppBar(title: MyStrings.replyTicket),
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
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 0),
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2), // Padding inside the border
                            decoration: BoxDecoration(
                              color: getStatusColorFromCode().withOpacity(0.2), // Background color
                              border: Border.all(
                                color: getStatusColorFromCode(), // Border color
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.circular(6.0), // Border radius
                            ),
                            child: Text(
                              getStatusFromCode(),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: getStatusColorFromCode(), // Text color
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                           Text(
                            '[Ticket#${getTicketId()}]',
                            maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black, // Text color
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            getSubject(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black, // Text color
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
                            child: const Row(
                              children: [
                                Text('+ Add New')
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Attachments ',
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
                      const SizedBox(height: 10),
                      Text(
                        'Allowed File Extensions: .jpg, .jpeg, .png, .pdf, .doc, .docx',
                        style: interMediumSmall.copyWith(
                          color: MyColor.colorGrey,
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
                          controller.ticketId = getTicketId();
                          controller.id = getId();
                          controller.submitTicket();
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
          )
    );
  }
}

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
    Color color = (messages?.adminId == 1 ? MyColor.paybillBaseColor.withOpacity(0.3)
        : Colors.white);
    return color;
  }

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(
                color: MyColor.colorBlack, //error in this line
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(width: 10.0),

          Container(
            padding: const EdgeInsets.all(10.0),
            width: 1.0,
            height: 100,
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
                style: const TextStyle(
                  color: MyColor.colorBlack, //error in this line
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                messages?.message ?? " ",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: MyColor.naturalDark, //error in this line
                  fontSize: 14,
                ),
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
                              builder: (context) => WebViewScreen(
                                url: '${UrlContainer.assetViewBaseUrl}${messages?.attachments[index].attachment ?? " "}', // Replace with your URL
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Attachments ${index + 1}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: MyColor.primaryColor, // Replace with your desired color
                            fontSize: 14,
                          ),
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
}

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
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