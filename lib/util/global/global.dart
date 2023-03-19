// ignore_for_file: unnecessary_getters_setters, prefer_final_fields, avoid_return_types_on_setters

import 'package:get_storage/get_storage.dart';

class Global {
  GetStorage storage = GetStorage();

  int _scoreLimit = 15;
  int _restarScoreLimit = 15;
  int _scoreLimitChangeSide = 8;
  bool _allowExtendLimit = true;
  bool _changeSide = true;

  int get scoreLimit => _scoreLimit;
  int get restartScoreLimit => _restarScoreLimit;
  int get scoreLimitChangeSide => _scoreLimitChangeSide;

  bool get allowExtendLimit => _allowExtendLimit;
  bool get changeSide => _changeSide;

  void set scoreLimit(int value) {
    _scoreLimit = value;
    storage.write('scoreLimit', value);
  }

  void set restartScoreLimit(int value) {
    _restarScoreLimit = value;
    storage.write('restartScoreLimit', value);
  }

  void setScoreLimit(int value) {
    scoreLimit = value;
    storage.write('scoreLimit', value);
  }

  void setRestartScoreLimite(int value) {
    restartScoreLimit = value;
    storage.write('restartScoreLimit', value);
  }

  void setScoreLimitChangeSide(int value) {
    _scoreLimitChangeSide = value;
    storage.write('scoreLimitChangeSide', value);
  }

  void setAllowExtendLimit(bool value) {
    _allowExtendLimit = value;
    storage.write('allowExtendLimit', value);
  }

  void setChangeSide(bool value) {
    _changeSide = value;
    storage.write('changeSide', value);
  }

  void getPreferences() {
    final xAllowExtendScoreLimit = storage.read('allowExtendScoreLimit');
    _allowExtendLimit = xAllowExtendScoreLimit != false;

    final xChangeSide = storage.read('changeSide');
    _changeSide = xChangeSide != false;

    final xScoreLimit = storage.read('scoreLimit');
    _scoreLimit = int.tryParse(xScoreLimit.toString()) ?? 15;

    final xRestartScoreLimit = storage.read('restartScoreLimit');
    _restarScoreLimit = int.tryParse(xRestartScoreLimit.toString()) ?? 15;

    final xScoreLimitChangeSide = storage.read('scoreLimitChangeSide');
    _scoreLimitChangeSide = int.tryParse(xScoreLimitChangeSide.toString()) ?? 8;
  }
}
