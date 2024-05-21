import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'webview_widget.dart';



class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key,required this.redirectUrl}) : super(key: key);
  final String redirectUrl;

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '',isShowBackBtn: true,),
      body: MyWebViewWidget(url: widget.redirectUrl),
      floatingActionButton: favoriteButton(),
    );
  }


  Widget favoriteButton() {
    return FloatingActionButton(
      backgroundColor: MyColor.colorRed,
      onPressed: () async {
        Get.back();
      },
      child: const Icon(Icons.cancel,color: MyColor.colorWhite,size: 30,),
    );
  }


  Future<Map<Permission, PermissionStatus>> permissionServices() async{

    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.microphone,
      Permission.mediaLibrary,
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses;
  }

}

