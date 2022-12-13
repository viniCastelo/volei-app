import 'package:flutter/material.dart';

class PointCounter extends StatelessWidget {
  final Widget title;
  final Widget child;
  const PointCounter({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title,
        child,
      ],
    );
  }
}
