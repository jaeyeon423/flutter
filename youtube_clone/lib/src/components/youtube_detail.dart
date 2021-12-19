import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class YoutubeDetail extends StatelessWidget {
  Widget _titleZone() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "JAEYEON YOUTUBE REPLAY",
            style: TextStyle(fontSize: 15.0),
          ),
          Row(
            children: [
              Text(
                "조회수 1000회",
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(0.5)),
              ),
              Text(" - "),
              Text(
                "2021-12-19",
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(0.5)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _descriptionZone() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Text(
        "간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 간단한 설명 ",
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buttonOne(String icon, String text){
    return Column(
      children: [
        SvgPicture.asset("assets/svg/icons/${icon}"),
        Text(text)
      ],
    );
  }

  Widget get line => Container(
    height: 1,
    color: Colors.black.withOpacity(0.1),
  );

  Widget _buttonZone(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buttonOne("like.svg", "1000"),
        _buttonOne("dislike.svg", "0"),
        _buttonOne("share.svg", "공유"),
        _buttonOne("save.svg", "저장"),
      ],
    );
  }

  Widget _ownerZone(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(0.5),
            backgroundImage: Image.network(
                "https://yt3.ggpht.com/yti/APfAmoF7ULc_IttXE79JtBsgYCHMXIx1XdI5ffMatg=s88-c-k-c0x00ffffff-no-rj-mo")
                .image,
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("JAEYEON", style: TextStyle(fontSize: 18),),
                Text("구독자 10000", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)),),
              ],
            ),
          ),
          GestureDetector(child: Text("구독", style: TextStyle(fontSize: 16, color: Colors.red),),)
        ],
      ),
    );
  }

  Widget _description() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _titleZone(),
          line,
          _descriptionZone(),
          _buttonZone(),
          SizedBox(height: 20,),
          line,
          _ownerZone(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.grey,
          ),
          Expanded(child: _description())
        ],
      ),
    );
  }
}
