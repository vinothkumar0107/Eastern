import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/account/profile_complete_controller.dart';

import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/style.dart';

class CustomImageWidget extends StatefulWidget {

  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  final int listIndex;

  const CustomImageWidget({Key? key,
    required this.imagePath,
    this.listIndex = 0,
    required this.onClicked,
    this.isEdit = false
  }) : super(key: key);

  @override
  State<CustomImageWidget> createState() => _CustomImageWidgetState();
}

class _CustomImageWidgetState extends State<CustomImageWidget> {
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: -5,
            child: GestureDetector(
                onTap: (){
                 _openGallery(context);
                  },
                child: buildEditIconMethod(MyColor.getPrimaryColor())
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {

    final  Object image;

    if(imageFile!=null){
      image = FileImage(File(imageFile!.path));
    }else if (widget.imagePath.contains('https://')) {
      image = NetworkImage(widget.imagePath);
    } else{
      image = const AssetImage(MyImages.profileImage);
    }

    return ClipOval(
      //borderRadius: BorderRadius.circular(12),
      child: Material(
        color:MyColor.getCardBg1(),
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 90,
          height: 90,
          child: InkWell(
            onTap: widget.onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIconMethod(Color color) =>
      buildCircle(
        all: 2,
        color: Colors.white,
        child: buildCircle(
          all: 6,
          color: color,
          child:
          Icon(
            widget.isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 18,),
        ),

      );


  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }


  void _openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      Get.find<ProfileCompleteController>().imageFile=File(pickedFile!.path);
      imageFile = pickedFile;
    });


  }
}