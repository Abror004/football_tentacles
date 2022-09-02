import 'dart:math';

import 'dart:developer' as Log;

import 'package:flutter/material.dart';
import 'package:football_tentacles/model/leg_model.dart';
import 'package:get/get.dart';

enum Sidee{left, right}

class GameController extends GetxController {
  int heart = 3;
  bool defeat = false;
  int level = 1;
  LevelSet levelSet = LevelSet();
  bool checkUpload = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nextLevel();
  }

  void check({required int count}) {
    if(!checkUpload) {
      if(count == levelSet.ballCount) {
        level++;
      } else {
        heart--;
        // if(heart == 0) {
        //   defeat = true;
        // }
      }
      nextLevel();
      update();
    }
  }

  String getHeart(int i) {
    if(i > heart) {
      return "assets/game_images/heart_off.png";
    } else {
      return "assets/game_images/heart_on.png";
    }
  }

  void nextLevel() {
    checkUpload = true;
    levelSet = LevelSet();
    update();
    levelSet.ballCount = GameElements._getCount();
    levelSet.legs = GameElements._legs(levelSet.ballCount);
    for(int i=0; i<levelSet.legs.length; i++) {
      Log.log("${levelSet.legs[i].toString()}");
    }
    sortLegs();
    checkUpload = false;
    update();
  }

  // void getSizeIndex () {
  //   for(int i=0; i<levelSet.legs.length; i++) {
  //       if(levelSet.legs[i].sidee == Sidee.left) {
  //         levelSet.leftSideList.add(Legs.leftLegs[levelSet.legs[i].dateIndex].height!);
  //         levelSet.legsSideIndex.add(levelSet.leftSideList.length-1);
  //       } else {
  //         levelSet.rightSideList.add(Legs.rightLegs[levelSet.legs[i].dateIndex].height!);
  //         levelSet.legsSideIndex.add(levelSet.rightSideList.length-1);
  //       }
  //   }
  // }

  void sortLegs() {
    // for(int i=0; i<levelSet.legs.length; i++) {
    //   // leftSize += Legs.leftLegs[levelSet.legs[i].dateIndex].scSize.left;
    //   // rightSize += Legs.leftLegs[levelSet.legs[i].dateIndex].scSize.right;
    //
    // }
    // // Log.log("left size: $leftSize | right size: ${rightSize}");
  }

  // double getTop({required int index}) {
  //   double top = 0;
  //   // if(levelSet.legs[i].sidee == Sidee.left) {
  //   //
  //   //   for(int a=0; a<i; a++) {
  //   //     // top += levelSet.leftSideList[levelSet.legsSideIndex[]]
  //   //     top += Legs.leftLegs[levelSet.leftSideList[]]
  //   //   }
  //   //
  //   // } else {
  //   //   levelSet.rightSideList[levelSet.legsSideIndex[i]];
  //   // }
  //   for(int i=0; i<index; i++) {
  //     if(levelSet.legs[i].sidee == levelSet.legs[index].sidee) {
  //
  //       if(levelSet.legs[index].sidee == Sidee.left) {
  //         top += Legs.leftLegs[levelSet.legs[index].dateIndex].scSize.hSize;
  //       } else {
  //         top += Legs.rightLegs[levelSet.legs[index].dateIndex].scSize.hSize;
  //       }
  //
  //     } else {
  //
  //       if(levelSet.legs[index].sidee == Sidee.left) {
  //         top += Legs.leftLegs[levelSet.legs[index].dateIndex].scSize.hSize;
  //       } else {
  //         top += Legs.rightLegs[levelSet.legs[index].dateIndex].scSize.hSize;
  //       }
  //
  //     }
  //   }
  //   return top;
  // }

  double screenRightMin = 10;
  double screenRightMax = 580;
  double screenLeftMin = 80;
  double screenLeftMax = 490;

  // List<List<double>> absd = const [
  //   [1, 1, 1, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [1, 1, 1, 0, 0, 0],
  //   [1, 1, 1, 0, 0, 0],
  // ];
  //
  // List<List<double>> legsInfo = const [
  //   [1, 1, 1, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0],
  //   [1, 1, 1, 0, 0, 0],
  //   [1, 1, 1, 0, 0, 0],
  // ];

