import 'package:xml/xml.dart';

class Xmlutils{
  static String searchResult(XmlElement xml, String key){
    return xml.findAllElements(key).map((e) => e.text).isEmpty? "" :xml.findAllElements(key).map((e) => e.text).first;

  }
}