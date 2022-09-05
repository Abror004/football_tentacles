import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_tentacles/screens/home_screen/home_screen.dart';
import 'package:football_tentacles/screens/play_page/play_controller.dart';
import 'package:get/get.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayController>(
        init: PlayController(),
        builder: ((controller) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/game_images/game_main_image.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  /// legs
                  for (int i = 0; i < 4; i++)
                    leg(
                        visible:
                            !controller.checkUpload && controller.visible[i],
                        top: Legs.getLeg(i: controller.legs[i]).scSize.hSize +
                            (controller.sides[i] == Side.left
                                ? controller.legsSizes[i].l
                                : controller.legsSizes[i].r),
                        left: Legs.getLeg(i: controller.legs[i]).left!,
                        height: Legs.getLeg(i: controller.legs[i]).height!,
                        width: Legs.getLeg(i: controller.legs[i]).width!,
                        name: Legs.getLeg(i: controller.legs[i]).text!,
                        side: controller.legs[i] > 5),

                  /// balls
                  for (int i = 0; i < 4; i++)
                    for (int b = 0;
                        b < Legs.getLeg(i: controller.legs[i]).balls.length;
                        b++)
                      ball(
                          visible:
                              !controller.checkUpload && controller.visible[i],
                          top: Legs.getLeg(i: controller.legs[i]).scSize.hSize +
                              (controller.sides[i] == Side.left
                                  ? controller.legsSizes[i].l
                                  : controller.legsSizes[i].r) +
                              Legs.getLeg(i: controller.legs[i]).balls[b].top,
                          left: Legs.getLeg(i: controller.legs[i]).left! +
                              Legs.getLeg(i: controller.legs[i]).balls[b].left,
                          side: controller.legs[i] > 5),

                  /// buttons
                  if (!controller.defeat) dates(),

                  /// defeat
                  if (controller.defeat)
                    Positioned(
                      top: 210.h,
                      left: 50.w,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
                        child: Image.asset(
                          "assets/game_images/defeat.png",
                          fit: BoxFit.fill,
                          height: 170.h,
                          width: 260.w,
                        ),
                      ),
                    ),
                  if (controller.defeat)
                    Stack(
                      children: [
                        text(
                            top: 226,
                            child: const Text(
                              "Score",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )),
                        text(
                            top: 254,
                            child: Text(
                              "${controller.level}",
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 20),
                            )),
                        text(
                            top: 289,
                            child: Text(
                              "Best Score",
                              style: TextStyle(
                                  color: const Color(0xFF000000).withOpacity(0.61),
                                  fontSize: 18),
                            )),
                        text(
                            top: 314,
                            child: Text(
                              "${controller.level}",
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 16),
                            )),
                        text(
                          top: 345,
                          child: InkWell(
                            onTap: () {
                              Get.off(const HomePage());
                            },
                            child: Image.asset(
                              "assets/game_images/menu_button.png",
                              fit: BoxFit.fill,
                              height: 25.h,
                              width: 75.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        }));
  }

  Widget text({required double top, required Widget child}) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: top.h),
        child: child,
      ),
    );
  }

  Widget leg(
      {required bool visible,
      required double top,
      required double left,
      required double height,
      required double width,
      required String name,
      required bool side}) {
    return Visibility(
      visible: visible,
      child: Positioned(
        top: top.h,
        left: left.w,
        child: side
            ? FadeInRight(
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  name,
                  fit: BoxFit.fill,
                  height: height.h,
                  width: width.w,
                ),
              )
            : FadeInLeft(
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  name,
                  fit: BoxFit.fill,
                  height: height.h,
                  width: width.w,
                ),
              ),
      ),
    );
  }

  Widget ball(
      {required bool visible,
      required double top,
      required double left,
      required bool side}) {
    return Visibility(
      visible: visible,
      child: Positioned(
        top: top.h,
        left: left.w,
        child: side
            ? FadeInRight(
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  Legs.ball,
                  fit: BoxFit.fill,
                  height: 39.h,
                  width: 39.w,
                ),
              )
            : FadeInLeft(
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  Legs.ball,
                  fit: BoxFit.fill,
                  height: 39.h,
                  width: 39.w,
                ),
              ),
      ),
    );
  }

  Widget dates() {
    return GetBuilder<PlayController>(
        init: PlayController(),
        builder: ((controller) {
          return Stack(
            children: [
              circle(
                top: 496,
                left: 24,
                child: const Text(
                  "5",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                function: () {
                  controller.check(i: 5);
                },
              ),
              circle(
                top: 560,
                left: 24,
                child: const Text(
                  "4",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                function: () {
                  controller.check(i: 4);
                },
              ),
              circle(
                top: 496,
                left: 88,
                child: const Text(
                  "6",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                function: () {
                  controller.check(i: 6);
                },
              ),
              circle(
                top: 560,
                left: 88,
                child: const Text(
                  "7",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                function: () {
                  controller.check(i: 7);
                },
              ),
              circle(
                  top: 24,
                  left: 24,
                  child: Text(
                    controller.level.toString(),
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  )),
              circle(
                top: 24,
                left: 96,
                child: Stack(
                  children: [
                    Align(
                      alignment: const Alignment(-0.5, -0.3),
                      child: Image.asset(controller.getHeart(3),
                          fit: BoxFit.fill, height: 13.h, width: 17.w),
                    ),
                    Align(
                      alignment: const Alignment(0.5, -0.3),
                      child: Image.asset(controller.getHeart(2),
                          fit: BoxFit.fill, height: 13.h, width: 17.w),
                    ),
                    Align(
                      alignment: const Alignment(0, 0.6),
                      child: Image.asset(controller.getHeart(1),
                          fit: BoxFit.fill, height: 13.h, width: 17.w),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }

  Widget circle(
      {required double top,
      required double left,
      required Widget child,
      function}) {
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
}
