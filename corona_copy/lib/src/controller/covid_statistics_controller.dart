import 'package:corona_copy/src/canvas/arrow_clip_path.dart';
import 'package:corona_copy/src/model/covid_statistics.dart';
import 'package:corona_copy/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> _todayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekData = <Covid19StatisticsModel>[].obs;
  double maxDecideValue = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async {
    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(Duration(days: 8)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var result = await _covidStatisticsRepository.fetchCovid19Statistics(
        startDate, endDate);
    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].updateCalcAboutYesterday(result[i + 1]);
          if(maxDecideValue < result[i].calcDecideCnt) {
            maxDecideValue = result[i].calcDecideCnt;
          }
        }
      }
      _weekData.addAll(result.sublist(0, result.length - 2).reversed);
      _todayData(_weekData.last);
      print(_weekData.length);
    }
  }

  Covid19StatisticsModel get todayData => _todayData.value;
  List<Covid19StatisticsModel> get weekDays => _weekData;
  ArrowDirection calcUpDown(double value){
    if(value ==0){
      return ArrowDirection.MIDDLE;
    }else if(value > 0) {
      return ArrowDirection.UP;
    }else{
      return ArrowDirection.DOWN;
    }
  }
}
