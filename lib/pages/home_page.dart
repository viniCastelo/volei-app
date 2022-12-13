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
  Team teamA = Team('Equipe - A', const Color.fromRGBO(17, 47, 77, 1));
  Team teamB = Team('Equipe - B', const Color.fromRGBO(255, 194, 57, 1));

  Color primaryColor = Colors.blueGrey[200]!;
  Color secondaryColor = Colors.red[800]!;

  void _increment(Function fn) {
    setState(() {
      fn();
    });
  }

  void _decrement(Function fn) {
    setState(() {
      fn();
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

  bool isModified = false;

  void _changeSide() {
    setState(() {
      if ((teamA.getPontos >= 8) || (teamB.getPontos >= 8)) {
        isModified = true;
      } else {
        isModified = false;
      }
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
                    title: isModified == false
                        ? teamA.getTitleTeam
                        : teamB.getTitleTeam,
                    color:
                        isModified == false ? teamA.getColor : teamB.getColor,
                  ),
                ),
                ShiftButton(
                  color: isModified == false ? primaryColor : secondaryColor,
                  method: _changeSide,
                ),
                Expanded(
                  flex: 1,
                  child: TeamTitle(
                    title: isModified == false
                        ? teamB.getTitleTeam
                        : teamA.getTitleTeam,
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
                        fontWeight: FontWeight.w500,
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
                      },
                      decrementMethod: () {
                        isModified == false
                            ? _decrement(teamA.decrement)
                            : _decrement(teamB.decrement);
                      },
                      resetMethod: () {
                        if (isModified == true) {
                          if (teamA.getPontos == 0) {
                            _reset(teamB.resetPoints);
                            isModified = false;
                          } else if (teamA.getPontos > 0) {
                            _reset(teamB.resetPoints);
                          }
                        } else {
                          _reset(teamA.resetPoints);
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
                          fontWeight: FontWeight.w500,
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
                          },
                          decrementMethod: () {
                            isModified == false
                                ? _decrement(teamB.decrement)
                                : _decrement(teamA.decrement);
                          },
                          resetMethod: () {
                            if (isModified == true) {
                              if (teamB.getPontos == 0) {
                                _reset(teamA.resetPoints);
                                isModified = false;
                              } else if (teamB.getPontos > 0) {
                                _reset(teamA.resetPoints);
                              }
                            } else {
                              _reset(teamB.resetPoints);
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
