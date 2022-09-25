import 'package:byc/navigatior/navigation_bar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
              ],
            );
          }
          return NavigationBarPage();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
