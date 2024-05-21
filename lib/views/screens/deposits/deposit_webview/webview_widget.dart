
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';

import '../../../components/snackbar/show_custom_snackbar.dart';

class MyWebViewWidget extends StatefulWidget {
  const MyWebViewWidget({Key? key,required this.url}) : super(key: key);

  final String url;

  @override
  State<MyWebViewWidget> createState() => _MyWebViewWidgetState();
}

class _MyWebViewWidgetState extends State<MyWebViewWidget> {

  @override
  void initState() {
    url = widget.url;
    super.initState();

  }


  String url = '';
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  bool isKycPending = false;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
       AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    return Stack(
      children: [
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox(),
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url:WebUri(url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          initialOptions: options,
          onLoadStart: (controller, url) {

            if(url.toString()=='${UrlContainer.domainUrl}user/deposit/history'){
              Get.offAndToNamed(RouteHelper.depositsScreen);
              CustomSnackBar.success(successList: [MyStrings.requestSuccess]);
            } else if(url.toString()=='${UrlContainer.baseUrl}user/deposit'){
              Get.back();
              CustomSnackBar.error(errorList: [MyStrings.requestFail]);
            }

            setState(() {
              this.url = url.toString();
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (![ "http", "https", "file", "chrome",
              "data", "javascript", "about"].contains(uri.scheme)) {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(
                  Uri.parse(url),
                );
                return NavigationActionPolicy.CANCEL;
              }
            }
            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            setState(() {
              isLoading = false;
              this.url = url.toString();
            });
          },
          onProgressChanged: (controller, progress) {},
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              this.url = url.toString();
            });
          },
          onConsoleMessage: (controller, consoleMessage) {

          },
        )
      ],
    );
  }
}
