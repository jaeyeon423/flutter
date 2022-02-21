import 'package:flutter/material.dart';
import 'package:insta_clone/src/components/avatar_widget.dart';
import 'package:insta_clone/src/components/image_data.dart';

class Home extends StatelessWidget {
  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          100,
          (index) => AvatarWidget(thumbPath: "", type: AvatarType.TYPE1)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {},
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          // _postList(),
        ],
      ),
    );
  }
}
