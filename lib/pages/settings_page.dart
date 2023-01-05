// ignore_for_file: avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:volei/components/card/card_settings.dart';
import 'package:volei/components/checkbox/switch_text.dart';
import 'package:volei/components/counter/counter.dart';
import 'package:volei/components/counter/point_counter.dart';
import 'package:volei/util/colors/standard_colors.dart';
import 'package:volei/util/global/global.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext ctx) {
    double availableWidth = MediaQuery.of(ctx).size.width;
    return AppBar(
      title: Center(
        child: Padding(
          padding: EdgeInsets.only(right: availableWidth * 0.05),
          child: const Text(
            'Configurações',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
      ),
      backgroundColor: appBarMainColor,
    );
  }

  _body(BuildContext ctx) {
    double availableWidth = MediaQuery.of(ctx).size.width;
    double availableHeight = MediaQuery.of(ctx).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardSettings(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pontuação de Vitória',
                    style: TextStyle(
                      color: blue,
                      fontSize: 25.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Determina a pontuação que a equipe deverá atingir para obter a vitória.',
                      style: TextStyle(
                        color: grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: SwitchText(
                      title: 'Permitir +2 pontos para desempate',
                      information:
                          'Se esta função estiver habilitada, caso as equipes estejam a 1 ponto de diferença em relação a pontuação de vitória, será determinado +2 a serem atingidos para haver o desempate.',
                      value: true,
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
              trailing: Padding(
                padding: EdgeInsets.only(bottom: availableHeight * 0.16),
                child: PointCounter(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      width: 150,
                      child: FittedBox(
                        child: Text(
                          'Pontuação de Vitória',
                          style: TextStyle(
                            color: blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: Counter(
                    value: Global.scoreLimit,
                    sizeTextValue: 40.0,
                    padding: availableWidth * 0.10,
                    refreshButton: false,
                    incrementMethod: () {},
                    decrementMethod: () {},
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(color: blueGrey),
            ),
            CardSettings(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              leading: SwitchText(
                title: 'Permitir a mudança de lado',
                information:
                    'Se esta função estiver habilitada, o lado das equipes será modificado no momento em que a pontuação configurada for atingida.',
                value: true,
                onChanged: (_) {},
              ),
              trailing: PointCounter(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: SizedBox(
                    width: 150,
                    child: FittedBox(
                      child: Text(
                        'Pontuação de Lados',
                        style: TextStyle(
                          color: blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                child: Counter(
                  value: Global.scoreLimitChangeSide,
                  sizeTextValue: 40.0,
                  padding: availableWidth * 0.10,
                  refreshButton: false,
                  incrementMethod: () {},
                  decrementMethod: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
