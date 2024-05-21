import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found.dart';
import '../../../core/utils/dimensions.dart';



class NoDataFoundScreen extends StatelessWidget {

  const NoDataFoundScreen({
    Key? key,
    this.title = MyStrings.noDataFound,
    this.topMargin = 5,
    this.bottomMargin = 10,
    this.height = .8,
    this.isNoInternet = false,
    this.press,
    this.imageHeight = .5,
  }) : super(key: key);

  final double height;
  final String title;
  final double bottomMargin;
  final double topMargin;
  final bool isNoInternet;
  final Function? press;
  final double imageHeight;


  @override
  Widget build(BuildContext context) {
    return isNoInternet?Padding(
      padding: const EdgeInsets.all(2),
      child: ListView(
        physics:const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*.5,
                width: MediaQuery.of(context).size.width*.6,
                child: Lottie.asset(MyImages.noInternet,height:  MediaQuery.of(context).size.height*imageHeight,width: MediaQuery.of(context).size.width*.6,)
              ),

              Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6,left: 30,right: 30),
                    child: Column(
                      children: [
                        Text(MyStrings.noInternet.tr,
                          textAlign: TextAlign.center,
                          style: interSemiBold.copyWith(
                              color: MyColor.redCancelTextColor,
                              fontSize: Dimensions.fontLarge),
                        ),
                        const SizedBox(height: 15,),
                       InkWell(onTap: ()async{
                          if(await Connectivity().checkConnectivity() != ConnectivityResult.none){
                           if(press!=null){
                             press!(true);
                           }
                          }
                        }, child: Container(
                         padding: const EdgeInsets.symmetric(horizontal:12,vertical: 5),
                         decoration: BoxDecoration(
                             color: MyColor.redCancelTextColor,
                             borderRadius: BorderRadius.circular(4),
                         ),
                         child: Text(
                             MyStrings.retry.tr,
                             style:interRegularDefault.copyWith(color:MyColor.colorWhite,fontSize: Dimensions.fontSmall)
                         ),
                       ))
                      ],
                    ),
                  )),
            ],
          )
        ],
      )
    ):SingleChildScrollView(
        child: SizedBox(height:MediaQuery.of(context).size.height*height,
            child: NoDataWidget(
              bottomMargin: bottomMargin,topMargin: topMargin,title: title)));
  }
}
