import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:volei/model/team.dart';
import 'package:volei/util/uppercase_text_formatter.dart';

class TeamTitle extends StatelessWidget {
  final Team team;
  final ConfettiWidget? winMethod;

  const TeamTitle({
    required this.team,
    this.winMethod,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 53.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.5),
        color: team.getColor,
      ),
      child: Column(
        children: [
          winMethod!,
          TextField(
            enableSuggestions: true,
            autocorrect: true,
            scribbleEnabled: true,
            controller: TextEditingController(
              text: team.getTitleTeam.toUpperCase(),
            ),
            onChanged: (text) {
              team.titleTeam = text;
            },
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            decoration: const InputDecoration(border: InputBorder.none),
            showCursor: true,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
