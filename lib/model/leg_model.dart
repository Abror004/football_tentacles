import 'package:football_tentacles/screens/play_screen/play_controller.dart';

class Leg{
  double? top;
  double? left;
  double? height;
  double? width;
  String? text;
  int? maxSize;
  List<Ball> balls = [];
  int index = 0;
  ScreenSize scSize = ScreenSize.empty();
  Sidee? sidee;

  Leg({
    required this.height,
    required this.width,
    required this.left,
    required this.text,
    required this.top,
    required this.maxSize,
    required this.balls,
    required this.index,
    required this.scSize
  });

  @override
  String toString() {
    // TODO: implement toString
    return "i: $index | sidee: $sidee | top: $top | \nscSize: ${scSize.toString()} | \n ball: ${balls}";
  }
}

class Ball {
  late double left;
  late double top;

  Ball({required this.top, required this.left});
}


/// hSize - eng pasdagi position
/// left - left balandligi
/// right - right balandligi
class ScreenSize {
  double hSize = 0;
  double left = 0;
  double right = 0;
  double getLeft = 0;
  double getRight = 0;

  ScreenSize.empty();
  ScreenSize({required this.hSize, required this.left, required this.right});

  @override
  String toString() {
    // TODO: implement toString
    return "[ hSize: $hSize | left: $left | right: $right]";
  }
}

// class SideListItem {
//   he
//   bool isEmpty = false;
// }