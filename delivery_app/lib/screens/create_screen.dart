import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  var _userEnterMessage = '';
  var _restraunt_name = '';
  var _bank_info = '';
  var _distance = 1.3;
  var _category = 1;

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('rooms').add({
      'people_num': 1,
      'distance': 1.4,
      'category': 1,
      'name': _restraunt_name,
      'delivery_status': 0,
      'bank_info': _bank_info,
    });
    _controller.clear();
    _controller2.clear();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('방 만들기'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'restraunt name',
              ),
              onChanged: (value) {
                setState(() {
                  _restraunt_name = value;
                });
              },
            ),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(
                labelText: 'bank info',
              ),
              onChanged: (value) {
                setState(() {
                  _bank_info = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('생성하기'),
            )
          ],
        ),
      ),
    );
  }
}
