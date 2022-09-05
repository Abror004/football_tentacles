import 'package:football_tentacles/screens/home_screen/home_controller.dart';
import 'package:football_tentacles/screens/play_page/play_controller.dart';
import 'package:get/get.dart';

class DIService implements Bindings {
@override
void dependencies() {
  // Get.lazyPut<GameController>(() => GameController(), fenix: true);
  Get.lazyPut<PlayController>(() => PlayController(), fenix: true);
  Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
}
}