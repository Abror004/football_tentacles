import 'dart:async';
import 'dart:developer' as l;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:football_tentacles/model/leg_model.dart';
import 'package:get/get.dart';

enum Side { left, right }

class PlayController extends GetxController with WidgetsBindingObserver {
  bool active = true;
  Duration pausedTime = const Duration(seconds: 3);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    l.log('state = $state');
    if (state == AppLifecycleState.inactive) {
      pausedTime = Duration(milliseconds: DateTime.now().difference(dateTime).inMilliseconds-100);
      l.log("difference: ${pausedTime.inMilliseconds}");
      timer!.cancel();
    } else if (state == AppLifecycleState.resumed) {
      l.log("start: ${(const Duration(seconds: 3) - pausedTime).inMilliseconds}");
      Future.delayed(const Duration(seconds: 3)).then((value) => {
            timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
              if (DateTime.now().difference(dateTime).inSeconds >= 3) {
                check(i: -1);
                dateTime = DateTime.now();
              }
              if (defeat) {
                timer.cancel();
              }
              l.log("${DateTime.now().difference(dateTime).inMilliseconds}");
              // l.log("${Duration(seconds: 3).inMilliseconds}");
            })
          });
      pausedTime = const Duration(seconds: 3);
    }
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  int heart = 3;
  bool defeat = false;
  int level = 1;
  bool checkUpload = true; // oyoqlani get qvoguncha buttonla bosilmasligi uchun
  int ball = 0;
  DateTime dateTime = DateTime.now();

  //
  LevelSet levelSet = LevelSet();
  List<int> legs = [];
  List<bool> visible = [];
  List<Side> sides = [];
  List<Sizes> legsSizes = [];
  int changeIndex = 0;
  List legsIndexs = [];
  Timer? timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    l.log("onInit");
    legs = List.generate(4, (index) => 0);
    visible = List.generate(4, (index) => false);
    sides = List.generate(4, (index) => Side.left);
    legsSizes = List.generate(4, (index) => Sizes.empty());
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (DateTime.now().difference(dateTime).inSeconds >= 3) {
        check(i: -1);
        dateTime = DateTime.now();
      }
      if (defeat) {
        timer.cancel();
      }
      l.log("${DateTime.now().difference(dateTime).inMilliseconds}");
    });
    update();
    nextLevel();
  }

  void check({required int i}) async {
    if (!defeat) {
      if (i == ball) {
        level++;
      } else {
        heart--;
        if (heart < 1) {
          defeat = true;
        }
      }
    }
    if (!defeat) {
      checkUpload = true;
      legs = List.generate(4, (index) => 0);
      visible = List.generate(4, (index) => false);
      sides = List.generate(4, (index) => Side.left);
      legsSizes = List.generate(4, (index) => Sizes.empty());
      update();
      nextLevel();
    }
    update();
  }

  String getHeart(int i) {
    if (i > heart) {
      return "assets/game_images/heart_off.png";
    } else {
      return "assets/game_images/heart_on.png";
    }
  }

  void nextLevel() {
    double leftMax = 410; // chap tomon max uzunligi
    double rightMax = 500; // ong tomon max uzunligi
    int leftCount = 0; // chap oyoqlar soni
    levelSet =
        LevelSet(); // keyinigi levelga otishdan oldin boshlangish holatga keluvchi ozgaruvchilar
    Future.delayed(const Duration(milliseconds: 200), () {
      checkUpload = false;
      update();
    }); // keyingi levelga otvotganda aniatsiya uchun kerak
    ///______________________________________{koptola olinadi}______________________________________________________
    ball = Random().nextInt(4) + 4; // 4...7 koptola tanlandi
    ///______________________________________{tomonlaga raqsimlanadi}_______________________________________________
    levelSet.left = Random().nextInt(3) + 2; // chap tomon 2...4 koptola oladi
    levelSet.right = ball - levelSet.left; // qolgan qismi ong tomonga olinadi
    ///______________________________________{random chap oyola tanladadi}__________________________________________
    levelSet.listIndex = Random().nextInt(legsHeight[levelSet.left - 1]
        .length); // oyola kopto sigimi boyicha random tanlanadi
    legsHeight[levelSet.left - 1].shuffle(); // kartani suzgande suzib olanidi
    levelSet.legsSize = legsHeight[levelSet.left - 1][levelSet
        .listIndex]; // va oyola listi tanlanadi | [ masalan ] 3ta koptoga [1,2]
    List<int> item = legsHeight[levelSet.left - 1][levelSet
        .listIndex]; //____________________________________________________________________________________<<<
    legsHeight[levelSet.left - 1].removeAt(levelSet
        .listIndex); // qayta tanlanmasligi uchun olib tashlanadi va qayta qoyish uchun ozgaruvchiga olinadi ^
    levelSet.legsSize
        .shuffle(); // chap tomon tanlangan oyola aralashtirib olinadi
    ///______________________________________{chap oyolaga balandli beriladi}______________________________________________________
    for (int i = 0; i < levelSet.legsSize.length; i++) {
      legs[changeIndex] = levelSet.legsSize[i]; // chap tomon oyola indexlari ovolindi | [ masalan ]::- [0,7] 0 - chap tomon 0 chi | 7 - ong tomon 1(= 7 % 6)
      sides[changeIndex] = Side.left; // chap tomonligini berildi
      if (levelSet.leftCount == 1) {
        legsSizes[changeIndex] = Sizes(l: Legs.getTop(i: legs[changeIndex - 1]), r: 0); // agar tepasida oyo bosa undan pasda turishi uchun balandlik qoshiladi
      }
      leftMax -= Legs.getTop(i: legs[changeIndex]); // chap tomon obshiy size dan ayiriladi | [ sabab ] ::- oyolani tepasi yoki pasida bosh joy borligini bilish uchun
      visible[changeIndex] = true; // tanlangan oyoq korinishi uchun
      changeIndex++; // tanlangan oyoqlani indexi | [ sabab ] ::- tanlangan oyola ajralib turishi uchun
      levelSet.leftCount++; // chap tomonda neshta oyo boganini sanab ketadi | [ sabab ] ::- ozidan tepada oyo borligini bilish uchun
    }

    ///______________________________________{oyolaga random balandliga otib olishi uchun}______________________________________________________
    if (leftMax > 0) {
      // agar obshiy size = 410;  410-(275+225) bu holda joy ozgarmaydi
      if (changeIndex == 2) {
        // 2 ta yoki 1 ta oyo borligini bilish uchun | [ sabab ] agar 2ta bosa ikkoviniyam joyi ozgaradi
        double add = Random().nextInt(leftMax ~/ 2).toDouble(); // qancha pasga tuwiwi olindi
        legsSizes[0].l += add; // pasga tuwirildi
        legsSizes[1].l += Random().nextInt((leftMax - add).toInt()).toDouble() + add; // 2chi qolgan istalgan joyga otib oladi
      } else {
        legsSizes[0].l += Random().nextInt(leftMax.toInt()).toDouble(); // istalgan joyga otib oladi
      }
    }

    leftCount = changeIndex; // chap tomon count olinadi
    ///______________________________________{ong oyolaga balandli beriladi}______________________________________________________
    if (levelSet.right >= 1) {
      // agar ong tomonda kopto bosa kiriladi va chap tomondagideg funksiyalar bajariladi ^
      levelSet.listIndex = Random().nextInt(legsHeight[levelSet.right - 1].length);
      legsHeight[levelSet.left - 1].shuffle();
      levelSet.legsSize = legsHeight[levelSet.right - 1][levelSet.listIndex];
      levelSet.legsSize.shuffle();
      for (int i = 0; i < levelSet.legsSize.length; i++) {
        legs[changeIndex] = levelSet.legsSize[i] + 6;
        sides[changeIndex] = Side.right;
        if (levelSet.rightCount == 1) {
          legsSizes[changeIndex] = Sizes(l: 0, r: Legs.getTop(i: legs[changeIndex - 1]));
        }
        rightMax -= Legs.getTop(i: legs[changeIndex]);
        visible[changeIndex] = true;
        changeIndex++;
        levelSet.rightCount++;
      }
    }

    ///______________________________________{oyolaga random balandliga otib olishi uchun}______________________________________________________
    if (rightMax > 0) {
      // chap oyola olingande olinadi
      if (changeIndex - leftCount == 2) {
        double add = Random().nextInt(rightMax ~/ 2).toDouble();
        legsSizes[changeIndex - 2].r += add;
        legsSizes[changeIndex - 1].r += Random().nextInt((rightMax - add).toInt()).toDouble() + add;
      } else if (changeIndex - leftCount == 1) {
        legsSizes[changeIndex - 1].r += Random().nextInt(rightMax.toInt()).toDouble();
      }
    }

    ///______________________________________{bir xil joydagi koptolani ozgartirish}______________________________________________________
    double h1 = 0;
    double h2 = 0;
    double w1 = 0;
    double w2 = 0;
    for (int i = 0; i < changeIndex - 1; i++) {
      for (int b = 0; b < Legs.getLeg(i: legs[i]).balls.length; b++) {
        for (int i2 = i + 1; i2 < changeIndex; i2++) {
          for (int b2 = 0; b2 < Legs.getLeg(i: legs[i2]).balls.length; b2++) {
            w1 = Legs.getLeg(i: legs[i]).left! + Legs.getLeg(i: legs[i]).balls[b].left;
            w2 = Legs.getLeg(i: legs[i2]).left! + Legs.getLeg(i: legs[i2]).balls[b2].left;
            if ((w1 - w2).abs() < 50) {
              h1 = Legs.getLeg(i: legs[i]).scSize.hSize + (sides[i] == Side.left ? legsSizes[i].l : legsSizes[i].r) + Legs.getLeg(i: legs[i]).balls[b].top;
              h2 = Legs.getLeg(i: legs[i2]).scSize.hSize + (sides[i2] == Side.left ? legsSizes[i2].l : legsSizes[i2].r) + Legs.getLeg(i: legs[i2]).balls[b2].top;
              if ((h1 - h2).abs() < 50) {
                // l.log("kirdi: h1: ${h1} | h2: ${h2} | w1: ${w1} | w2: ${w2}", name: "$level");
                if (Legs.getLeg(i: legs[i]).maxSize == 3) {
                  legsSizes[i].l -= 39;
                  legsSizes[i].r -= 39;
                } else {
                  legsSizes[i2].l -= 39;
                  legsSizes[i2].r -= 39;
                }
              }
            }
          }
        }
      }
    }

    legsHeight[levelSet.left - 1].add(item); // chap tomonga berilgan list qaytarib joyiga qoyiladi
    changeIndex = 0; // tanlangan oyola indexi 0 ga tenglanadi
    dateTime = DateTime.now(); // 3 sekunk boshlandi
    update();
  }

  List<List<List<int>>> legsHeight = [
    [[0]],
    [[1], [2], [3]],
    [[0, 1], [0, 2], [0, 3], [4], [5]],
    [[2, 3], [0, 4], [0, 5]],
    [[2, 5], [3, 5]]
  ];

  List<List<List<int>>> mainLegs = [
    [[0]],
    [[1], [2], [3]],
    [[0, 1], [0, 2], [0, 3], [4], [5]],
    [[2, 3], [0, 4], [0, 5]],
    [[2, 5], [3, 5]]
  ];
}

