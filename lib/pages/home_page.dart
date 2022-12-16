import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:volei/components/buttons/shift_button.dart';
import 'package:volei/components/counter/counter.dart';
import 'package:volei/components/counter/point_counter.dart';
import 'package:volei/components/labels/team_title.dart';
import 'package:volei/components/separators/dashed_line_vertical.dart';
import 'package:volei/model/team.dart';
import 'package:volei/util/standard_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Team teamA = Team('TIME: ', teamMainColor);
  Team teamB = Team('TIME: ', teamSecondaryColor);

  String standardTitle = 'TIME: ';

  bool isModified = false;
  bool isPlaying = false;

  var pontosLimite = 15;

  void _validateWin(Team primary, Team secondary) {
    setState(() {
      var comparatorPrimary = primary.getPontos - (pontosLimite - 1);
      var comparatorSecondary = secondary.getPontos - (pontosLimite - 1);

      if (comparatorPrimary == 0 && comparatorSecondary == 0) {
        pontosLimite++;
      }

      if (isModified == false) {
        if (primary.getPontos == pontosLimite) {
          isPlaying = true;
          primary.getController.play();
          primary.win = true;
          secondary.win = false;
        } else if (secondary.getPontos == pontosLimite) {
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
        if (primary.getPontos == pontosLimite) {
          isPlaying = true;
          secondary.getController.play();
          secondary.win = true;
          primary.win = false;
        } else if (secondary.getPontos == pontosLimite) {
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
    });
  }

  @override
  void initState() {
    super.initState();

    teamA.getController.addListener(() {
      setState(() {
        isPlaying == true
            ? teamA.getController.state == ConfettiControllerState.playing
            : teamA.getController.state == ConfettiControllerState.stopped;
      });
    });

    teamB.getController.addListener(() {
      setState(() {
        isPlaying == true
            ? teamB.getController.state == ConfettiControllerState.playing
            : teamB.getController.state == ConfettiControllerState.stopped;
      });
    });
  }

  @override
  void dispose() {
    teamA.getController.dispose();
    teamB.getController.dispose();
    super.dispose();
  }

  void _increment(Team primary, Team secondary) {
    setState(() {
      if (isPlaying == false) {
        isModified == false ? primary.increment() : secondary.increment();
        _validateWin(primary, secondary);
        _changeSide();
      }
    });
  }

  void _decrement(Team primary, Team secondary) {
    setState(() {
      isModified == false ? primary.decrement() : secondary.decrement();
      _validateWin(primary, secondary);
      _changeSide();
    });
  }

  void _fixedWinner(Team primary, Team secondary) {
    setState(() {
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
    });
  }

  void _reset(Team primary, Team secondary) {
    setState(() {
      if (isModified == true) {
        if (primary.getPontos == 0) {
          _fixedWinner(primary, secondary);
          secondary.resetPoints();
          _standardValues();
        } else if (primary.getPontos > 0) {
          secondary.resetPoints();
        }
      } else {
        primary.resetPoints();
        _standardValues();
      }
    });
  }

  void _changeSide() {
    setState(() {
      if ((teamA.getPontos >= 8) || (teamB.getPontos >= 8)) {
        isModified = true;
      } else {
        isModified = false;
      }
    });
  }

  void _standardValues() {
    setState(() {
      isModified = false;
      isPlaying = false;
      pontosLimite = 15;
      teamA.getController.stop();
      teamB.getController.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Placar do Jogo',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
        backgroundColor: appBarMainColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TeamTitle(
                    winMethod: ConfettiWidget(
                      confettiController: teamA.getController,
                      shouldLoop: true,
                      blastDirectionality: BlastDirectionality.explosive,
                      emissionFrequency: 0.04,
                    ),
                    team: isModified == false ? teamA : teamB,
                  ),
                ),
                ShiftButton(
                  color: isModified == false
                      ? dividerMainColor
                      : dividerSecondaryColor,
                  method: () {
                    _changeSide();
                    _validateWin(teamA, teamB);
                  },
                ),
                Expanded(
                  flex: 1,
                  child: TeamTitle(
                    winMethod: ConfettiWidget(
                      confettiController: teamB.getController,
                      shouldLoop: true,
                      blastDirectionality: BlastDirectionality.explosive,
                      emissionFrequency: 0.04,
                    ),
                    team: isModified == false ? teamB : teamA,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PointCounter(
                    title: const Text(
                      'Pontuação',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey,
                      ),
                    ),
                    child: Counter(
                      value: isModified == false
                          ? teamA.getPontos
                          : teamB.getPontos,
                      incrementMethod: () {
                        _increment(teamA, teamB);
                      },
                      decrementMethod: () {
                        _decrement(teamA, teamB);
                      },
                      resetMethod: () {
                        _reset(teamA, teamB);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: CustomPaint(
                    painter: DashedLineVertical(
                      isModified == false
                          ? dividerMainColor
                          : dividerSecondaryColor,
                    ),
                    size: const Size(0, double.maxFinite),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PointCounter(
                    title: const Text(
                      'Pontuação',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ),
                    child: Column(
                      children: [
                        Counter(
                          value: isModified == false
                              ? teamB.getPontos
                              : teamA.getPontos,
                          incrementMethod: () {
                            _increment(teamB, teamA);
                          },
                          decrementMethod: () {
                            _decrement(teamB, teamA);
                          },
                          resetMethod: () {
                            _reset(teamB, teamA);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
