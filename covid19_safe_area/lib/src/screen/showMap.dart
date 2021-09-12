import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_map/vector_map.dart';

class ShowMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExampleState();
}

class ExampleState extends State<ShowMap> {
  MapDataSource? _dataSource;
  late double headerTopZone = 10;
  bool total_button = true;
  bool percent_button = false;
  bool add_button = false;

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
            elevation: 0,
            title: Text(
              "corona 안전 지역",
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Positioned(
                top: 5,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "2021.09.12 기준", style: TextStyle(color: Colors.lightBlueAccent),
                  )
                ),
              ),
              Container(height: 800, child: content),
              Positioned(
                top: 40,
                left: 20,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                        total_button ? Colors.lightBlueAccent : Colors.white,
                  ),
                  child: Text(
                    "총 확진자 기준",
                    style: TextStyle(
                      color:
                          total_button ? Colors.white : Colors.lightBlueAccent,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      total_button = true;
                      percent_button = false;
                      add_button = false;
                    });
                  },
                ),
              ),
              Positioned(
                top: 40,
                left: 153,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                    percent_button ? Colors.lightBlueAccent : Colors.white,
                  ),
                  child: Text(
                    "증가율 기준",
                    style: TextStyle(
                      color:
                      percent_button ? Colors.white : Colors.lightBlueAccent,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      total_button = false;
                      percent_button = true;
                      add_button = false;
                    });
                  },
                ),
              ),
              Positioned(
                top: 40,
                left: 270,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                    add_button ? Colors.lightBlueAccent : Colors.white,
                  ),
                  child: Text(
                    "추가 확진자 기준",
                    style: TextStyle(
                      color:
                      add_button ? Colors.white : Colors.lightBlueAccent,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      total_button = false;
                      percent_button = false;
                      add_button = true;
                    });
                  },
                ),
              ),
              Positioned(
                top: 480,
                left: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [Text('제일 안전한 지역 : 양천구')],
                    ),
                    Row(
                      children: [Text('제일 위험한 지역 : 강남')],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
