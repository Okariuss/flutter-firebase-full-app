import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/feature/authentication/authentication_view.dart';
import 'package:flutter_firebase_full_app/feature/splash/splash_provider.dart';
import 'package:flutter_firebase_full_app/feature/splash/splash_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin SplashViewListenMixin on ConsumerState<SplashView> {
  final splashProvider =
      StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });

  @override
  void initState() {
    super.initState();
    ref.read(splashProvider.notifier).checkApplicationVersion(''.ext.version);
  }

  void listenAndNavigate() {
    ref.listen(splashProvider, (previous, next) {
      if (next.isRequiredForceUpdate ?? false) {
        showAboutDialog(context: context);
        return;
      }

      if (next.isRedirectHome != null) {
        if (next.isRedirectHome!) {
          context.route.navigateToPage(AuthenticationView());
        } else {}
      }
    });
  }
}
