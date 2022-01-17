import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  Widget _list(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(onPressed: (){}, child: Text("달리기")),
          ElevatedButton(onPressed: (){}, child: Text("웨이트")),
          ElevatedButton(onPressed: (){}, child: Text("수영")),
          ElevatedButton(onPressed: (){}, child: Text("필라테스")),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("사행성 운동 내기 앱", style: TextStyle(color: Colors.black54),),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            _list(),
          ],
        ),
      ),
    );
  }
}
