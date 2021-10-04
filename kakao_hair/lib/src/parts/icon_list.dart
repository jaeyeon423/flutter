import 'package:flutter/material.dart';
import 'package:kakao_hair/src/components/icon_button.dart';

class iconList extends StatelessWidget {
  const iconList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
        ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        SizedBox(height: 20,),
        Row(children: [
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
          InkWell(onTap: (){}, child: IconContent(icon: Icons.notifications_none, label: "헤어샵",),),
        ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ],
    );
  }
}
