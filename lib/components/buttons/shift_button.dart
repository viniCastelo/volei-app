// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:volei/util/colors/standard_colors.dart';

class ShiftButton extends StatelessWidget {
  final Color? color;
  const ShiftButton({
    this.color = Colors.blue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundColor: color,
        foregroundColor: white,
        radius: 30.0,
        child: const Icon(
          Icons.sync_alt,
        ),
      ),
    );
  }
}
