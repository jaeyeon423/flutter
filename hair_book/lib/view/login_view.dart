import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hair_book/navigator/navigation_bar_page.dart';
import 'package:hair_book/view/designer_list_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              providerConfigs: [EmailProviderConfiguration()],
            );
          }
          return NavigationBarPage();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
