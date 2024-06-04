import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';


class BalanceAnimationContainer extends StatefulWidget {
  const BalanceAnimationContainer({Key? key,required this.amount,required this.curSymbol}) : super(key: key);
  final String amount;
  final String curSymbol;

  @override
  State<BalanceAnimationContainer>createState() => _BalanceAnimationContainerState();
}

class _BalanceAnimationContainerState extends State<BalanceAnimationContainer> {
  bool _isAnimation = false;
  bool _isBalanceShown = false;
  bool _isBalance = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
                  onTap: changeState,
                  child: Container(
                      width: 130,
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: Stack(alignment: Alignment.center, children: [

                        AnimatedOpacity(
                            opacity: _isBalanceShown ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            child:  FittedBox(
                              child: Text('${widget.curSymbol} ${widget.amount}',
                                  style:interSemiBold.copyWith(color: MyColor.primaryColor,fontSize: Dimensions.fontDefault)),
                            )),
                        AnimatedOpacity(
                            opacity: _isBalance ? 1 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: Text(MyStrings.balance.tr,
                                style: const TextStyle(
                                    color: MyColor.primaryColor, fontSize: 14))),

                        /// Circle
                        AnimatedPositioned(
                            duration: const Duration(milliseconds: 1100),
                            left: _isAnimation == false ? 5 : 135,
                            curve: Curves.fastOutSlowIn,
                            child: Container(
                                height: 20,
                                width: 20,
                                // padding: const EdgeInsets.only(bottom: 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: MyColor.primaryColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child:  FittedBox(
                                    child: Text(widget.curSymbol,
                                         style: interSemiBold.copyWith(color:MyColor.colorWhite,fontSize: Dimensions.fontLarge)))))
                      ])));
  }


  bool taskStart=false;
  void changeState() async {
    if(_isAnimation||taskStart){
      return;
    }
    taskStart=true;
    _isAnimation = true;
    _isBalance = false;

    setState(() {});

    await Future.delayed(const Duration(milliseconds: 500),
            () => setState(() =>
            _isBalanceShown = true
            ));
    await Future.delayed(
        const Duration(seconds: 3), () => setState(() => _isBalanceShown = false));
    await Future.delayed(const Duration(milliseconds: 200),
            () => setState(() => _isAnimation = false));
    await Future.delayed(
        const Duration(milliseconds: 500), () => setState(() => _isBalance = true));
    await Future.delayed(
        const Duration(milliseconds: 1000), () => setState(() =>  taskStart=false));

  }
}