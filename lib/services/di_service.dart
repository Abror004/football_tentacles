import 'package:football_tentacles/screens/play_screen/play_controller.dart';
import 'package:get/get.dart';

class DIService implements Bindings {
@override
void dependencies() {

  Get.lazyPut<GameController>(() => GameController(), fenix: true);
  // Get.lazyPut<LevelsController>(() => LevelsController(), fenix: true);
  // Get.lazyPut<Level1Controller>(() => Level1Controller(), fenix: true);
  // Get.lazyPut<Level3Controller>(() => Level3Controller(), fenix: true);
}
}