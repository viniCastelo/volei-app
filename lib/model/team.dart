import 'package:confetti/confetti.dart';
import 'package:flutter/animation.dart';

class Team {
  late int _pontos = 0;
  late bool _win = false;

  Color? _primaryColor;
  String? _titleTeam;
  // ignore: unused_field
  late final ConfettiController _controller = ConfettiController();

  Team(this._titleTeam, this._primaryColor);

  int get getPontos {
    return _pontos;
  }

  String get getTitleTeam {
    return _titleTeam!;
  }

  Color get getColor {
    return _primaryColor!;
  }

  ConfettiController get getController {
    return _controller;
  }

  bool get getWin {
    return _win;
  }

  set titleTeam(String titleTeam) {
    _titleTeam = titleTeam;
  }

  set win(bool status) {
    _win = status;
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
