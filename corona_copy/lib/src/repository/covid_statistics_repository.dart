import 'package:corona_copy/src/model/covid_statistics.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

  CovidStatisticsRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://openapi.data.go.kr",
        queryParameters: {
          'ServiceKey':
              '1o6bFW6NRZ8yhryfbdSI3TqL0ck14KZjKYGu16xoXLO6mLlD9yY+OxKhgCyZzn9yoD6KnMB9tATJ4Wquc0g+jA=='
        },
      ),
    );
  }

  Future<List<Covid19StatisticsModel>> fetchCovid19Statistics(String? startDate, String? endDate) async {
    var query = Map<String, String>();
    if(startDate != null)
      query.putIfAbsent('startCreatDt', () => startDate);
    var response =
        await _dio.get('/openapi/service/rest/Covid19/getCovid19InfStateJson', queryParamters: {});
    final document = XmlDocument.parse(response.data);
    final items = document.findAllElements('item');
    print(items.isEmpty);
    if(!items.isEmpty) {
      return Covid19StatisticsModel.fromXml(items.first);

    }else{
      return Future.value(null);
    }
    var cobidStatics = <Covid19StatisticsModel>[];
    items.forEach((node) {
      cobidStatics.add(Covid19StatisticsModel.fromXml(node));
      // print(node);
    });


  }
}
