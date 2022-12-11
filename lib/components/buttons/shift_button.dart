// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class ShiftButton extends StatelessWidget {
  final Color? color;
  final Function()? method;
  const ShiftButton({this.color = Colors.blue, this.method, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 60.0,
        width: 60.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: method,
          child: const Center(
            child: Icon(
              Icons.sync_alt,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
