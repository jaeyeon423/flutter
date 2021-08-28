import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn gSignIn = GoogleSignIn();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSignedIn = false;

  void initState() {
    super.initState();

    gSignIn.onCurrentUserChanged.listen(
      (gSigninAccount) {
        controlSignIn(gSigninAccount!);
      },
      onError: (gError) {
        print("Error Message: " + gError);
      },
    );

    gSignIn.signInSilently(suppressErrors: false).then((gSigninAccount) {
      controlSignIn(gSigninAccount!);
    }).catchError((gError) {
      print("Error Message2: " + gError.toString());
    });
  }

  controlSignIn(GoogleSignInAccount signInAccount) async {
    if (true) {
      setState(() {
        isSignedIn = true;
      });
    } else {
      isSignedIn = false;
    }
  }

  LoginUser() {
    gSignIn.signIn();
  }

  LogOutUser() {
    gSignIn.signOut();
  }

  Widget buildHomeScreen() {
    return ElevatedButton.icon(
        onPressed: LogOutUser,
        icon: Icon(Icons.close),
        label: Text("Sign Out!"));
  }

  Widget buildHomeInScreen() {
    return Text("Already sign in");
  }

  Scaffold buildSignInScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor
          ],
        )),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "instar gram",
              style: TextStyle(
                  fontSize: 92.0, color: Colors.white, fontFamily: "Signatra"),
            ),
            GestureDetector(
              onTap: LoginUser,
              child: Container(
                width: 270.0,
                height: 65.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/google_signin_button.png'))),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildSignInScreen();
    }
  }
}
