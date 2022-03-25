import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/src/pages/search/search_focus.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIndex = [0, 0, 0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < 100; i++) {
      var gi = groupIndex.indexOf(min<int>(groupIndex)!);
      var size = 1;
      if (gi != 1) {
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }
      groupBox[gi].add(size);
      groupIndex[gi] += size;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _appBar() {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Get.to(SearchFocus());
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchFocus()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                margin: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xffefefef)),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Text(
                      "검색",
                      style: TextStyle(fontSize: 15, color: Color(0xff838383)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(Icons.location_pin),
          ),
        ],
      );
    }

    Widget _body() {
      return SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            groupBox.length,
            (index) => Expanded(
              child: Column(
                children: List.generate(
                  groupBox[index].length,
                  (jindex) => Container(
                    height: Get.width * 0.33 * groupBox[index][jindex],
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/e0e7a4585b557d74708f6e8dced9b91e.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ).toList(),
              ),
            ),
          ).toList(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _appBar(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }
}
