import 'package:flutter/material.dart';

class TeamTitle extends StatelessWidget {
  final String? title;
  final Color? color;
  const TeamTitle({this.title, this.color = Colors.blue, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
      child: Center(
        child: Text(
          title!,
          style: const TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
