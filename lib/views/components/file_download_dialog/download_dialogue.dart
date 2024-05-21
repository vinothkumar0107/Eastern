import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import '../../../core/utils/my_strings.dart';



class DownloadingDialog extends StatefulWidget {
  final String url;
  final String fileName;
  final bool isPdf;
  const DownloadingDialog({Key? key,required this.url,this.isPdf = true,required this.fileName}) : super(key: key);

  @override
  DownloadingDialogState createState() => DownloadingDialogState();
}

class DownloadingDialogState extends State<DownloadingDialog> {

  late http.StreamedResponse _response;
  late File _file;
  double _progress = 0.0;
  Future<void> _startDownload() async {
    setState(() {
      _progress = 0.0;
    });

    try {
      final request = http.Request('GET', Uri.parse(widget.url));
      _response = await request.send();

      if (_response.statusCode != 200) {
        throw Exception('Failed to fetch file');
      }

      final contentLength = _response.contentLength;
      var receivedBytes = 0;

      _file = File('/path/to/file'); // replace with your desired file path

      await _response.stream.transform(
        StreamTransformer.fromHandlers(
          handleData: (data, sink) async {
            await _file.writeAsBytes(data, mode: FileMode.append);
            receivedBytes += data.length;
            setState(() {
              _progress = receivedBytes / contentLength!;
            });
          },
        ),
      ).toList();

      setState(() {
        Get.back();
        CustomSnackBar.success(successList: [MyStrings.fileDownloadedSuccess]);
      });
    } catch (e) {
      setState(() {
        Get.back();
        CustomSnackBar.error(errorList: ['${MyStrings.errorDownloadingFile.tr} : ${e.toString()}']);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _startDownload();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColor.getCardBg(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           CircularProgressIndicator(
            value: _progress,
            strokeWidth: 4.0,
            valueColor: const AlwaysStoppedAnimation(MyColor.primaryColor900),
            backgroundColor: MyColor.primaryColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            MyStrings.downloading.tr,
            style: interRegularDefault
          ),
        ],
      ),
    );
  }
}
