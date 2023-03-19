import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:volei/components/buttons/shift_button.dart';
import 'package:volei/components/counter/counter.dart';
import 'package:volei/components/counter/point_counter.dart';
import 'package:volei/components/labels/team_title.dart';
import 'package:volei/components/separators/dashed_line_vertical.dart';
import 'package:volei/controllers/home_controller.dart';
import 'package:volei/pages/settings_page.dart';
import 'package:volei/util/colors/standard_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _appBar(context),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TeamTitle(
                          winMethod: ConfettiWidget(
                            confettiController: controller.teamA.getController,
                            shouldLoop: true,
                            blastDirectionality: BlastDirectionality.explosive,
                            emissionFrequency: 0.04,
                          ),
                          team: controller.verifyTeam1,
                        ),
                      ),
                      ShiftButton(
                        color: controller.isModified == false
                            ? dividerMainColor
                            : dividerSecondaryColor,
                      ),
                      Expanded(
                        flex: 1,
                        child: TeamTitle(
                          winMethod: ConfettiWidget(
                            confettiController: controller.teamB.getController,
                            shouldLoop: true,
                            blastDirectionality: BlastDirectionality.explosive,
                            emissionFrequency: 0.04,
                          ),
                          team: controller.verifyTeam2,
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
                              // color: Colors.blueGrey,
                            ),
                          ),
                          child: Counter(
                            value: controller.isModified == false
                                ? controller.teamA.getPontos
                                : controller.teamB.getPontos,
                            refreshButton: true,
                            sizeButtons: 28.0,
                            padding: availableWidth * 0.15,
                            incrementMethod: () => controller.increment(
                              controller.teamA,
                              controller.teamB,
                            ),
                            decrementMethod: () => controller.decrement(
                              controller.teamA,
                              controller.teamB,
                            ),
                            resetMethod: () => controller.reset(
                              controller.teamA,
                              controller.teamB,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: CustomPaint(
                          painter: DashedLineVertical(
                            controller.isModified == false
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
                              // color: Colors.blueGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          child: Column(
                            children: [
                              Counter(
                                value: controller.isModified == false
                                    ? controller.teamB.getPontos
                                    : controller.teamA.getPontos,
                                refreshButton: true,
                                sizeButtons: 28.0,
                                padding: availableWidth * 0.15,
                                incrementMethod: () => controller.increment(
                                  controller.teamB,
                                  controller.teamA,
                                ),
                                decrementMethod: () => controller.decrement(
                                  controller.teamB,
                                  controller.teamA,
                                ),
                                resetMethod: () => controller.reset(
                                  controller.teamB,
                                  controller.teamA,
                                ),
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
        });
  }

  PreferredSizeWidget _appBar(BuildContext ctx) {
    double availableWidth = MediaQuery.of(ctx).size.width;
    return AppBar(
      title: Center(
        child: Padding(
          padding: EdgeInsets.only(left: availableWidth * 0.11),
          child: const Text(
            'Placar do Jogo',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
      ),
      backgroundColor: appBarMainColor,
      actions: [
        IconButton(
          onPressed: () {
            ThemeProvider.controllerOf(ctx).nextTheme();
          },
          icon: const Icon(Icons.dark_mode),
          splashRadius: 22.0,
          tooltip: 'Tema',
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () => Get.to(() => const SettingsPage()),
            icon: Icon(
              Icons.settings,
              color: white,
            ),
            splashRadius: 22.0,
            tooltip: 'Configurações',
          ),
        )
      ],
    );
  }
}
