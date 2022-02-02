import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  var category_food = ['전체','한식','치킨','중식','양식','디저트'];
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  var _restraunt_name = '';
  var _bank_info = '';
  var _distance = 1.3;
  var _category = 1;

  Widget _choice_category(int cate_num){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(onPressed: (){
        setState(() {
          _category = cate_num;
        });
      }, child: Text(category_food[cate_num]), ),
    );
  }

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('rooms').add({
      'people_num': 1,
      'distance': 1.4,
      'category': _category,
      'name': _restraunt_name,
      'delivery_status': 0,
      'bank_info': _bank_info,
    });
    _controller.clear();
    _controller2.clear();
    Get.back();
    _category = 0;
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
            SizedBox(height: 15,),
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for(var i = 0; i < 5; i++)
                    Container(child: _choice_category(i), width: 100,),
                ],
              ),
            ),
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
