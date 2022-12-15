import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:volei/components/buttons/shift_button.dart';
import 'package:volei/components/counter/counter.dart';
import 'package:volei/components/counter/point_counter.dart';
import 'package:volei/components/labels/team_title.dart';
import 'package:volei/components/separators/dashed_line_vertical.dart';
import 'package:volei/model/team.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Team teamA = Team('Time - A', const Color.fromRGBO(17, 47, 77, 1));
  Team teamB = Team('Time - B', const Color.fromRGBO(255, 194, 57, 1));

  Color primaryColor = Colors.grey[400]!;
  Color secondaryColor = Colors.cyan;

  bool isModified = false;
  bool isPlaying = false;

  var pontosLimite = 15;

  void _validateWin(Team teamA, Team teamB) {
    setState(() {
      if ((teamA.getPontos >= 14 && teamB.getPontos >= 14) &&
          (teamA.getPontos == teamB.getPontos)) {
        pontosLimite++;
      }

      if (isModified == false) {
        if (teamA.getPontos == pontosLimite) {
          isPlaying = true;
          teamA.getController.play();
        } else if (teamB.getPontos == pontosLimite) {
          isPlaying = true;
          teamB.getController.play();
        } else {
          isPlaying = false;
          teamA.getController.stop();
          teamB.getController.stop();
        }
      } else {
        if (teamA.getPontos == pontosLimite) {
          isPlaying = true;
          teamB.getController.play();
        } else if (teamB.getPontos == pontosLimite) {
          isPlaying = true;
          teamA.getController.play();
        } else {
          isPlaying = false;
          teamA.getController.stop();
          teamB.getController.stop();
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

  void _increment(Function fn) {
    setState(() {
      if (isPlaying == false) {
        fn();
        _changeSide();
      }
    });
  }

  void _decrement(Function fn) {
    setState(() {
      fn();
      _changeSide();
    });
  }

  void _reset(Function fn) {
    setState(() {
      if (teamA.getPontos == 0 && teamB.getPontos == 0) {
        isModified = false;
      }
      fn();
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

  void _standardValues(Team x, Team y) {
    setState(() {
      isModified = false;
      isPlaying = false;
      pontosLimite = 15;
      x.getController.stop();
      y.getController.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Placar do Jogo',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 57, 114),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TeamTitle(
                    winMethod: ConfettiWidget(
                      confettiController: teamA.getController,
                      shouldLoop: true,
                      blastDirectionality: BlastDirectionality.explosive,
                    ),
                    team: isModified == false ? teamA : teamB,
                    /*
                      title: isModified == false
                        ? teamA.getTitleTeam
                        : teamB.getTitleTeam,
                    */
                    color:
                        isModified == false ? teamA.getColor : teamB.getColor,
                  ),
                ),
                ShiftButton(
                  color: isModified == false ? primaryColor : secondaryColor,
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
                    ),
                    team: isModified == false ? teamB : teamA,
                    /*
                      title: isModified == false
                        ? teamB.getTitleTeam
                        : teamA.getTitleTeam,
                    */
                    color:
                        isModified == false ? teamB.getColor : teamA.getColor,
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
                        isModified == false
                            ? _increment(teamA.increment)
                            : _increment(teamB.increment);
                        _validateWin(teamA, teamB);
                      },
                      decrementMethod: () {
                        isModified == false
                            ? _decrement(teamA.decrement)
                            : _decrement(teamB.decrement);
                        _validateWin(teamA, teamB);
                      },
                      resetMethod: () {
                        if (isModified == true) {
                          if (teamA.getPontos == 0) {
                            _reset(teamB.resetPoints);
                            _standardValues(teamA, teamB);
                          } else if (teamA.getPontos > 0) {
                            _reset(teamB.resetPoints);
                          }
                        } else {
                          _reset(teamA.resetPoints);
                          _standardValues(teamA, teamB);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: CustomPaint(
                    painter: DashedLineVertical(
                      isModified == false ? primaryColor : secondaryColor,
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
                            isModified == false
                                ? _increment(teamB.increment)
                                : _increment(teamA.increment);
                            _validateWin(teamA, teamB);
                          },
                          decrementMethod: () {
                            isModified == false
                                ? _decrement(teamB.decrement)
                                : _decrement(teamA.decrement);
                            _validateWin(teamA, teamB);
                          },
                          resetMethod: () {
                            if (isModified == true) {
                              if (teamB.getPontos == 0) {
                                _reset(teamA.resetPoints);
                                _standardValues(teamA, teamB);
                              } else if (teamB.getPontos > 0) {
                                _reset(teamA.resetPoints);
                              }
                            } else {
                              _reset(teamB.resetPoints);
                              _standardValues(teamA, teamB);
                            }
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
