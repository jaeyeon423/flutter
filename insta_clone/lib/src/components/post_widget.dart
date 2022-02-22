import 'package:flutter/material.dart';
import 'package:insta_clone/src/components/avatar_widget.dart';

class PostWidget extends StatelessWidget {
  Widget _header(){
    return Row(
      children: [
        AvatarWidget(thumbPath: "thumbPath", type: AvatarType.TYPE3),

      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Column(
        children: [
          // _header(),
          // _image(),
          // _infoCount(),
          // _infoDescriptor(),
          // _replyTextBtn(),
          // _dataAgo(),
        ],
      ),
    );
  }
}
