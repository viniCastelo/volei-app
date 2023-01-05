// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:volei/components/checkbox/switch_text.dart';
import 'package:volei/util/colors/standard_colors.dart';

class CardSettings extends StatelessWidget {
  final String? title;
  final String? information;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const CardSettings({
    this.title,
    this.information,
    this.leading,
    this.trailing,
    this.padding,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leading == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: leading!,
                    ),
              trailing == null ? const SizedBox() : trailing!,
            ],
          ),
        ],
      ),
    );
  }
}
