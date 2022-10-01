import 'package:dio/dio.dart';
import 'package:farm/model/info_model.dart';
import 'package:xml/xml.dart';

class InfoRepository {
  late var _dio;
  InfoRepository() {
    _dio = Dio(
      BaseOptions(
          baseUrl: "http://openapi.epis.or.kr/openapi/service",
          queryParameters: {
            'ServiceKey':
                '1o6bFW6NRZ8yhryfbdSI3TqL0ck14KZjKYGu16xoXLO6mLlD9yY%2BOxKhgCyZzn9yoD6KnMB9tATJ4Wquc0g%2BjA%3D%3D',
            'dates': '20220822',
            'pageNo': '2',
          }),
    );
  }

  Future<InfoModel> fetchInfo() async {
    var response = await _dio.get(
      '/RltmAucBrknewsService/getWltRltmAucBrknewsList',
    );
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');
    var tmp = results.map<InfoModel>((e) => InfoModel.fromXml(e)).toList();
    print("");
    for (InfoModel i in tmp) {
      print(i);
    }
    if (results.isNotEmpty) {
      return InfoModel.fromXml(results.first);
    } else {
      return Future.value(null);
    }
    print(document);
  }
}
