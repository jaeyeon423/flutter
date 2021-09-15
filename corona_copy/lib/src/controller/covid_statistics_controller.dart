import 'package:corona_copy/src/model/covid_statistics.dart';
import 'package:corona_copy/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController{

  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> _todayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekData = <Covid19StatisticsModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async{
    var startDate = DateFormat('yyyyMMdd').format(DateTime.now().subtract(Duration(days: 8)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var result = await _covidStatisticsRepository.fetchCovid19Statistics(startDate, endDate);
    print(result.length);
    if(result.isNotEmpty ) {
      for(var i = 0 ; i < result.length ; i++) {
        result[i].updateCalcAboutYesterday(result[i+1]);
      }
      _weekData.addAll(result);
    }
  }
}