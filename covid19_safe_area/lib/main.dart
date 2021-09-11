import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vector_map/vector_map.dart';

void main() {
  runApp(ExampleWidget());
}

class ExampleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExampleState();
}

class ExampleState extends State<ExampleWidget> {
  MapDataSource? _dataSource;
  late double headerTopZone = 10;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/seoul.json').then((geojson) {
      _loadDataSource(geojson);
    });
  }

  _loadDataSource(String geojson) async {
    MapDataSource dataSource = await MapDataSource.geoJSON(
        geojson: geojson, keys: ['code'], labelKey: 'code');
    setState(() {
      _dataSource = dataSource;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? content;
    if (_dataSource != null) {
      content = VectorMap(layers: [
        MapLayer(
          dataSource: _dataSource!,
          theme: MapValueTheme(
              contourColor: Colors.white,
              labelVisibility: (feature) => true,
              key: 'code',
              colors: {
                11250: Colors.green,
                11170: Colors.red,
                11150: Colors.orange,
                11253: Colors.blue
              }),
        )
      ]);
    } else {
      content = Text('Loading...');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Icon(
              Icons.menu,
              color: Colors.lightBlueAccent,
            ),
            elevation: 0,
            title: Text(
              "corona 현황",
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            centerTitle: true,
            actions: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.notifications,
                  color: Colors.lightBlueAccent,
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Positioned(
                top: 5,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xff195f68)),
                    child: Text(
                      '07.24 00L00 기준',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(height: 600, child: content),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Text(
                      '증가율',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Text(
                      '추가 확진자',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 40,
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.lightBlueAccent),
                    child: Text(
                      '총 확진자',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 450,
                left: 100,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('제일 안전한 지역 : 양천구')
                      ],
                    ),
                    Row(
                      children: [
                        Text('제일 위험한 지역 : 강남')
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
