import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eastern_trust/views/components/circle_widget/circle_image_button.dart';

import '../../../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/my_images.dart';
import '../../../../../data/controller/account/profile_controller.dart';


class ProfileWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({Key? key,
    required this.imagePath,
    required this.onClicked,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  XFile? imageFile;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            !widget.isEdit?buildDefaultImage():buildImage(),
            widget.isEdit?Positioned(
              bottom: 0,
              right: -4,
              child: GestureDetector(
                  onTap: (){
                   _openGallery(context);
                  },
                  child: buildEditIconMethod(MyColor.primaryColor)
              ),
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    final  Object image;

    if(imageFile!=null){
      image = FileImage(File(imageFile!.path));
    }else if (widget.imagePath.contains('http')) {
      image = NetworkImage(widget.imagePath);
    } else{
      image = const AssetImage(MyImages.defaultAvatar);
    }

    bool isAsset=widget.imagePath.contains('http')==true?false:true;


    return ClipOval(
      child: Material(
        color: MyColor.getCardBg1(),
        child:imageFile!=null?
        Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 90,
          height: 90,
          child: InkWell(
            onTap: widget.onClicked,
          ),
        ):CircleImageWidget(
          press: (){},
          isAsset: isAsset,
          imagePath: isAsset?MyImages.profileImage:widget.imagePath,
          height: 100,
          width: 100,),
      ),
    );
  }

  Widget buildDefaultImage() {

    return ClipOval(
      child: Material(
          color: MyColor.transparentColor,
          child:const CircleImageWidget(
            imagePath: MyImages.defaultAvatar,
            width: 90,
            height: 90,
            isAsset: true,
          )
      ),
    );
  }

  Widget buildEditIconMethod(Color color) =>
      buildCircle(
          child: buildCircle(
              child: Icon(
                widget.isEdit ? Icons.add_a_photo : Icons.edit,
                color: Colors.white,
                size: 20,
              ),
              all: 8,
              color: color),
          all: 3,
          color: Colors.white
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
    if (pickedFile == null) return;

    // Fix orientation
    final fixedImage = await FlutterExifRotation.rotateImage(
      path: pickedFile.path,
    );

    // setState(() {
    //   Get.find<ProfileController>().imageFile=File(pickedFile!.path);
    //   imageFile = pickedFile;
    // });

    setState(() {
      imageFile = XFile(fixedImage.path);
      Get.find<ProfileController>().imageFile = File(fixedImage.path);
    });


  }

}




