import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hair_book/widget/designer_info_widget.dart';

class DesignerListView extends StatelessWidget {
  const DesignerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                  hintText: '디자이너 찾기 (미용실)',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        body: DesignerInfoWidget(
          cur_page: PAGE.LIST,
        ),
      ),
    );
  }
}