class LevelSet {
  int left = 0;
  int right = 0;

  List<int> legsSize = [];
  int listIndex = 0;
  int leftCount = 0;
  int rightCount = 0;

  LevelSet();
}

class Legs {
  static Leg getLeg({required int i}) {
    if (i > 5 && i < 12) {
      return rightLegs[i % 6];
    } else {
      return leftLegs[i];
    }
  }

  static double getTop({required int i}) {
    if (i > 5 && i < 12) {
      return rightLegs[i % 6].scSize.right;
    } else {
      return leftLegs[i].scSize.left;
    }
  }

  static List<Leg> leftLegs = [
    Leg(
        height: 120,
        width: 200,
        left: -60,
        top: -40,
        text: "assets/$_path/${_left}1.png",
        maxSize: 1,
        index: 0,
        balls: [Ball(top: 70, left: 155)],
        scSize: ScreenSize(hSize: 10, left: 45, right: 0)),
    Leg(
        height: 267,
        width: 201,
        left: -60,
        top: 15,
        text: "assets/$_path/${_left}2.png",
        maxSize: 2,
        index: 1,
        balls: [Ball(top: 5, left: 155), Ball(top: 200, left: 170)],
        scSize: ScreenSize(hSize: 85, left: 275, right: 0)),
    Leg(
        height: 289,
        width: 260,
        left: -70,
        top: -25,
        text: "assets/$_path/${_left}3.png",
        maxSize: 2,
        index: 2,
        balls: [Ball(top: 50, left: 210), Ball(top: 190, left: 140)],
        scSize: ScreenSize(hSize: 45, left: 215, right: 0)),
    Leg(
        height: 218,
        width: 216,
        left: -60,
        top: 15,
        text: "assets/$_path/${_left}4.png",
        maxSize: 2,
        index: 3,
        balls: [Ball(top: 10, left: 180), Ball(top: 160, left: 150)],
        scSize: ScreenSize(hSize: 85, left: 225, right: 0)),
    Leg(
        height: 329,
        width: 248,
        left: -70,
        top: 10,
        text: "assets/$_path/${_left}5.png",
        maxSize: 3,
        index: 4,
        balls: [
          Ball(top: 10, left: 210),
          Ball(top: 140, left: 145),
          Ball(top: 265, left: 135)
        ],
        scSize: ScreenSize(hSize: 85, left: 325, right: 0)),
    Leg(
        height: 386,
        width: 401,
        left: -128,
        top: -60,
        text: "assets/$_path/${_left}6.png",
        maxSize: 3,
        index: 5,
        balls: [
          Ball(top: 80, left: 320),
          Ball(top: 175, left: 225),
          Ball(top: 280, left: 190)
        ],
        scSize: ScreenSize(hSize: 10, left: 280, right: 115))
  ];

