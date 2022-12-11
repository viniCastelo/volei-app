import 'package:flutter/material.dart';

class PointCounter extends StatelessWidget {
  final Widget title;
  final Widget child;
  final double? titlePadLeft;
  const PointCounter(
      {required this.title,
      this.titlePadLeft = 35.0,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 80,
            child: Padding(
              padding: EdgeInsets.only(
                left: titlePadLeft!,
                top: 18.0,
              ),
              child: title,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
