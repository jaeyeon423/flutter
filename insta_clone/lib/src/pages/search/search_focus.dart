import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/src/components/image_data.dart';
import 'package:insta_clone/src/controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  @override
  _SearchFocusState createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus> with TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  Widget _tabMenuOne(String menu){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(menu, style: TextStyle(color: Colors.black, fontSize: 15),),
    );
  }

  PreferredSize tapMenu(){
    return PreferredSize(
      child: Container(
          height: AppBar().preferredSize.height,
          width: Size.infinite.width,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))
          ),
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.black,
            tabs: [
              _tabMenuOne("인기"),
              _tabMenuOne("계정"),
              _tabMenuOne("오디오"),
              _tabMenuOne("태그"),
              _tabMenuOne("장소"),
            ],
          )
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }
  Widget _body(){
    return Container(
      child: TabBarView(
        controller: tabController,
        children: [
          Center(child: Text("인기 페이지"),),
          Center(child: Text("계정 페이지"),),
          Center(child: Text("오디오 페이지"),),
          Center(child: Text("태그 페이지"),),
          Center(child: Text("장소 페이지"),),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            BottomNavController.to.willPopAction();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.backBtnIcon),
          ),
        ),
        titleSpacing: 0,
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xffefefef),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "검색",
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true,
            ),
          ),
        ),
        bottom: tapMenu(),
      ),
      body: _body(),
    );
  }
}
