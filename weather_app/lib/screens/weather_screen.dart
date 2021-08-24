import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData});

  final dynamic parseWeatherData;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  String cityName = "";
  double temp = 0.0;
  int temp2 = 0;
  @override
  void initState(){
    super.initState();

    updateDate(widget.parseWeatherData);
  }

  void updateDate(dynamic weatherData){
    temp= weatherData['main']['temp'];
    temp2 = temp.toInt();
    cityName = weatherData['name'];
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$cityName',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '$temp2',
                style: TextStyle(fontSize: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
