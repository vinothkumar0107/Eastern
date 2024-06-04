import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';

class DPSController extends GetxController{

  bool isPlan = true;
  void changeTab(bool isPlan){
    this.isPlan = isPlan;
    update();
  }

  String getPreviousRoute(){
    String previousRoute = Get.previousRoute;
    if(previousRoute==RouteHelper.notificationScreen){
      return RouteHelper.notificationScreen;
    } else{
      return RouteHelper.homeScreen;
    }
  }


}