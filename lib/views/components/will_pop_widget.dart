import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/views/components/alert-dialog/exit_dialog.dart';


class WillPopWidget extends StatelessWidget {

  final Widget child;
  final String nextRoute;
  final bool isOnlyBack;

  const WillPopWidget({Key? key,
    required this.child,
    this.nextRoute = '',
    this.isOnlyBack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
          onWillPop: () async {
            if(isOnlyBack){
              return Future.value(true);
            }
            if(nextRoute.isEmpty){
              showExitDialog(context);
              return Future.value(false);
            }else{
              Get.offAndToNamed(nextRoute);
              return Future.value(false);
            }
          },
          child: child),
    );
  }
}