//   final audioPlayer = AudioService.instance;// this will create a instance object of a class
//
//   bool isSound=true;
//
//   bool isVibration=true;
//
//   late Timer timer;
//
//
// @override
//   void onInit() async{
//     // TODO: implement onInit
//     super.onInit();
//     timer=Timer.periodic(const Duration(milliseconds: 500), (timer) {
//
//     });
//    isSound=await DBService.getSound();
//     isVibration=await DBService.getVibration();
//       _soundOn();
//
//   }
//   void _soundOn()async{
//     if(isSound){
//       audioPlayer.open(
//           Audio('assets/music/Menu.mp3'),
//           autoStart: true,
//           loopMode: LoopMode.single,
//           showNotification: false
//       );
//     }
//     else {
//       audioPlayer.stop();
//     }
//   }
//   void changeSoundOn(){
//     isSound=!isSound;
//     update();
//     DBService.storeSound(isSound);
//     _soundOn();
//   }
//   void changeVibration(){
//    isVibration=!isVibration;
//     update();
//     DBService.storeVibration(isVibration);
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     audioPlayer.dispose();
//   }
}

class LevelSet { /// level asosiy controller
  int ballCount = 0; // koptoklar soni
  List<Leg> legs = []; // ? oyoqlar va ular haqida info
  // List<int> legsSideIndex = [];
  // List<double> leftSideList = [];
  // List<double> rightSideList = [];
}

class LegsInfo {
  Sidee sidee = Sidee.left; // qaysi tomondaligi
  int dateIndex = 0; // listda nechinchiligi
  List<int> ball = []; // qaysi indexdagi koptoklari korinishi
  double top = 0; // tepadan neca 60.w qasga tuwawi

  LegsInfo({
    required this.sidee,
    required this.ball,
    required this.dateIndex,
    required this.top
  });
}

