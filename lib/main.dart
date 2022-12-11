import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volei/components/buttons/button_app.dart';
import 'package:volei/components/counter/counter.dart';
import 'package:volei/components/separators/dashed_line_vertical.dart';
import 'package:volei/components/counter/point_counter.dart';
import 'package:volei/components/buttons/shift_button.dart';
import 'package:volei/components/labels/team_title.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var pontoA = 0;
  var pontoB = 0;

  bool standard = true;

  void _incrementA() {
    setState(() {
      pontoA++;
    });
  }

  void _incrementB() {
    setState(() {
      pontoB++;
    });
  }

  void _decrementA() {
    setState(() {
      if (pontoA > 0) {
        pontoA--;
      }
    });
  }

  void _decrementB() {
    setState(() {
      if (pontoB > 0) {
        pontoB--;
      }
    });
  }

  void _changeSide() {
    setState(() {
      if (standard == true) {
        standard = false;
      } else {
        standard = true;
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
                  const Expanded(
                    flex: 1,
                    child: TeamTitle(
                      title: 'Equipe - A',
                      color: Colors.green,
                    ),
                  ),
                  ShiftButton(
                    color: Colors.deepPurple,
                    method: _changeSide,
                  ),
                  const Expanded(
                    flex: 1,
                    child: TeamTitle(
                      title: 'Equipe - B',
                      color: Colors.blue,
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
                          value: pontoA,
                          margin: const EdgeInsets.only(left: 93.0),
                          incrementMethod: _incrementA,
                          decrementMethod: _decrementA,
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
                              setState(() {
                                pontoA = 0;
                              });
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
                          value: pontoB,
                          incrementMethod: _incrementB,
                          decrementMethod: _decrementB,
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
                              setState(() {
                                pontoB = 0;
                              });
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
