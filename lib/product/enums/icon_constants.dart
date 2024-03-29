import 'package:flutter/material.dart';

enum IconConstants {
  microphone('microphone'),
  appIcon('app_logo'),
  search('search');

  final String value;
  const IconConstants(this.value);

  String get toPng => 'assets/icons/ic_$value.png';
  Image get toImage => Image.asset(toPng);
}
