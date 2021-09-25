import 'package:flutter/material.dart';
import 'package:lotto_app/components/circle_number.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List lottolist = [];
  List<bool> vis = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true
                  , true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lotto"),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 6,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(45, (index) {
          return Center(
            child: CircleNumber(
              num: (index + 1).toString(),
              vis: vis[index],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var tmp = new Random();
          lottolist.clear();
          print(lottolist.length);
          while(lottolist.length < 6){
            int lnum =tmp.nextInt(45) + 1;
            print(lottolist.length);
            if(lottolist.contains(lnum)){
              print("have");
            }else{
              print("not");
              lottolist.add(lnum);
            }
          }
          lottolist.sort();
          print(lottolist);
          setState(() {
            for(int i = 0 ; i < 45 ; i++){
              if(lottolist.contains((i+1))){
                vis[i] = true;
              }else{
                vis[i] = false;
              }
            }
          });
        },
        tooltip: 'refresh',
        child: Icon(Icons.repeat),
      ),
    );
  }
}
