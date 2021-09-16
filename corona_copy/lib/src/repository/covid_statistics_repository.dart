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

  Future<List<Covid19StatisticsModel>> fetchCovid19Statistics(
      String? startDate, String? endDate) async {
    var query = Map<String, String>();
    if (startDate != null) query.putIfAbsent('startCreateDt', () => startDate);
    if (endDate != null) query.putIfAbsent('endCreateDt', () => endDate);

    var response = await _dio.get('http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=1o6bFW6NRZ8yhryfbdSI3TqL0ck14KZjKYGu16xoXLO6mLlD9yY%2BOxKhgCyZzn9yoD6KnMB9tATJ4Wquc0g%2BjA%3D%3D&startCreateDt=${startDate}&endCreateDt=${endDate}');
    final document = XmlDocument.parse(response.data);
    final items = document.findAllElements('item');
    print(items.isEmpty);
    if (!items.isEmpty) {
      return items
          .map<Covid19StatisticsModel>(
              (element) => Covid19StatisticsModel.fromXml(element))
          .toList();
    } else {
      return Future.value(null);
    }
  }
}
