import 'package:flutter/material.dart';
import 'package:insta_clone/src/components/avatar_widget.dart';
import 'package:insta_clone/src/components/image_data.dart';
import 'package:insta_clone/src/components/post_widget.dart';

class Home extends StatelessWidget {
  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
          thumbPath:
              'https://www.thoughtco.com/thmb/nhezwxPKb0WrFp_5ogIuuOh2IhA=/2576x2576/smart/filters:no_upscale()/american-bald-eagle-head-in-front-of-american-flag-950701786-5b85581346e0fb0025e00b06.jpg',
          type: AvatarType.TYPE2,
          size: 70,
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Center(
              child: Text(
                "+",
                style:
                    TextStyle(fontSize: 20, color: Colors.white, height: 1.1),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _postList(){
    return Column(
      children: List.generate(50, (index) => PostWidget()).toList(),
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        SizedBox(
          width: 20,
        ),
        _myStory(),
        SizedBox(
          width: 5,
        ),
        ...List.generate(
            100,
            (index) => AvatarWidget(
                thumbPath:
                    "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/e0e7a4585b557d74708f6e8dced9b91e.png",
                type: AvatarType.TYPE1)),
      ]),
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
          _postList(),
        ],
      ),
    );
  }
}