  static List<Leg> rightLegs = [
    Leg(
        height: 120,
        width: 200,
        left: 220,
        top: -55,
        text: "assets/$_path/${_right}1.png",
        maxSize: 1,
        index: 0,
        balls: [Ball(top: 70, left: 5)],
        scSize: ScreenSize(hSize: -60, left: 0, right: 45)),
    Leg(
        height: 267,
        width: 201,
        left: 224,
        top: 15,
        text: "assets/$_path/${_right}2.png",
        maxSize: 2,
        index: 1,
        balls: [Ball(top: 5, left: 5), Ball(top: 200, left: -5)],
        scSize: ScreenSize(hSize: 15, left: 0, right: 275)),
    Leg(
        height: 289,
        width: 260,
        left: 180,
        top: -25,
        text: "assets/$_path/${_right}3.png",
        maxSize: 2,
        index: 2,
        balls: [Ball(top: 50, left: 10), Ball(top: 190, left: 80)],
        scSize: ScreenSize(hSize: -25, left: 0, right: 215)),
    Leg(
        height: 218,
        width: 216,
        left: 192,
        top: 15,
        text: "assets/$_path/${_right}4.png",
        maxSize: 2,
        index: 3,
        balls: [Ball(top: 10, left: -5), Ball(top: 170, left: 25)],
        scSize: ScreenSize(hSize: 15, left: 0, right: 225)),
    Leg(
        height: 329,
        width: 248,
        left: 180,
        top: 10,
        text: "assets/$_path/${_right}5.png",
        maxSize: 3,
        index: 4,
        balls: [
          Ball(top: 15, left: 0),
          Ball(top: 130, left: 65),
          Ball(top: 245, left: 65)
        ],
        scSize: ScreenSize(hSize: 15, left: 0, right: 325)),
    Leg(
        height: 386,
        width: 401,
        left: 100,
        top: -60,
        text: "assets/$_path/${_right}6.png",
        maxSize: 3,
        index: 5,
        balls: [
          Ball(top: 80, left: 40),
          Ball(top: 170, left: 135),
          Ball(top: 290, left: 180)
        ],
        scSize: ScreenSize(hSize: -60, left: 115, right: 280))
  ];

  static const String ball = "assets/game_images/ball.png";
  static const String _path = "game_images";
  static const String _left = "leg_left_";
  static const String _right = "leg_right_";
}

class Sizes {
  double l = 0; // left
  double r = 0; // right

  Sizes({required this.l, required this.r});

  Sizes.empty();

  @override
  String toString() {
    // TODO: implement toString
    return "l: $l , r: $r |";
  }
}
