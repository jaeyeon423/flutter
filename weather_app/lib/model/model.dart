import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model{
  Widget getWeatherIcon(int condition){
    if(condition < 300) {
      return SvgPicture.asset('svg/Cloud-Lightning-Sun.svg', color: Colors.black87);
    }else{
      return SvgPicture.asset('svg/Cloud-Lightning-Sun.svg', color: Colors.black87);
    }
  }
}