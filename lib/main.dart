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
  bool modifiedStyle = false;
  Team teamA = Team('Equipe - A', Colors.green);
  Team teamB = Team('Equipe - B', Colors.blue);

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
      fn();
    });
  }

  void _changeSide(Function standardState, Function modifyState) {
    setState(() {
      if (modifiedStyle == false) {
        standardState();
        modifiedStyle = true;
      } else {
        modifyState();
        modifiedStyle = false;
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
            child: Text('🏐 Placar do Jogo 🏐'),
          ),
          backgroundColor: const Color.fromRGBO(5, 25, 51, 25),
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
                      title: teamA.getTitleTeam,
                      color: teamA.getColor,
                    ),
                  ),
                  ShiftButton(
                    color: Colors.deepPurple,
                    method: () {
                      _changeSide(() {}, () {});
                    },
                  ),
                  Expanded(
                    flex: 1,
                    child: TeamTitle(
                      title: teamB.getTitleTeam,
                      color: teamB.getColor,
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
                    titlePadLeft: 150.0,
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
                          value: teamA.getPontos,
                          margin: const EdgeInsets.only(left: 93.0),
                          incrementMethod: () {
                            _increment(teamA.increment);
                          },
                          decrementMethod: () {
                            _decrement(teamA.decrement);
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: ButtonApp(
                            size: 50,
                            icon: const Icon(
                              Icons.restart_alt,
                              size: 20,
                            ),
                            backgroundColor: Colors.white54,
                            method: () {
                              _reset(teamA.resetPoints);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomPaint(
                    painter: DashedLineVertical(),
                    size: const Size(0, double.maxFinite),
                  ),
                  PointCounter(
                    titlePadLeft: 0,
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
                          margin: const EdgeInsets.only(left: 93.0),
                          value: teamB.getPontos,
                          incrementMethod: () {
                            _increment(teamB.increment);
                          },
                          decrementMethod: () {
                            _decrement(teamB.decrement);
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: ButtonApp(
                            size: 50,
                            icon: const Icon(
                              Icons.restart_alt,
                              size: 20,
                            ),
                            backgroundColor: Colors.white54,
                            method: () {
                              _reset(teamB.resetPoints);
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
