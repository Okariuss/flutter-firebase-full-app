import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/feature/splash/mixin/splash_view_listen_mixin.dart';
import 'package:flutter_firebase_full_app/product/constants/index.dart';
import 'package:flutter_firebase_full_app/product/enums/index.dart';
import 'package:flutter_firebase_full_app/product/widgets/text/wavy_bold_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SplashViewListenMixin {
  @override
  Widget build(BuildContext context) {
    listenAndNavigate();
    return Scaffold(
      backgroundColor: ColorConstants.purplePrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.appIcon.toImage,
            WavyBoldText(title: StringConstants.appName),
          ],
        ),
      ),
    );
  }
}
