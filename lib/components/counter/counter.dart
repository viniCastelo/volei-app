import 'package:flutter/material.dart';
import 'package:volei/components/buttons/button_app.dart';

class Counter extends StatelessWidget {
  final int value;
  final Function()? incrementMethod;
  final Function()? decrementMethod;
  final Function()? resetMethod;
  const Counter({
    required this.value,
    this.incrementMethod,
    this.decrementMethod,
    this.resetMethod,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
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
            ),
            SizedBox(
              width: 120,
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 70.0,
                  color: Color.fromARGB(255, 0, 57, 114),
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
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ButtonApp(
            icon: Icon(
              Icons.sync,
              color: Colors.grey[600]!,
            ),
            backgroundColor: Colors.white70,
            method: resetMethod,
          ),
        )
      ],
    );
  }
}
