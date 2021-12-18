import 'package:flutter/material.dart';
import 'package:youtube_clone/main.dart';

class VideoWidget extends StatelessWidget {
  Widget _thumbnail() {
    return Container(
      height: 250,
      color: Colors.red,
    );
  }

  Widget _simpleDetailInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(0.5),
            backgroundImage: Image.network(
                    "https://yt3.ggpht.com/yti/APfAmoF7ULc_IttXE79JtBsgYCHMXIx1XdI5ffMatg=s88-c-k-c0x00ffffff-no-rj-mo")
                .image,
          ),
          SizedBox(width: 15,),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("jaeyeon youtube replay jaeyeon youtube replay jaeyeon youtube replay", maxLines: 2,)),
                    IconButton(
                      alignment: Alignment.topCenter,
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        size: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("JAEYEON", style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.8)),),
                    Text(" - "),
                    Text("조회수 1000회", style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6)),),
                    Text(" - "),
                    Text("2021-12-18", style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6)),),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          _thumbnail(),
          _simpleDetailInfo(),
        ],
      ),
    );
  }
}
