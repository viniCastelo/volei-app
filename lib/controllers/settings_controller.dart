import 'package:get/get.dart';
import 'package:volei/controllers/home_controller.dart';
import 'package:volei/util/global/global.dart';

class SettingsController extends GetxController with Global {
  void standardScoreLimit() {
    getPreferences();
    setRestartScoreLimite(scoreLimit);
    update();
  }
}
