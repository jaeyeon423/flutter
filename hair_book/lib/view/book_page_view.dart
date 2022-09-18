import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_book/control/firebase_controller.dart';

class BookPageView extends StatelessWidget {
  BookPageView({super.key});

  FirebaseController firebaseController = Get.put(FirebaseController());

  Widget _buildContainer(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 2 - 10,
      height: MediaQuery.of(context).size.height / 4 + 14,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 10,
            height: MediaQuery.of(context).size.height / 4 - 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'hello',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${firebaseController.email?.value}"),
            ElevatedButton(
              onPressed: () {
                print("${firebaseController.favor_list}");
              },
              child: Text("print"),
            ),
            _buildContainer(context, 0),
          ],
        ),
      ),
    );
  }
}
