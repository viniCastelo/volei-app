import 'package:flutter/material.dart';
import 'package:volei/components/buttons/button_app.dart';
import 'package:volei/util/colors/standard_colors.dart';

class Counter extends StatelessWidget {
  final int value;
  final bool refreshButton;
  final double? sizeTextValue;
  final double? sizeButtons;
  final double? padding;
  final Function()? incrementMethod;
  final Function()? decrementMethod;
  final Function()? resetMethod;
  const Counter({
    required this.value,
    required this.refreshButton,
    this.sizeTextValue = 70.0,
    this.padding = 0.0,
    this.sizeButtons,
    this.incrementMethod,
    this.decrementMethod,
    this.resetMethod,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    // double availableWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonApp(
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
              backgroundColor: const Color.fromARGB(255, 163, 196, 246),
              method: decrementMethod,
              size: sizeButtons,
            ),
            SizedBox(
              width: padding!,
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: sizeTextValue,
                  color: const Color.fromARGB(255, 0, 57, 114),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ButtonApp(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.lightGreen[300]!,
              method: incrementMethod,
              size: sizeButtons,
            ),
          ],
        ),
        refreshButton
            ? ButtonApp(
                icon: Icon(
                  Icons.sync,
                  color: Colors.grey[600]!,
                ),
                backgroundColor: whiteSmoke,
                method: resetMethod,
                size: sizeButtons,
              )
            : const SizedBox(),
      ],
    );
  }
}
