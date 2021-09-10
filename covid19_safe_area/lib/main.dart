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

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/seoul.json').then((geojson) {
      _loadDataSource(geojson);
    });
  }

  _loadDataSource(String geojson) async {
    MapDataSource dataSource = await MapDataSource.geoJSON(geojson: geojson, labelKey: 'name');
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
            11251: Colors.red,
            11252: Colors.orange,
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
            body: Padding(child: content, padding: EdgeInsets.all(32))));
  }
}
