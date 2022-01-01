import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Widget _backgroundImage() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: GestureDetector(
          onTap: () {
            print("change my backgroundImage");
          },
          child: Container(
            color: Colors.transparent,
          )),
    );
  }

  Widget _header() {
    return Positioned(
      top: 25,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                print("프로필 편집 취소");
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16,
                  ),
                  Text(
                    "edit Profile",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print("프린트 편집 저장");
              },
              child: const Text(
                "complete",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _onButton(IconData icon, String title, Function ontap) {
    return GestureDetector(
      onTap: () => ontap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _profileImage() {
    return Container(
      width: 120,
      height: 120,
      child: ClipRRect(child: Image.network("https://i.stack.imgur.com/l60Hf.png", fit: BoxFit.cover,), borderRadius: BorderRadius.circular(40),)
    );
  }

  Widget _profileInfo() {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text("김재연", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),),
        ),
        Text("개발하는 남자", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
      ],
    );
  }

  Widget _myProfile() {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        child: Column(
          children: [
            _profileImage(),
            _profileInfo(),
          ],
        ),
      ),
    );
  }

  Widget _footer() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
            width: 1,
            color: Colors.white54,
          ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _onButton(Icons.chat_bubble, "나와의 채팅", () {}),
              _onButton(Icons.edit, "프로필 편집", () {}),
              _onButton(Icons.chat_bubble_outline, "카카오 스토리", () {}),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3f3f3f),
      body: Container(
        child: Stack(
          children: [
            _backgroundImage(),
            _header(),
            _myProfile(),
            _footer(),
          ],
        ),
      ),
    );
  }
}
