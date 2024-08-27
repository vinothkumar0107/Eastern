import 'dart:io';

import 'package:eastern_trust/data/controller/account/profile_controller.dart';
import 'package:eastern_trust/data/repo/tickets/create_ticket_repo.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/deposit/add_new_deposit_controller.dart';
import 'package:eastern_trust/data/repo/deposit/deposit_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/screens/deposits/new_deposit/info_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import 'package:eastern_trust/data/controller/tickets/create_ticket_controller.dart';
import 'package:permission_handler/permission_handler.dart';


class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({Key? key}) : super(key: key);

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  String? _selectedValue = MyStrings.low;
  String? _fileName;
  final List<String> _dropdownItems = [
    MyStrings.low,
    MyStrings.medium,
    MyStrings.high,
  ];
  XFile? imageFile;

  List<String> items = [];
  int counter = 1;
  void addItem() {
    setState(() {
      items.add('Item $counter');
      counter++;
    });
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CreateTicketRepo(apiClient: Get.find()));
    final controller = Get.put(CreateTicketController(createTicketRepo: Get.find()));
    controller.isLoading = false;
    controller.submitLoading = false;
    super.initState();
    requestPermissions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something on load initially

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
    Get.find<CreateTicketController>().clearData();
    super.dispose();
  }

  List<String> selectedFiles = [];
  List<File> selectedFilesData = [];
  final ImagePicker _picker = ImagePicker();

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
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text(MyStrings.youHaveAddedMaximumFiles),
        //     behavior: SnackBarBehavior.floating),
        //
        // );
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
    // Replace this with your file selection logic
    // setState(() {
    //   selectedFiles[index] = 'Selected File: Example.txt'; // Example file name
    //   _openGallery(context);
    // });

    // chooseImage(index);
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
      // setState(() {
      //   selectedFiles[index] = result.files.single.name;
      // });
      // selectedFilesData.add(File(result.files.single.path!));
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

  void _openGallery(BuildContext context, int index) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      Get.find<ProfileController>().imageFile = File(pickedFile!.path);
      imageFile = pickedFile;
    });
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTicketController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.getScreenBgColor2(),
          appBar: const CustomAppBar(title: MyStrings.createTicket, isTitleCenter: false,),
          body: controller.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
            padding: Dimensions.screenPaddingHV1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: MyColor.getScreenBgColor2(),
                borderRadius: BorderRadius.circular(
                    Dimensions.defaultBorderRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      hintText:
                      MyStrings.subject.capitalizeFirst!.tr,
                      needLabel: true,
                      needOutlineBorder: true,
                      controller: controller.subjectController,
                      labelText:
                      MyStrings.subject.capitalizeFirst!.tr,
                      isRequired: true,
                      disableColor: MyColor.getGreyText(),
                      onChanged: (value) {
                        // controller.changeSelectedValue(value, index);
                      }
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      LabelText(
                        text: MyStrings.priority.tr,
                        required: true,
                      ),
                      const SizedBox(height: 5),
                      CustomDropDownTextField(
                        selectedValue: _selectedValue,
                        list: _dropdownItems,
                        borderWidth: 0.5,
                        borderColor: MyColor.getGreyText(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                            controller.priority = _selectedValue;
                          });
                        },
                      )
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
                      maxiLines: 5,
                      disableColor: MyColor.getGreyText(),
                      borderRadius: Dimensions.paddingSize10,
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
                        child:  Row(
                          children: [
                            Text('+ ${MyStrings.addNew}', style: interRegularDefault.copyWith(color:MyColor.colorWhite,fontSize: Dimensions.fontLarge )),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: '${MyStrings.attachment}s ',
                        style: interSemiBoldSmall.copyWith(
                            color: MyColor.primaryColor2),
                        children: <TextSpan>[
                          TextSpan(
                            text: MyStrings.fileSize,
                            style: interMediumSmall.copyWith(
                                color: MyColor.primaryColor2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    MyStrings.allowedFileExtensionHint,
                    style: interMediumSmall.copyWith(
                      color: MyColor.getGreyText(),
                    ),
                  ),
                  const SizedBox(height: 5),
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

                  const SizedBox(height: 25),
                  controller.submitLoading?const RoundedLoadingBtn():
                  RoundedButton(
                    text: MyStrings.submit,
                    textColor: MyColor.textColor,
                    width: double.infinity,
                    press: () {
                      controller.selectedFilesData = selectedFilesData;
                      controller.priority = _selectedValue;
                      controller.submitTicket();
                      dismissKeyboard();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}


class ChooseFileView extends StatelessWidget {
  final String selectedFileName;
  final VoidCallback chooseFile;
  final VoidCallback? removeFile;

  const ChooseFileView({
    required this.selectedFileName,
    required this.chooseFile,
    this.removeFile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(child:
        Container(
          height: 50,
          margin: const EdgeInsets.only(left: 0,top: Dimensions.paddingSize5,right: 0, bottom: Dimensions.paddingSize5),
          padding: const EdgeInsets.only(left: Dimensions.paddingSize20,top: Dimensions.paddingSize5,right: Dimensions.paddingSize10, bottom: Dimensions.paddingSize5),
          decoration: BoxDecoration(
            border: Border.all(color: MyColor.getGreyText(), width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.paddingSize30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  selectedFileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: interMediumLarge.copyWith(color: MyColor.colorGrey,decorationColor:MyColor.primaryColor),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSize10),
              IconButton(
                onPressed: chooseFile,
                icon: const Icon(Icons.upload),
                color: Colors.grey,
                iconSize: 25,

              ),
            ],
          ),),),
        if (removeFile != null) // Conditionally show cancel button if removeFile callback is not null
          IconButton(
            onPressed: removeFile!,
            icon: const Icon(Icons.cancel),
            color: Colors.red,
          ),
      ],
    );
  }
}