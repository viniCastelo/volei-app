import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final Widget? icon;
  final Color? backgroundColor;
  final Function()? method;
  final double? size;
  const ButtonApp({
    this.icon,
    this.backgroundColor,
    this.size = 60.0,
    this.method,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: method,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
