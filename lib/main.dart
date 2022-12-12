import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volei/components/buttons/button_app.dart';
import 'package:volei/components/counter/counter.dart';
import 'package:volei/components/separators/dashed_line_vertical.dart';
import 'package:volei/components/counter/point_counter.dart';
import 'package:volei/components/buttons/shift_button.dart';
import 'package:volei/components/labels/team_title.dart';
import 'package:volei/model/team.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Team teamA = Team('Time Verde', Colors.green);
  Team teamB = Team('Time Azul', Colors.blue);

  Color primaryColor = Colors.deepPurple;
  Color secondaryColor = Colors.purple;

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
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Placar do Jogo',
              style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          backgroundColor: isModified == false
              ? primaryColor
              : secondaryColor, //const Color.fromRGBO(5, 25, 51, 25),
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
                  PointCounter(
                    titlePadLeft: 138.0,
                    title: const Text(
                      'Pontuação',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                    ),
                    child: Column(
                      children: [
                        Counter(
                          value: isModified == false
                              ? teamA.getPontos
                              : teamB.getPontos,
                          margin: const EdgeInsets.only(left: 80.0),
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15.0, right: 28.0),
                          child: ButtonApp(
                            size: 50,
                            icon: const Icon(
                              Icons.restart_alt,
                              size: 20,
                            ),
                            backgroundColor: Colors.white70,
                            method: () {
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
                      ],
                    ),
                  ),
                  CustomPaint(
                    painter: DashedLineVertical(
                      isModified == false ? primaryColor : secondaryColor,
                    ),
                    size: const Size(0, double.maxFinite),
                  ),
                  PointCounter(
                    titlePadLeft: 40,
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
                          margin: const EdgeInsets.only(left: 110.0),
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15.0, left: 35.0),
                          child: ButtonApp(
                            size: 50,
                            icon: const Icon(
                              Icons.restart_alt,
                              size: 20,
                            ),
                            backgroundColor: Colors.white70,
                            method: () {
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
