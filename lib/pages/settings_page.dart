// ignore_for_file: avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volei/components/card/card_settings.dart';
import 'package:volei/components/checkbox/switch_text.dart';
import 'package:volei/components/counter/counter.dart';
import 'package:volei/components/counter/point_counter.dart';
import 'package:volei/controllers/home_controller.dart';
import 'package:volei/controllers/settings_controller.dart';
import 'package:volei/util/colors/standard_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: _onBackPressed(controller),
          child: Scaffold(
            appBar: _appBar(context, controller),
            body: _body(context, controller),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(
    BuildContext ctx,
    SettingsController settingsController,
  ) {
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

  Future<bool> Function() _onBackPressed(
      SettingsController settingsController) {
    return () async {
      // Aqui você pode executar a ação que deseja antes de fechar a rota ou a tela
      // Por exemplo, salvar dados, exibir um diálogo de confirmação, etc.
      settingsController.standardScoreLimit();
      // Se você quiser permitir que a rota ou a tela seja fechada, retorne true
      return true;
    };
  }

  _body(
    BuildContext ctx,
    SettingsController settingsController,
  ) {
    double availableWidth = MediaQuery.of(ctx).size.width;
    double availableHeight = MediaQuery.of(ctx).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GetBuilder<HomeController>(builder: (controller) {
              return CardSettings(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            'Se esta função estiver habilitada, caso as equipes estejam a 1 ponto de diferença em relação a pontuação de vitória, será determinado +2 pontos a serem atingidos para que haja o desempate.',
                        value: controller.allowExtendLimit,
                        onChanged: controller.toogleAllowExtendLimit,
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
                      value: controller.scoreLimit,
                      sizeTextValue: 40.0,
                      padding: availableWidth * 0.10,
                      refreshButton: false,
                      incrementMethod: controller.incrementScoreLimit,
                      decrementMethod: controller.decrementScoreLimit,
                    ),
                  ),
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(color: blueGrey),
            ),
            GetBuilder<HomeController>(builder: (controller) {
              return CardSettings(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                leading: SwitchText(
                  title: 'Permitir a mudança de lados',
                  information:
                      'Se esta função estiver habilitada, o lado das equipes será modificado no momento em que a pontuação definida for atingida.',
                  value: controller.changeSide,
                  onChanged: controller.toogleChangeSide,
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
                    value: controller.scoreLimitChangeSide,
                    sizeTextValue: 40.0,
                    padding: availableWidth * 0.10,
                    refreshButton: false,
                    incrementMethod: controller.incrementScoreLimitToToogle,
                    decrementMethod: controller.decrementScoreLimitToToogle,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
