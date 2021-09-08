import 'package:corona_copy/src/model/covid_statistics.dart';
import 'package:corona_copy/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';

class CovidStatisticsController extends GetxController{

  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> covidStatistics = Covid19StatisticsModel().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async{
    var result = await _covidStatisticsRepository.fetchCovid19Statistics();
    if(result != null ) {
      covidStatistics(result);
    }
  }
}