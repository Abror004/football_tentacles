import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_tentacles/screens/play_screen/play_controller.dart';
import 'package:get/get.dart';

class Game_Page extends StatelessWidget {
  const Game_Page({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Legs.left();
    Legs.right();
    return GetBuilder<GameController>(
        init: GameController(),
        builder: ((controller) {
          return Scaffold(
            body: Container(
              height: 1.sh,
              width: 1.sw,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/game_images/game_main_image.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  /// legs
                  legs(),

                  /// buttons
                  dates(),
                ],
              ),
            ),
          );
        }));
  }

  Widget legs() {
    return GetBuilder<GameController>(
        init: GameController(),
        builder: ((controller) {
          return Stack(
            children: [
              // /// left min/max
              // positionLine(top: 80, sidee: Sidee.left, test: Colors.red),
              // positionLine(top: 490, sidee: Sidee.left, test: Colors.red),
              // /// right min/max
              // positionLine(top: 10, sidee: Sidee.right, test: Colors.red),
              // positionLine(top: 580, sidee: Sidee.right, test: Colors.red),


              if(!controller.checkUpload)
              for(int i=0; i<controller.levelSet.legs.length; i++)
                leg(i: i),
            ],
          );
        }));
  }

  Widget leg({required int i}) {
    return GetBuilder<GameController>(
        init: GameController(),
        builder: ((controller) {
          // Leg leg = controller.levelSet.legs[i];
          // if(leg.sidee == Sidee.left) {
          //   log("i = $i | mainLeg = ${Legs.leftLegs[leg.index].scSize.hSize} | this = ${leg.scSize.hSize} | difference = ${Legs.leftLegs[leg.index].scSize.hSize-leg.scSize.hSize}");
          // } else {
          //   log("i = $i | mainLeg = ${Legs.rightLegs[leg.index].scSize.hSize} | this = ${leg.scSize.hSize} | difference = ${Legs.rightLegs[leg.index].scSize.hSize-leg.scSize.hSize}");
          // }
          return Stack(
            children: [
              /// leg
              Positioned(
                top: (controller.levelSet.legs[i].scSize.hSize+(controller.levelSet.legs[i].sidee == Sidee.left ? controller.levelSet.legs[i].scSize.getLeft : controller.levelSet.legs[i].scSize.getRight)).h,
                left: controller.levelSet.legs[i].left!.w,
                child: Image.asset(
                  controller.levelSet.legs[i].text!,
                  fit: BoxFit.fill,
                  height: controller.levelSet.legs[i].height!.h,
                  width: controller.levelSet.legs[i].width!.w,
                ),
              ),


              // positionLine(top: ((controller.levelSet.legs[i].sidee == Sidee.left ? 80 : 10)+((controller.levelSet.legs[i].scSize.hSize+(controller.levelSet.legs[i].sidee == Sidee.left ? controller.levelSet.legs[i].scSize.getLeft : controller.levelSet.legs[i].scSize.getRight)))), sidee: controller.levelSet.legs[i].sidee!, test: Colors.green),
              // // positionLine(top: controller.levelSet.legs[i].scSize.left+controller.levelSet.legs[i].scSize.hSize, sidee: controller.levelSet.legs[i].sidee!, test: Colors.green),
              /// balls
              for(int b=0; b<controller.levelSet.legs[i].balls.length; b++)
                Positioned(
                  top: ((controller.levelSet.legs[i].scSize.hSize+(controller.levelSet.legs[i].sidee == Sidee.left ? controller.levelSet.legs[i].scSize.getLeft : controller.levelSet.legs[i].scSize.getRight)) + controller.levelSet.legs[i].balls[b].top).h,
                  left: (controller.levelSet.legs[i].left! + controller.levelSet.legs[i].balls[b].left).w,
                  child: Image.asset(
                    Legs.ball,
                    fit: BoxFit.fill,
                    height: 39.h,
                    width: 39.w,
                  ),
                ),
            ],
          );
        }));
  }

  /// get one leg end its balls
  // Widget getLeg({required int i, required double top, required Sidee sidee}) {
  //   if(sidee == Sidee.left) {
  //     return Stack(
  //       children: [
  //         /// leg
  //         Positioned(
  //           top: top.h,
  //           left: Legs.leftLegs[i].left!.w,
  //           child: Image.asset(
  //             Legs.leftLegs[i].text!,
  //             fit: BoxFit.fill,
  //             height: Legs.leftLegs[i].height!.h,
  //             width: Legs.leftLegs[i].width!.w,
  //           ),
  //         ),
  //
  //         /// balls
  //         for(int b=0; b<Legs.leftLegs[i].balls.length; b++)
  //           Positioned(
  //             // top: (Legs.leftLegs[i].top!+Legs.leftLegs[i].balls[b].top).h,
  //             top: (top+Legs.leftLegs[i].balls[b].top).h,
  //             left: (Legs.leftLegs[i].left!+Legs.leftLegs[i].balls[b].left).w,
  //             child: Image.asset(
  //               Legs.ball,
  //               fit: BoxFit.fill,
  //               height: 39.h,
  //               width: 39.w,
  //             ),
  //           ),
  //       ],
  //     );
  //   } else {
  //     return Stack(
  //       children: [
  //         Positioned(
  //           // top: Legs.rightLegs[i].top!.h,
  //           top: top.h,
  //           left: Legs.rightLegs[i].left!.w,
  //           child: Image.asset(
  //             Legs.rightLegs[i].text!,
  //             fit: BoxFit.fill,
  //             height: Legs.rightLegs[i].height!.h,
  //             width: Legs.rightLegs[i].width!.w,
  //           ),
  //         ),
  //
  //         for(int b=0; b<Legs.rightLegs[i].balls.length; b++)
  //           Positioned(
  //             // top: (Legs.rightLegs[i].top!+Legs.rightLegs[i].balls[b].top).h,
  //             top: (top+Legs.rightLegs[i].balls[b].top).h,
  //             left: (Legs.rightLegs[i].left!+Legs.rightLegs[i].balls[b].left).w,
  //             child: Image.asset(
  //               Legs.ball,
  //               fit: BoxFit.fill,
  //               height: 39.h,
  //               width: 39.w,
  //             ),
  //           ),
  //       ],
  //     );
  //   }
  // }

  /// circles / buttons / lines
  Widget dates() {
    return GetBuilder<GameController>(
        init: GameController(),
        builder: ((controller) {
          return Stack(
            children: [
              circle(
                top: 496,
                left: 24,
                child: const Text("5", style: TextStyle(fontSize: 24, color: Colors.white),),
                function: () {
                  controller.check(count: 5);
                },
              ),
              circle(
                top: 560,
                left: 24,
                child: const Text("4", style: TextStyle(fontSize: 24, color: Colors.white),),
                function: () {
                  controller.check(count: 4);
                },
              ),
              circle(
                top: 496,
                left: 88,
                child: const Text("6", style: TextStyle(fontSize: 24, color: Colors.white),),
                function: () {
                  controller.check(count: 6);
                },
              ),
              circle(
                top: 560,
                left: 88,
                child: const Text("7", style: TextStyle(fontSize: 24, color: Colors.white),),
                function: () {
                  controller.check(count: 7);
                },
              ),
              circle(
                  top: 24,
                  left: 24,
                  child: Text(
                    controller.level.toString(),
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )),
              circle(
                top: 24,
                left: 96,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(-0.5, -0.3),
                      child: Image.asset(
                        controller.getHeart(3),
                        fit: BoxFit.fill,
                        height: 13.h,
                        width: 17.w
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.5, -0.3),
                      child: Image.asset(
                        controller.getHeart(2),
                        fit: BoxFit.fill,
                        height: 13.h,
                        width: 17.w
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.6),
                      child: Image.asset(
                          controller.getHeart(1),
                          fit: BoxFit.fill,
                          height: 13.h,
                          width: 17.w
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }

  /// circles
  Widget circle({required double top, required double left, required Widget child, function}) {
    if (function != null) {
      return Positioned(
        top: top.h,
        left: left.w,
        child: InkWell(
          onTap: () {
            function();
          },
          child: Container(
            height: 56.h,
            width: 56.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/game_images/circle.png"),
                fit: BoxFit.fill,
              ),
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      );
    } else {
      return Positioned(
        top: top.h,
        left: left.w,
        child: Container(
          height: 56.h,
          width: 56.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/game_images/circle.png"),
              fit: BoxFit.fill,
            ),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      );
    }
  }

  // Widget positionLine({required double top, required, required Sidee sidee, required Color test}) {
  //   return Positioned(
  //     left: sidee == Sidee.left ? 0.sw : 0.5.sw,
  //     top: top.h,
  //     child: Container(
  //       color: test,
  //       width: 0.5.sw,
  //       height: 1.h,
  //     ),
  //   );
  // }
}
