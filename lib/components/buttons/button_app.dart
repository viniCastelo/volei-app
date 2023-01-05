import 'package:flutter/material.dart';

class ButtonApp extends StatefulWidget {
  final Widget? icon;
  final Color? backgroundColor;
  final Function()? method;
  final double? splashRadius;
  final double? size;
  const ButtonApp({
    this.icon,
    this.size,
    this.backgroundColor,
    this.splashRadius = 1.0,
    this.method,
    super.key,
  });

  @override
  State<ButtonApp> createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.size,
      backgroundColor: widget.backgroundColor,
      child: button(),
    );
  }

  Widget button() {
    return IconButton(
      onPressed: widget.method,
      splashRadius: widget.splashRadius!,
      icon: widget.icon!,
    );
  }
}
