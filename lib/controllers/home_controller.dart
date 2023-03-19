import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:volei/model/team.dart';
import 'package:volei/util/colors/standard_colors.dart';
import 'package:volei/util/global/global.dart';

class HomeController extends GetxController with Global {
  Team teamA = Team('', teamMainColor);
  Team teamB = Team('', teamSecondaryColor);

  String standardTitle = '';

  bool isModified = false;
  bool isPlaying = false;

  Team get verifyTeam1 => !isModified ? teamA : teamB;
  Team get verifyTeam2 => isModified ? teamA : teamB;

  void incrementScoreLimit() {
    scoreLimit = (scoreLimit + 1);
    //setScoreLimit(scoreLimit + 1);
    update();
  }

  void decrementScoreLimit() {
    if (scoreLimit > 1) {
      scoreLimit = (scoreLimit - 1);
      //setScoreLimit(scoreLimit - 1);
      update();
    }
  }

  void incrementScoreLimitToToogle() {
    setScoreLimitChangeSide(scoreLimitChangeSide + 1);
    update();
  }

  void decrementScoreLimitToToogle() {
    if (scoreLimitChangeSide > 1) {
      setScoreLimitChangeSide(scoreLimitChangeSide - 1);
    }
    update();
  }

  void validateWin(Team primary, Team secondary) {
    var comparatorPrimary = primary.getPontos - (scoreLimit - 1);
    var comparatorSecondary = secondary.getPontos - (scoreLimit - 1);

    if (comparatorPrimary == 0 &&
        comparatorSecondary == 0 &&
        allowExtendLimit) {
      setScoreLimit(scoreLimit + 1);
    }

    if (isModified == false) {
      if (primary.getPontos == scoreLimit) {
        isPlaying = true;
        primary.getController.play();
        primary.win = true;
        secondary.win = false;
      } else if (secondary.getPontos == scoreLimit) {
        isPlaying = true;
        secondary.getController.play();
        secondary.win = true;
        primary.win = false;
      } else {
        isPlaying = false;
        primary.win = false;
        secondary.win = false;
        primary.getController.stop();
        secondary.getController.stop();
      }
    } else {
      if (primary.getPontos == scoreLimit) {
        isPlaying = true;
        secondary.getController.play();
        secondary.win = true;
        primary.win = false;
      } else if (secondary.getPontos == scoreLimit) {
        isPlaying = true;
        primary.getController.play();
        primary.win = true;
        secondary.win = false;
      } else {
        isPlaying = false;
        primary.win = false;
        secondary.win = false;
        primary.getController.stop();
        secondary.getController.stop();
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();

    getPreferences();

    teamA.getController.addListener(() {
      isPlaying == true
          ? teamA.getController.state == ConfettiControllerState.playing
          : teamA.getController.state == ConfettiControllerState.stopped;
    });

    teamB.getController.addListener(() {
      isPlaying == true
          ? teamB.getController.state == ConfettiControllerState.playing
          : teamB.getController.state == ConfettiControllerState.stopped;
    });
  }

  @override
  void dispose() {
    teamA.getController.dispose();
    teamB.getController.dispose();
    super.dispose();
  }

  void increment(Team primary, Team secondary) {
    if (isPlaying == false) {
      isModified == false ? primary.increment() : secondary.increment();
      validateWin(primary, secondary);
      toogleSide();
    }
    update();
  }

  void decrement(Team primary, Team secondary) {
    isModified == false ? primary.decrement() : secondary.decrement();
    validateWin(primary, secondary);
    toogleSide();
    update();
  }

  void fixedWinner(Team primary, Team secondary) {
    if (primary.getWin == true) {
      primary.titleTeam = secondary.getTitleTeam;
      secondary.titleTeam = standardTitle;
      primary.setColor = teamSecondaryColor;
      secondary.setColor = teamMainColor;
    } else if (secondary.getWin == true) {
      secondary.titleTeam = primary.getTitleTeam;
      primary.titleTeam = standardTitle;
      secondary.setColor = teamMainColor;
      primary.setColor = teamSecondaryColor;
    }
    update();
  }

  void reset(Team primary, Team secondary) {
    if (isModified == true) {
      if (primary.getPontos == 0) {
        fixedWinner(primary, secondary);
        secondary.resetPoints();
        standardValues();
      } else if (primary.getPontos > 0) {
        secondary.resetPoints();
      }
    } else {
      primary.resetPoints();
      standardValues();
    }
    update();
  }

  void toogleSide() {
    if (changeSide) {
      if ((teamA.getPontos >= scoreLimitChangeSide) ||
          (teamB.getPontos >= scoreLimitChangeSide)) {
        isModified = true;
      } else {
        isModified = false;
      }
    }
    update();
  }

  void toogleAllowExtendLimit(bool? _) {
    setAllowExtendLimit(!allowExtendLimit);
    update();
  }

  void toogleChangeSide(bool? _) {
    setChangeSide(!changeSide);
    update();
  }

  void standardValues() {
    getPreferences();
    isModified = false;
    isPlaying = false;
    teamA.getController.stop();
    teamB.getController.stop();
    setScoreLimit(restartScoreLimit);
    update();
  }
}
