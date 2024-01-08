import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/feature/authentication/authentication_provider.dart';
import 'package:flutter_firebase_full_app/product/constants/index.dart';
import 'package:flutter_firebase_full_app/product/widgets/text/subtitle_text.dart';
import 'package:flutter_firebase_full_app/product/widgets/text/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthenticationState();
}

class _AuthenticationState extends ConsumerState<AuthenticationView> {
  final authProvider =
      StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
    return AuthenticationNotifier();
  });

  @override
  void initState() {
    super.initState();

    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? user) {
    ref.read(authProvider.notifier).fetchUserDetail(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebase.FirebaseUIActions(
        actions: [
          firebase.AuthStateChangeAction<firebase.SignedIn>((context, state) {
            if (state.user != null) checkUser(state.user);
          })
        ],
        child: SafeArea(
          child: Padding(
            padding: context.padding.low,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _Header(),
                  Padding(
                    padding: context.padding.normal,
                    child: firebase.LoginView(
                      action: firebase.AuthAction.signIn,
                      showTitle: false,
                      providers: firebase.FirebaseUIAuth.providersFor(
                        FirebaseAuth.instance.app,
                      ),
                      footerBuilder: (context, action) {
                        return Text('aaaa');
                      },
                    ),
                  ),
                  Text(
                    'Continue to app',
                    textAlign: TextAlign.center,
                    style: context.general.textTheme.bodySmall
                        ?.copyWith(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(value: StringConstants.loginWelcomeBack),
          Padding(
            padding: context.padding.onlyTopLow,
            child: SubtitleText(
              value: StringConstants.loginWelcomeDetail,
            ),
          ),
        ],
      ),
    );
  }
}
