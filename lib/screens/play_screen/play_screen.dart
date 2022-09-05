// import 'dart:developer';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:football_tentacles/screens/play_screen/play_controller.dart';
// import 'package:get/get.dart';
//
// class Game_Page extends StatefulWidget {
//   const Game_Page({Key? key}) : super(key: key);
//
//   @override
//   State<Game_Page> createState() => _Game_PageState();
// }
//
// class _Game_PageState extends State<Game_Page> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<GameController>(
//         init: GameController(),
//         builder: ((controller) {
//           // for(int i=0; i<controller.levelSet.legs.length; i++) {
//           //   for(int b=0; b<controller.levelSet.legs[i].balls.length; b++) {
//           //     log("visible[$i][$b]: ${controller.levelSet.legs[i].balls[b].visible}", name: "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ");
//           //   }
//           // }
//           return Scaffold(
//             body: Container(
//               height: 1.sh,
//               width: 1.sw,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/game_images/game_main_image.png"),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   /// legs
//                   legs(),
//
//                   /// buttons
//                   if (!controller.defeat)
//                     dates(),
//
//                   /// defeat
//                   if (controller.defeat)
//                     Positioned(
//                       top: 210.h,
//                       left: 50.w,
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
//                         child: Image.asset(
//                           "assets/game_images/defeat.png",
//                           fit: BoxFit.fill,
//                           height: 170.h,
//                           width: 260.w,
//                         ),
//                       ),
//                     ),
//                   if (controller.defeat)
//                     Stack(
//                       children: [
//                         text(
//                             top: 226,
//                             child: Text(
//                               "Score",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500),
//                             )),
//                         text(
//                             top: 254,
//                             child: Text(
//                               "${controller.level}",
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 20),
//                             )),
//                         text(
//                             top: 289,
//                             child: Text(
//                               "Best Score",
//                               style: TextStyle(
//                                   color: Color(0xFF000000).withOpacity(0.61),
//                                   fontSize: 18),
//                             )),
//                         text(
//                             top: 314,
//                             child: Text(
//                               "${controller.level}",
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 16),
//                             )),
//                         text(
//                           top: 345,
//                           child: InkWell(
//                             onTap: () {},
//                             child: Image.asset(
//                               "assets/game_images/menu_button.png",
//                               fit: BoxFit.fill,
//                               height: 25.h,
//                               width: 75.w,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           );
//         }));
//   }
//
//   Widget text({required double top, required Widget child}) {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: Padding(
//         padding: EdgeInsets.only(top: top.h),
//         child: child,
//       ),
//     );
//   }
//   //__________________________________________________________________
//   Widget legs() {
//     return GetBuilder<GameController>(
//         init: GameController(),
//         builder: ((controller) {
//           return Stack(
//             children: [
//               for (int i = 0; i < controller.levelSet.legs.length; i++)
//                 leg(i: i),
//               // for (int i = 0; i < controller.levelSet.legs.length; i++)
//                 // balls(i: i),
//             ],
//           );
//         }));
//   }
//
//   Widget leg({required int i}) {
//     return GetBuilder<GameController>(
//         init: GameController(),
//         builder: ((controller) {
//           return SizedBox();
//           // log("i: $i | ${controller.levelSet.legs[i].toString()}");
//           // log("i: $i || top: ${(controller.levelSet.legs[i].scSize.hSize +
//           //     (controller.levelSet.legs[i].sidee == Sidee.left ?
//           //     controller.levelSet.legs[i].scSize.getLeft :
//           //     controller.levelSet.legs[i].scSize.getRight)
//           // )} || left: ${controller.levelSet.legs[i].left!} || sidee: ${controller.levelSet.legs[i].sidee}");
//           // return Positioned(
//           //   top: (controller.levelSet.legs[i].scSize.hSize +
//           //       (controller.levelSet.legs[i].sidee == Sidee.left ?
//           //       controller.levelSet.legs[i].scSize.getLeft :
//           //       controller.levelSet.legs[i].scSize.getRight)
//           //   ).h,
//           //   // top: ((i*50)+controller.levelSet.legs[i].scSize.hSize).h,
//           //   left: (controller.levelSet.legs[i].left!).w,
//           //   child: Image.asset(
//           //     controller.levelSet.legs[i].text!,
//           //     fit: BoxFit.fill,
//           //     height: controller.levelSet.legs[i].height!.h,
//           //     width: controller.levelSet.legs[i].width!.w,
//           //   ),
//           // );
//         }));
//   }
//
//   // Widget balls({required int i}) {
//   //   return GetBuilder<GameController>(
//   //       init: GameController(),
//   //       builder: ((controller) {
//   //         return Stack(
//   //           children: [
//   //             for (int b = 0; b < controller.levelSet.legs[i].balls.length; b++)
//   //               Positioned(
//   //                 top: ((controller.levelSet.legs[i].scSize.hSize +
//   //                     (controller.levelSet.legs[i].sidee == Sidee.left
//   //                         ? controller.levelSet.legs[i].scSize.getLeft
//   //                         : controller
//   //                         .levelSet.legs[i].scSize.getRight)) +
//   //                     controller.levelSet.legs[i].balls[b].top)
//   //                     .h,
//   //                 // top: ((i*50)+(controller.levelSet.legs[i].scSize.hSize) + controller.levelSet.legs[i].balls[b].top).h,
//   //                 left: (controller.levelSet.legs[i].left! +
//   //                     controller.levelSet.legs[i].balls[b].left)
//   //                     .w,
//   //                 child: Image.asset(
//   //                   Legs.ball,
//   //                   fit: BoxFit.fill,
//   //                   height: 39.h,
//   //                   width: 39.w,
//   //                 ),
//   //               )
//   //           ],
//   //         );
//   //       }));
//   // }
//
//   //___________________________________________________________________
//   /// circles / buttons / lines
//   Widget dates() {
//     return GetBuilder<GameController>(
//         init: GameController(),
//         builder: ((controller) {
//           return Stack(
//             children: [
//               circle(
//                 top: 496,
//                 left: 24,
//                 child: const Text(
//                   "5",
//                   style: TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//                 function: () {
//                   controller.check(count: 5);
//                 },
//               ),
//               circle(
//                 top: 560,
//                 left: 24,
//                 child: const Text(
//                   "4",
//                   style: TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//                 function: () {
//                   controller.check(count: 4);
//                 },
//               ),
//               circle(
//                 top: 496,
//                 left: 88,
//                 child: const Text(
//                   "6",
//                   style: TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//                 function: () {
//                   controller.check(count: 6);
//                 },
//               ),
//               circle(
//                 top: 560,
//                 left: 88,
//                 child: const Text(
//                   "7",
//                   style: TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//                 function: () {
//                   controller.check(count: 7);
//                 },
//               ),
//               circle(
//                   top: 24,
//                   left: 24,
//                   child: Text(
//                     controller.level.toString(),
//                     style: TextStyle(fontSize: 24, color: Colors.white),
//                   )),
//               circle(
//                 top: 24,
//                 left: 96,
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: Alignment(-0.5, -0.3),
//                       child: Image.asset(controller.getHeart(3),
//                           fit: BoxFit.fill, height: 13.h, width: 17.w),
//                     ),
//                     Align(
//                       alignment: Alignment(0.5, -0.3),
//                       child: Image.asset(controller.getHeart(2),
//                           fit: BoxFit.fill, height: 13.h, width: 17.w),
//                     ),
//                     Align(
//                       alignment: Alignment(0, 0.6),
//                       child: Image.asset(controller.getHeart(1),
//                           fit: BoxFit.fill, height: 13.h, width: 17.w),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }));
//   }
//
//   /// circles
//   Widget circle(
//       {required double top,
//       required double left,
//       required Widget child,
//       function}) {
//     if (function != null) {
//       return Positioned(
//         top: top.h,
//         left: left.w,
//         child: InkWell(
//           onTap: () {
//             function();
//           },
//           child: Container(
//             height: 56.h,
//             width: 56.w,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/game_images/circle.png"),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             alignment: Alignment.center,
//             child: child,
//           ),
//         ),
//       );
//     } else {
//       return Positioned(
//         top: top.h,
//         left: left.w,
//         child: Container(
//           height: 56.h,
//           width: 56.w,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/game_images/circle.png"),
//               fit: BoxFit.fill,
//             ),
//           ),
//           alignment: Alignment.center,
//           child: child,
//         ),
//       );
//     }
//   }
// }
