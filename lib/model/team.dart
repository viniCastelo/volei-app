import 'package:flutter/animation.dart';

class Team {
  late int _pontos = 0;

  late final Color _primaryColor;
  late final String _titleTeam;

  Team(this._titleTeam, this._primaryColor);

  int get getPontos {
    return _pontos;
  }

  String get getTitleTeam {
    return _titleTeam;
  }

  Color get getColor {
    return _primaryColor;
  }

  set setTitleTeam(String titleTeam) {
    _titleTeam = titleTeam;
  }

  set setColor(Color color) {
    _primaryColor = color;
  }

  void increment() {
    _pontos++;
  }

  void decrement() {
    if (getPontos > 0) {
      _pontos--;
    }
  }

  void resetPoints() {
    _pontos = 0;
  }
}
