import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';

class OtpTimer extends StatefulWidget {
  final VoidCallback onTimeComplete;
  final int duration;
  const OtpTimer({Key? key,required this.onTimeComplete,this.duration = 12}) : super(key: key);

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {

  Timer? _timer;
  int _counter = 0;
  bool isTimeEnd = false;

  @override
  void initState() {
    super.initState();
    _counter = widget.duration;
    _startTimer();
  }




  _startTimer(){
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 0) {
        widget.onTimeComplete();
        isTimeEnd = true;
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              MyStrings.otpWillBeExpired.tr,
              style: interRegularDefault.copyWith(fontSize:Dimensions.fontDefault,color: MyColor.colorBlack,fontWeight: FontWeight.w600)
          ),
          const SizedBox(width: Dimensions.textToTextSpace),
          Text(
              '${_counter.toString()} ${MyStrings.sec.tr}',
              overflow: TextOverflow.ellipsis,
              style: interSemiBoldLarge.copyWith(color: isTimeEnd ? MyColor.colorRed : MyColor.primaryColor)
          ),
        ],
      ),
    );
  }
}
