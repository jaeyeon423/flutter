import 'package:farm/utils/xml_util.dart';
import 'package:xml/xml.dart';

class InfoModel {
  String bidtime;
  String chulagtnm;
  String coname;
  String gradename;
  String marketname;
  String mclassname;
  String price;
  String sanji;
  String sclassname;
  String tradeamt;
  String unitname;

  InfoModel({
    required this.bidtime,
    required this.chulagtnm,
    required this.coname,
    required this.gradename,
    required this.marketname,
    required this.mclassname,
    required this.price,
    required this.sanji,
    required this.sclassname,
    required this.tradeamt,
    required this.unitname,
  });

  //factory Infomodel.fromXml(XmlElement element)
  factory InfoModel.fromXml(XmlElement element) {
    return InfoModel(
      bidtime: XmlUtils.searchResult(element, 'bidtime'),
      chulagtnm: XmlUtils.searchResult(element, 'chulagtnm'),
      coname: XmlUtils.searchResult(element, 'coname'),
      gradename: XmlUtils.searchResult(element, 'gradename'),
      marketname: XmlUtils.searchResult(element, 'marketname'),
      mclassname: XmlUtils.searchResult(element, 'mclassname'),
      price: XmlUtils.searchResult(element, 'price'),
      sanji: XmlUtils.searchResult(element, 'sanji'),
      sclassname: XmlUtils.searchResult(element, 'sclassname'),
      tradeamt: XmlUtils.searchResult(element, 'tradeamt'),
      unitname: XmlUtils.searchResult(element, 'unitname'),
    );
  }

  Map<String, dynamic> toJson() => {
        "bidtime": bidtime,
        "chulagtnm": chulagtnm,
        "coname": coname,
        "gradename": gradename,
        "marketname": marketname,
        "mclassname": mclassname,
        "price": price,
        "sanji": sanji,
        "sclassname": sclassname,
        "tradeamt": tradeamt,
        "unitname": unitname,
      };
}
