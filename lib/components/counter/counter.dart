import 'package:flutter/material.dart';
import 'package:volei/components/buttons/button_app.dart';

class Counter extends StatelessWidget {
  final int value;
  final EdgeInsetsGeometry? margin;
  final Function()? incrementMethod;
  final Function()? decrementMethod;
  const Counter({
    required this.value,
    this.incrementMethod,
    this.decrementMethod,
    this.margin,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          ButtonApp(
            icon: const Icon(Icons.remove),
            backgroundColor: const Color.fromRGBO(253, 195, 205, 1.0),
            method: decrementMethod,
          ),
          SizedBox(
            width: 120,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 70.0,
                color: Colors.cyan,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ButtonApp(
            icon: const Icon(Icons.add),
            backgroundColor: const Color.fromRGBO(226, 240, 217, 1.0),
            method: incrementMethod,
          ),
        ],
      ),
    );
  }
}
