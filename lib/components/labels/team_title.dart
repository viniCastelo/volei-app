import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:volei/model/team.dart';
import 'package:volei/util/uppercase_text_formatter.dart';

class TeamTitle extends StatelessWidget {
  final Team? team;
  final Color? color;
  final ConfettiWidget? winMethod;

  const TeamTitle({
    this.team,
    this.color = Colors.blue,
    this.winMethod,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 55.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
      child: Column(
        children: [
          winMethod!,
          TextField(
            controller: TextEditingController(
              text: team!.getTitleTeam.toUpperCase(),
            ),
            onChanged: (text) {
              team!.titleTeam(text);
            },
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            showCursor: false,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
