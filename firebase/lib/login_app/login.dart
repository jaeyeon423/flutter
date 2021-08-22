import 'package:flutter/material.dart';
import 'package:firebase/my_button/my_button.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Log In",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _buildButton(),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyButton(
            image: Image.asset('images/glogo.png'),
            text: Text(
              "Login width Google",
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
            color: Colors.white,
            radius: 4.0,
            onPressed: () {},
          ),
          SizedBox(
            height: 4.0,
          ),
          MyButton(
            image: Image.asset('images/flogo.png'),
            text: Text(
              "Login width Facebook",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            color: Colors.blue,
            radius: 4.0,
            onPressed: () {},
          ),
          SizedBox(
            height: 4.0,
          ),
          MyButton(
            image: Icon(Icons.email),
            text: Text(
              "Login width Email",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            color: Colors.green,
            radius: 4.0,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
