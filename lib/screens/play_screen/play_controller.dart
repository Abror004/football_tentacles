// import 'dart:async';
// import 'dart:math';
//
// import 'dart:developer' as Log;
//
// import 'package:flutter/material.dart';
// import 'package:football_tentacles/model/leg_model.dart';
// import 'package:get/get.dart';
//
// enum Sidee{left, right}
//
// class GameController extends GetxController {
//   int heart = 3;
//   bool defeat = false;
//   int level = 1;
//   LevelSet levelSet = LevelSet(); // oyola holati/malumotlari
//   bool checkUpload = false; // oyoqlani get qvoguncha buttonla bosilmasligi uchun
//   // Future? future;
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     Log.log("", name: "***************************************************************************************************************************************************************");
//     nextLevel();
//   }
//
//   void check({required int count}) {
//     if(!checkUpload) {
//       if(count == levelSet.ballCount) {
//         level++;
//       } else {
//         heart--;
//         if(heart == 0) {
//           defeat = true;
//         }
//       }
//       Log.log(" ${level}", name: "-------------------------------------------------------------------------------------------------------------------");
//       if(!defeat) {
//         nextLevel();
//       }
//       update();
//     }
//   }
//
//   String getHeart(int i) {
//     if(i > heart) {
//       return "assets/game_images/heart_off.png";
//     } else {
//       return "assets/game_images/heart_on.png";
//     }
//   }
//
//   void nextLevel() async {
//     checkUpload = true;
//     levelSet = LevelSet();
//     update();
//     levelSet.ballCount = GameElements.getCount();
//     levelSet.legs = await GameElements.legs(levelSet.ballCount);
//     Log.log("length: ${levelSet.legs.length}", name: "legs get2");
//     checkUpload = false;
//     update();
//   }
//
//   //______________________________________________________________
//   double screenRightMin = 10;
//   double screenRightMax = 580;
//   double screenLeftMin = 80;
//   double screenLeftMax = 490;
//
// //   final audioPlayer = AudioService.instance;// this will create a instance object of a class
// //
// //   bool isSound=true;
// //
// //   bool isVibration=true;
// //
// //   late Timer timer;
// //
// //
// // @override
// //   void onInit() async{
// //     // TODO: implement onInit
// //     super.onInit();
// //     timer=Timer.periodic(const Duration(milliseconds: 500), (timer) {
// //
// //     });
// //    isSound=await DBService.getSound();
// //     isVibration=await DBService.getVibration();
// //       _soundOn();
// //
// //   }
// //   void _soundOn()async{
// //     if(isSound){
// //       audioPlayer.open(
// //           Audio('assets/music/Menu.mp3'),
// //           autoStart: true,
// //           loopMode: LoopMode.single,
// //           showNotification: false
// //       );
// //     }
// //     else {
// //       audioPlayer.stop();
// //     }
// //   }
// //   void changeSoundOn(){
// //     isSound=!isSound;
// //     update();
// //     DBService.storeSound(isSound);
// //     _soundOn();
// //   }
// //   void changeVibration(){
// //    isVibration=!isVibration;
// //     update();
// //     DBService.storeVibration(isVibration);
// //   }
// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     super.dispose();
// //     audioPlayer.dispose();
// //   }
// }
//
// class LevelSet { /// level asosiy controller
//   int ballCount = 0; // koptoklar soni
//   List<Leg> legs = []; // oyoqlar va ular haqida info
//
//   LevelSet();
// }
//
// class LegsInfo {
//   Sidee sidee = Sidee.left; // qaysi tomondaligi
//   int dateIndex = 0; // listda nechinchiligi
//   List<int> ball = []; // qaysi indexdagi koptoklari korinishi
//   double top = 0; // tepadan neca 60.w qasga tuwawi
//
//   LegsInfo({
//     required this.sidee,
//     required this.ball,
//     required this.dateIndex,
//     required this.top
//   });
// }
//
// //________________________________________________________________________
// //dates
// class Legs {
//
//   Leg getLeg({required int i}) {
//     if(i > 5 && i < 12) {
//       return rightLegs[i%6];
//     } else {
//       return leftLegs[i];
//     }
//   }
//
//   static List<Leg> leftLegs = [
//     Leg(height: 120, width: 200, left: -60, top: -40, text: "assets/$_path/${_left}1.png", maxSize: 1, index: 0,
//         balls: [
//           Ball(top: 70, left: 155)],
//         scSize: ScreenSize(hSize: 10, left: 55, right: 0)
//     ),
//     Leg(height: 267, width: 201, left: -60, top: 15, text: "assets/$_path/${_left}2.png", maxSize: 2, index: 1,
//         balls: [
//           Ball(top: 5, left: 155),
//           Ball(top: 200, left: 170)],
//         scSize: ScreenSize(hSize: 85, left: 275, right: 0)
//     ),
//     Leg(height: 289, width: 260, left: -70, top: -25, text: "assets/$_path/${_left}3.png", maxSize: 2, index: 2,
//         balls: [
//           Ball(top: 50, left: 210),
//           Ball(top: 190, left: 140)],
//         scSize: ScreenSize(hSize: 45, left: 225, right: 0)
//     ),
//     Leg(height: 218, width: 216, left: -60, top: 15, text: "assets/$_path/${_left}4.png", maxSize: 2, index: 3,
//         balls: [
//           Ball(top: 10, left: 180),
//           Ball(top: 160, left: 150)],
//         scSize: ScreenSize(hSize: 85, left: 225, right: 0)
//     ),
//     Leg(height: 329, width: 248, left: -70, top: 10, text: "assets/$_path/${_left}5.png", maxSize: 3, index: 4,
//         balls: [
//           Ball(top: 10, left: 210),
//           Ball(top: 140, left: 145),
//           Ball(top: 265, left: 135)],
//         scSize: ScreenSize(hSize: 85, left: 335, right: 0)
//     ),
//     Leg(height: 386, width: 401, left: -128, top: -60, text: "assets/$_path/${_left}6.png", maxSize: 3, index: 5,
//         balls: [
//           Ball(top: 80, left: 320),
//           Ball(top: 175, left: 225),
//           Ball(top: 280, left: 190)],
//         scSize: ScreenSize(hSize: 10, left: 290, right: 115)
//     )
//   ];
//
//   static List<Leg> rightLegs = [
//     Leg(height: 120, width: 200, left: 220, top: -55, text: "assets/$_path/${_right}1.png", maxSize: 1, index: 0,
//         balls: [
//           Ball(top: 70, left: 5)],
//         scSize: ScreenSize(hSize: -60, left: 0, right: 55)
//     ),
//     Leg(height: 267, width: 201, left: 224, top: 15, text: "assets/$_path/${_right}2.png", maxSize: 2, index: 1,
//         balls: [
//           Ball(top: 5, left: 5),
//           Ball(top: 200, left: -5)],
//         scSize: ScreenSize(hSize: 15, left: 0, right: 275)
//     ),
//     Leg(height: 289, width: 260, left: 180, top: -25, text: "assets/$_path/${_right}3.png", maxSize: 2, index: 2,
//         balls: [
//           Ball(top: 50, left: 10),
//           Ball(top: 190, left: 80)],
//         scSize: ScreenSize(hSize: -25, left: 0, right: 225)
//     ),
//     Leg(height: 218, width: 216, left: 192, top: 15, text: "assets/$_path/${_right}4.png", maxSize: 2, index: 3,
//         balls: [
//           Ball(top: 10, left: -5),
//           Ball(top: 170, left: 25)],
//         scSize: ScreenSize(hSize: 15, left: 0, right: 225)
//     ),
//     Leg(height: 329, width: 248, left: 180, top: 10, text: "assets/$_path/${_right}5.png", maxSize: 3, index: 4,
//         balls: [
//           Ball(top: 15, left: 0),
//           Ball(top: 130, left: 65),
//           Ball(top: 245, left: 65)],
//         scSize: ScreenSize(hSize: 15, left: 0, right: 335)
//     ),
//     Leg(height: 386, width: 401, left: 100, top: -60, text: "assets/$_path/${_right}6.png", maxSize: 3, index: 5,
//         balls: [
//           Ball(top: 80, left: 40),
//           Ball(top: 170, left: 135),
//           Ball(top: 290, left: 180)],
//         scSize: ScreenSize(hSize: -60, left: 115, right: 290)
//     )
//   ];
//
//   static const List<Size> legsSize = [
//     Size(3, 1),
//     Size(3, 5),
//     Size(3, 4),
//     Size(3, 4),
//     Size(3, 6),
//     Size(4, 5),
//   ];
//
//   static const List<List<int>> _getLegBySize = [
//     [0],
//     [1, 2, 3],
//     [4, 5],
//   ];
//
//   static const String ball = "assets/game_images/ball.png";
//   static const String _path = "game_images";
//   static const String _left = "leg_left_";
//   static const String _right = "leg_right_";
// }
//
// class GameElements {
//
//   static int getCount() {
//     Log.log("");
//     return ((Random().nextInt(4))+4);
//   }
//
//   static Future<List<Leg>> legs(int ballCount) async {
//     //______________________________________
//     /// get ballCount
//     Log.log("ball = ${ballCount}");
//     int legsCount = 0;
//     if(ballCount == 7) {
//       legsCount = (Random().nextInt(2))+3;
//     } else {
//       legsCount = (Random().nextInt(3))+2;
//     }
//     //_______________________________________
//     /// get legs size
//     int testCount = 0;
//     List<int> legsSize = [];
//     int getThree = 0;
//     while(testCount < ballCount) {
//       testCount = 0;
//       legsSize = [];
//       getThree = 0;
//       for(int i=0; i<legsCount; i++) {
//         legsSize.add((Random().nextInt(getThree > 1 ? 2 : 3))+1);
//         legsSize.last == 3 ? getThree++ : 0;
//         testCount+=legsSize.last;
//       }
//     }
//     /// get legs
//     Log.log("${testCount}", name: "------------11");
//     //_______________________________________
//     /// remove or change other legs
//     int difference = 0;
//     for(int i=0; i<legsSize.length; i++) {
//       if(testCount-ballCount >= legsSize[i]) {
//         testCount -= legsSize[i];
//         legsSize.removeAt(i);
//       } else if(testCount-ballCount >= 1 && testCount-ballCount < legsSize[i]) {
//         difference = testCount-ballCount;
//         legsSize[i] -= difference;
//         testCount -= difference;
//       }
//     }
//     /// get legs
//     Log.log("${testCount}", name: "------------22");
//     if(legsSize.contains(1) && legsSize.indexOf(1) != legsSize.lastIndexOf(1)) {
//       legsSize.remove(1);
//       legsSize.remove(1);
//       legsSize.add(2);
//     }
//     //_______________________________________
//     /// get legs
//     Log.log("${testCount}", name: "------------33");
//     Log.log("legs size = ${legsSize}");
//     List<Leg> legs = [];
//     Leg? leg;
//     double left = 0;
//     double right = 0;
//     // List leftList = [];
//     // List rightList = [];
//     for(int i=0; i<legsSize.length; i++) {
//       int index = Legs._getLegBySize[legsSize[i]-1][Random().nextInt(Legs._getLegBySize[legsSize[i]-1].length)];
//       if(Random().nextInt(2) == 0) {
//         if(right+Legs.rightLegs[index].scSize.right < 570) {
//           leg = Legs.rightLegs[index];
//           leg.sidee = Sidee.right;
//           // leg.scSize.getRight = right;
//           legs.add(leg);
//           // right += leg.scSize.right;
//           // Log.log("1 right | right: ${legs.last.scSize.getRight}");
//         } else {
//           leg = Legs.leftLegs[index];
//           leg.sidee = Sidee.left;
//           // leg.scSize.getLeft = left;
//           legs.add(leg);
//           // left += leg.scSize.left;
//           // Log.log("1 left | left: ${legs.last.scSize.getLeft}");
//         }
//       } else {
//         if(left+Legs.leftLegs[index].scSize.left < 410) {
//           leg = Legs.leftLegs[index];
//           leg.sidee = Sidee.left;
//           // leg.scSize.getLeft = left;
//           legs.add(leg);
//           // left += leg.scSize.left;
//           // Log.log("2 left | left: ${legs.last.scSize.getLeft}");
//         } else {
//           leg = Legs.rightLegs[index];
//           leg.sidee = Sidee.right;
//           // leg.scSize.getRight = right;
//           legs.add(leg);
//           // right += leg.scSize.right;
//           // Log.log("2 right | right: ${legs.last.scSize.getRight}");
//         }
//       }
//       if(legs.last.sidee == Sidee.left) {
//         // if(legs.last.scSize.right != 0) {
//         //   double top =  legs.last.scSize.hSize + legs.last.scSize.getLeft;
//         //   if(top>(right+10)) {
//         //     right += (top-10)+legs.last.scSize.right;
//         //   } else {
//         //     right += legs.last.scSize.right;
//         //     left += (right-top);
//         //   }
//         // } else {
//         //   left += legs.last.scSize.left;
//         // }
//         left += legs.last.scSize.left;
//       } else {
//         right += legs.last.scSize.right;
//       }
//       // for(int b=0; b<legs.last.balls.length; b++) {
//       //   Log.log("i: ${legs.length-1} ${legs[i].toString()} | visible: ${legs.last.balls[b].visible}", name: "leg olindi");
//       // }
//     }
//     for(int i=0; i<legs.length-1; i++) {
//       for(int x=i+1; x<legs.length; x++) {
//         if(legs[i].index == legs[x].index && legs[i].sidee == legs[x].sidee) {
//           Log.log("kirdi");
//           int getLeft = 0;
//           int getRight = 0;
//           while(legs[i].index == legs[x].index) {
//             // legs[i] = Legs._getLegBySize[legs[i].maxSize!-1][Random().nextInt(Legs._getLegBySize[legs[i].maxSize!-1].length)];
//             if(legs[i].sidee == Sidee.left) {
//               legs[i] = Legs.leftLegs[Legs._getLegBySize[legs[i].maxSize!-1][Random().nextInt(Legs._getLegBySize[legs[i].maxSize!-1].length)]];
//             } else {
//               legs[i] = Legs.rightLegs[Legs._getLegBySize[legs[i].maxSize!-1][Random().nextInt(Legs._getLegBySize[legs[i].maxSize!-1].length)]];
//             }
//           }
//         }
//       }
//     }
//     Log.log("left: $left | right: $right", name: "--------------------------------");
//     // Log.log("length: ${legs.length}", name: "legs get");
//     // Log.log("100% tugadi", name: "legs get");
//     return legs;
//   }
// }