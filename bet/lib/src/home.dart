import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static int num = 0;
  int height = 180;

  Widget _list() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  num = 0;
                });
              },
              child: Text("달리기")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  num = 1;
                });
              },
              child: Text("웨이트")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  num = 2;
                });
              },
              child: Text("수영")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  num = 3;
                });
              },
              child: Text("필라테스")),
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
        title: Text(
          "사행성 운동 내기 앱",
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            _list(),
            Text('${num}'),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                inactiveTrackColor: Color(0xFF8D8E98),
                activeTrackColor: Color(0xFF8D8E98),
                thumbColor: Colors.blue,
                overlayColor: Color(0x29EB1555),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 13.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
              ),
              child: Slider(
                min: 120,
                max: 220,
                onChanged: (double newValue) {
                  setState(() {
                    height = newValue.round();
                  });
                },
                value: height.toDouble(),
              ),
            ),
            Text('${height} day'),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){}, child: Text('내기 방 찾기')),
            SizedBox(height: 10,),
            Container(width: 500, height: 1, color: Colors.grey,)
          ],
        ),
      ),
    );
  }
}
