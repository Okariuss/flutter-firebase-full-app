import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/product/constants/index.dart';
import 'package:kartal/kartal.dart';

@immutable
class AppTheme {
  final BuildContext context;

  const AppTheme(this.context);

  ThemeData get theme => ThemeData.light().copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(16),
            ),
            textStyle: MaterialStateProperty.all<TextStyle?>(
              context.general.textTheme.headlineSmall,
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorConstants.purplePrimary),
            foregroundColor: MaterialStateProperty.all<Color>(
              ColorConstants.white,
            ),
          ),
        ),
      );
}
