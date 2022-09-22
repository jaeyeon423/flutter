import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_book/control/firebase_controller.dart';
import 'package:hair_book/widget/designer_info_widget.dart';

class BookPageView extends StatelessWidget {
  BookPageView({super.key});

  FirebaseController firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite'),
        backgroundColor: Colors.white,
      ),
      body: DesignerInfoWidget(
        cur_page: PAGE.BOOK,
      ),
    );
  }
}
