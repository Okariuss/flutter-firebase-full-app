// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/product/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

class SubtitleText extends StatelessWidget {
  final String value;

  const SubtitleText({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.general.textTheme.titleMedium?.copyWith(
        color: ColorConstants.greyPrimary,
      ),
    );
  }
}
