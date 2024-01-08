import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/product/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

class TitleText extends StatelessWidget {
  final String value;

  const TitleText({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorConstants.blackPrimary,
      ),
    );
  }
}
