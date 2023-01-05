// ignore_for_file: unnecessary_getters_setters, prefer_final_fields, avoid_return_types_on_setters

class Global {
  static int _scoreLimit = 15;
  static int _scoreLimitChangeSide = 8;
  static bool _changeSide = true;

  static int get scoreLimit => _scoreLimit;
  static int get scoreLimitChangeSide => _scoreLimitChangeSide;
  static bool get changeSide => _changeSide;

  static void set scoreLimit(int score) => _scoreLimit = score;
  static void set scoreLimitChangeSide(int score) =>
      _scoreLimitChangeSide = score;
  static void set changeSide(bool condition) => _changeSide = condition;
}
