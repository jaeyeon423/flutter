import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.man), // 여기서 원하는 아이콘으로 변경 가능
              onPressed: () {
                // 아이콘 버튼 클릭 시 수행할 동작
              },
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: '헤어스타일, 디자이너 검색해보세요.', // 힌트 텍스트 설정
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: '홈'),
              Tab(text: '인기'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _buildHomeTab(),
                _buildPopularTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '우리동네',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MY',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        // NavigationBar 탭 클릭 시 동작 추가
      ),
    );
  }

  Widget _buildHomeTab() {
    // 홈 탭의 내용을 구성하는 위젯 반환
    return ListView.builder(
      itemCount: 20, // 예시로 20개의 게시글을 설정
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.image), // 썸네일 대신 아이콘 사용
          title: Text('카테고리 아이디'),
          subtitle: Text('게시글 제목'),
          onTap: () {
            // 게시글 클릭 시 동작 추가
          },
        );
      },
    );
  }

  Widget _buildPopularTab() {
    // 인기 탭의 내용을 구성하는 위젯 반환
    return Center(
      child: Text('인기 탭 내용'),
    );
  }
}