//________________________________________________________________________
//dates
class Legs {
  static List<Leg> leftLegs = [
    Leg(height: 120, width: 200, left: -60, top: -40, text: "assets/$_path/${_left}1.png", maxSize: 1, index: 0,
        balls: [
          Ball(top: 70, left: 155)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 267, width: 201, left: -60, top: 15, text: "assets/$_path/${_left}2.png", maxSize: 2, index: 1,
        balls: [
          Ball(top: 5, left: 155),
          Ball(top: 200, left: 170)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 289, width: 260, left: -70, top: -25, text: "assets/$_path/${_left}3.png", maxSize: 2, index: 2,
        balls: [
          Ball(top: 50, left: 210),
          Ball(top: 190, left: 140)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 218, width: 216, left: -60, top: 15, text: "assets/$_path/${_left}4.png", maxSize: 2, index: 3,
        balls: [
          Ball(top: 10, left: 180),
          Ball(top: 160, left: 150)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 329, width: 248, left: -70, top: 10, text: "assets/$_path/${_left}5.png", maxSize: 3, index: 4,
        balls: [
          Ball(top: 10, left: 210),
          Ball(top: 140, left: 145),
          Ball(top: 265, left: 135)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 386, width: 401, left: -128, top: -60, text: "assets/$_path/${_left}6.png", maxSize: 3, index: 5,
        balls: [
          Ball(top: 80, left: 320),
          Ball(top: 175, left: 225),
          Ball(top: 280, left: 190)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    )
  ];

  static List<Leg> rightLegs = [
    Leg(height: 120, width: 200, left: 220, top: -40, text: "assets/$_path/${_right}1.png", maxSize: 1, index: 0,
        balls: [
          Ball(top: 70, left: 5)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 267, width: 201, left: 224, top: 15, text: "assets/$_path/${_right}2.png", maxSize: 2, index: 1,
        balls: [
          Ball(top: 5, left: 5),
          Ball(top: 200, left: -5)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 289, width: 260, left: 180, top: -25, text: "assets/$_path/${_right}3.png", maxSize: 2, index: 2,
        balls: [
          Ball(top: 50, left: 10),
          Ball(top: 190, left: 80)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 218, width: 216, left: 192, top: 15, text: "assets/$_path/${_right}4.png", maxSize: 2, index: 3,
        balls: [
          Ball(top: 10, left: -5),
          Ball(top: 170, left: 25)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 329, width: 248, left: 180, top: 10, text: "assets/$_path/${_right}5.png", maxSize: 3, index: 4,
        balls: [
          Ball(top: 15, left: 0),
          Ball(top: 130, left: 65),
          Ball(top: 245, left: 65)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    ),
    Leg(height: 386, width: 401, left: 100, top: -60, text: "assets/$_path/${_right}6.png", maxSize: 3, index: 5,
        balls: [
          Ball(top: 80, left: 40),
          Ball(top: 170, left: 135),
          Ball(top: 290, left: 180)],
        scSize: ScreenSize(hSize: 0, left: 0, right: 0)
    )
  ];

  static const List<Size> legsSize = [
    Size(3, 1),
    Size(3, 5),
    Size(3, 4),
    Size(3, 4),
    Size(3, 6),
    Size(4, 5),
  ];

  static const List<List<int>> _getLegBySize = [
    [0],
    [1, 2, 3],
    [4, 5],
  ];

  static Leg getLegByBallSize({required bool left, required int size}) {
    Log.log("size: $size | _getLegBySize[${size-1}][${(Random().nextInt(_getLegBySize[size-1].length))}]", name: "---leg---");
    if(left) {
      return leftLegs[_getLegBySize[size-1][(Random().nextInt(_getLegBySize[size-1].length))]];
    } else {
      return rightLegs[_getLegBySize[size-1][(Random().nextInt(_getLegBySize[size-1].length))]];
    }
  }

  static const String ball = "assets/game_images/ball.png";
  static const String _path = "game_images";
  static const String _left = "leg_left_";
  static const String _right = "leg_right_";

static void left() {
  leftLegs = [
    Leg(height: 120, width: 200, left: -60, top: -40, text: "assets/$_path/${_left}1.png", maxSize: 1, index: 0,
      balls: [
        Ball(top: 70, left: 155)],
        scSize: ScreenSize(hSize: 10, left: 55, right: 0)
    ),
    Leg(height: 267, width: 201, left: -60, top: 15, text: "assets/$_path/${_left}2.png", maxSize: 2, index: 1,
        balls: [
          Ball(top: 5, left: 155),
          Ball(top: 200, left: 170)],
        scSize: ScreenSize(hSize: 85, left: 275, right: 0)
    ),
    Leg(height: 289, width: 260, left: -70, top: -25, text: "assets/$_path/${_left}3.png", maxSize: 2, index: 2,
        balls: [
          Ball(top: 50, left: 210),
          Ball(top: 190, left: 140)],
        scSize: ScreenSize(hSize: 45, left: 225, right: 0)
    ),
    Leg(height: 218, width: 216, left: -60, top: 15, text: "assets/$_path/${_left}4.png", maxSize: 2, index: 3,
        balls: [
          Ball(top: 10, left: 180),
          Ball(top: 160, left: 150)],
        scSize: ScreenSize(hSize: 85, left: 225, right: 0)
    ),
    Leg(height: 329, width: 248, left: -70, top: 10, text: "assets/$_path/${_left}5.png", maxSize: 3, index: 4,
        balls: [
          Ball(top: 10, left: 210),
          Ball(top: 140, left: 145),
          Ball(top: 265, left: 135)],
        scSize: ScreenSize(hSize: 85, left: 335, right: 0)
    ),
    Leg(height: 386, width: 401, left: -128, top: -60, text: "assets/$_path/${_left}6.png", maxSize: 3, index: 5,
        balls: [
          Ball(top: 80, left: 320),
          Ball(top: 175, left: 225),
          Ball(top: 280, left: 190)],
        scSize: ScreenSize(hSize: 10, left: 290, right: 115)
    )
  ];
}

static void right() {
  rightLegs = [
    Leg(height: 120, width: 200, left: 220, top: -55, text: "assets/$_path/${_right}1.png", maxSize: 1, index: 0,
        balls: [
          Ball(top: 70, left: 5)],
        scSize: ScreenSize(hSize: -60, left: 0, right: 55)
    ),
    Leg(height: 267, width: 201, left: 224, top: 15, text: "assets/$_path/${_right}2.png", maxSize: 2, index: 1,
        balls: [
          Ball(top: 5, left: 5),
          Ball(top: 200, left: -5)],
        scSize: ScreenSize(hSize: 15, left: 0, right: 275)
    ),
    Leg(height: 289, width: 260, left: 180, top: -25, text: "assets/$_path/${_right}3.png", maxSize: 2, index: 2,
        balls: [
          Ball(top: 50, left: 10),
          Ball(top: 190, left: 80)],
        scSize: ScreenSize(hSize: -25, left: 0, right: 225)
    ),
    Leg(height: 218, width: 216, left: 192, top: 15, text: "assets/$_path/${_right}4.png", maxSize: 2, index: 3,
        balls: [
          Ball(top: 10, left: -5),
          Ball(top: 170, left: 25)],
        scSize: ScreenSize(hSize: 15, left: 0, right: 225)
    ),
    Leg(height: 329, width: 248, left: 180, top: 10, text: "assets/$_path/${_right}5.png", maxSize: 3, index: 4,
        balls: [
          Ball(top: 15, left: 0),
          Ball(top: 130, left: 65),
          Ball(top: 245, left: 65)],
        scSize: ScreenSize(hSize: 15, left: 0, right: 335)
    ),
    Leg(height: 386, width: 401, left: 100, top: -60, text: "assets/$_path/${_right}6.png", maxSize: 3, index: 5,
        balls: [
          Ball(top: 80, left: 40),
          Ball(top: 170, left: 135),
          Ball(top: 290, left: 180)],
        scSize: ScreenSize(hSize: -60, left: 115, right: 290)
    )
  ];
}
}

class GameElements {

  static int _getCount() {
    Log.log("");
    return ((Random().nextInt(4))+4);
  }

  static List<Leg> _legs(int ballCount) {
    //______________________________________
    // get ballCount
    Log.log("ball = ${ballCount}");
    int legsCount = 0;
    if(ballCount == 7) {
      legsCount = (Random().nextInt(2))+3;
    } else {
      legsCount = (Random().nextInt(3))+2;
    }
    // Log.log("legs length = ${legsCount}");
    //_______________________________________
    // get legs size
    int testCount = 0;
    List<int> legsSize = [];
    int getThree = 0;
    while(testCount < ballCount) {
      testCount = 0;
      legsSize = [];
      getThree = 0;
      for(int i=0; i<legsCount; i++) {
        legsSize.add((Random().nextInt(getThree > 1 ? 2 : 3))+1);
        legsSize.last == 3 ? getThree++ : 0;
        testCount+=legsSize.last;
      }
    }
    Log.log("${testCount}", name: "------------");
    Log.log("legs size = ${legsSize}");
    //_______________________________________
    // get legs
    List<Leg> legs = getLegs(legsSize: legsSize);

    // Log.log("left: $left | right: $right", name: "--------------------------------");
    //_______________________________________
    // ortiqcha koptolani yoqotish

    if(ballCount < testCount) {
      Log.log("kirdi: ${testCount-ballCount}", name: "remove");
      for(int i=0; i<testCount-ballCount; i++) {
        int legIndex = Random().nextInt(legs.length);
        if(legs[legIndex].balls.length > 0) {
          legs[legIndex].balls.removeAt(Random().nextInt(legs[legIndex].balls.length));
        } else {
          i--;
        }
      }
    }

    getLegs(legsSize: [], gettingLegs: legs);
    Log.log("100% tugadi", name: "legs get");
    return legs;
  }

  static List<Leg> getLegs({required List<int> legsSize, List<Leg>? gettingLegs}) {
    List<Leg> legs = [];
    double left = 0;
    double right = 0;
    if(gettingLegs == null) {
      Leg? leg;
      for(int i=0; i<legsSize.length; i++) {
        int index = Legs._getLegBySize[legsSize[i]-1][Random().nextInt(Legs._getLegBySize[legsSize[i]-1].length)];
        if(Random().nextInt(2) == 0) {
          if(right+Legs.rightLegs[index].scSize.right < 570) {
            leg = Legs.rightLegs[index];
            leg.sidee = Sidee.right;
            leg.scSize.getRight = right;
            legs.add(leg);
            right += leg.scSize.right;
          } else {
            leg = Legs.leftLegs[index];
            leg.sidee = Sidee.left;
            leg.scSize.getLeft = left;
            legs.add(leg);
            left += leg.scSize.left;
          }
        } else {
          if(left+Legs.leftLegs[index].scSize.left < 410) {
            leg = Legs.leftLegs[index];
            leg.sidee = Sidee.left;
            leg.scSize.getLeft = left;
            legs.add(leg);
            left += leg.scSize.left;
          } else {
            leg = Legs.rightLegs[index];
            leg.sidee = Sidee.right;
            leg.scSize.getRight = right;
            legs.add(leg);
            right += leg.scSize.right;
          }
        }
      }
      return legs;
    } else {

      for(int i=0;i<gettingLegs.length; i++) {
        if(gettingLegs[i].balls.isEmpty) {
          gettingLegs.removeAt(i);
        }
      }
      Log.log("${gettingLegs.length}", name: "gettingLegs");
      return gettingLegs;
    }
  }
}