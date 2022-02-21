import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType { TYPE1, TYPE2, TYPE3 }

class AvatarWidget extends StatelessWidget {
  bool? hasStory;
  String thumbPath;
  String? nickname;
  AvatarType type;
  double? size;

  AvatarWidget(
      {Key? key,
      this.hasStory,
      required this.thumbPath,
      this.nickname,
      required this.type,
      this.size})
      : super(key: key);

  Widget type1Widget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.orange,
          ],
        ),
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(65),
        child: Container(
          width: 65,
          height: 65,
          child: CachedNetworkImage(
            imageUrl:
                "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/e0e7a4585b557d74708f6e8dced9b91e.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1:
        return type1Widget();
        break;
      case AvatarType.TYPE2:
      case AvatarType.TYPE3:
        return Container();
        break;
    }
    return Container();
  }
}
