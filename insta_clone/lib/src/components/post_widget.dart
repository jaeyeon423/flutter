import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/src/components/avatar_widget.dart';
import 'package:insta_clone/src/components/image_data.dart';

class PostWidget extends StatelessWidget {
  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: AvatarWidget(
            thumbPath:
                "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/e0e7a4585b557d74708f6e8dced9b91e.png",
            type: AvatarType.TYPE3,
            nickname: '김재연',
            size: 40,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImageData(
              IconsPath.postMoreIcon,
              width: 30,
            ),
          ),
        )
      ],
    );
  }

  Widget _image() {
    return CachedNetworkImage(
        imageUrl:
            'https://cdn2.vectorstock.com/i/1000x1000/82/86/austronaut-trying-to-reach-for-cup-coffee-vector-27498286.jpg');
  }

  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                IconsPath.likeOffIcon,
                width: 65,
              ),
              SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.replyIcon,
                width: 60,
              ),
              SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.directMessage,
                width: 55,
              ),
            ],
          ),
          ImageData(
            IconsPath.bookMarkOffIcon,
            width: 50,
          )
        ],
      ),
    );
  }

  Widget _infoDescriptor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '좋아요 159개',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText(
            "콘텐츠 1입니다. \n콘텐츠 1입니다. \n콘텐츠 1입니다. \n콘텐츠 1입니다. \n콘텐츠 1입니다. \n",
            expandText: '더보기',
            collapseText: '접기',
            prefixText: '김재연',
            prefixStyle: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
            onPrefixTap: () {
              print('jaeyeon page move');
            },
          )
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          "댓글 199개 모두 보기",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ),
    );
  }

  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        '1일전 ',
        style: TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(
            height: 10,
          ),
          _image(),
          const SizedBox(
            height: 10,
          ),
          _infoCount(),
          const SizedBox(
            height: 5,
          ),
          _infoDescriptor(),
          const SizedBox(
            height: 5,
          ),
          _replyTextBtn(),
          const SizedBox(
            height: 5,
          ),
          // _dataAgo(),
        ],
      ),
    );
  }
}
