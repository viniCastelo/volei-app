// ignore_for_file: avoid_unnecessary_containers, recursive_getters, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volei/util/colors/standard_colors.dart';

class SwitchText extends StatelessWidget {
  final String title;
  final String? information;
  final bool value;
  final Function(bool?) onChanged;

  bool get getValue => value;

  const SwitchText({
    required this.title,
    this.information,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: [
          CupertinoSwitch(
            value: value,
            activeColor: teamMainColor,
            onChanged: onChanged,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
              ),
              information == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: SizedBox(
                        width: availableWidth * 0.6,
                        child: Text(
                          information!,
                          style: TextStyle(
                            color: grey,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
