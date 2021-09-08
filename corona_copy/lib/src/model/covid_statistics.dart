
import 'package:corona_copy/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  String? accDefRate;
  String? accExamCnt;
  String? accExamCompCnt;
  String? careCnt;
  String? clearCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? examCnt;
  String? resutlNegCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel({
    this.accDefRate,
    this.accExamCnt,
    this.accExamCompCnt,
    this.careCnt,
    this.clearCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.examCnt,
    this.resutlNegCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt
  });
  factory Covid19StatisticsModel.fromXml(XmlElement xml){
    return Covid19StatisticsModel(
      accDefRate: Xmlutils.searchResult(xml, 'accDefRate'),
      accExamCnt: Xmlutils.searchResult(xml, 'accExamCnt'),
      accExamCompCnt: Xmlutils.searchResult(xml, 'accExamCompCnt'),
      careCnt: Xmlutils.searchResult(xml, 'careCnt'),
      clearCnt: Xmlutils.searchResult(xml, 'clearCnt'),
      createDt: Xmlutils.searchResult(xml, 'createDt'),
      deathCnt: Xmlutils.searchResult(xml, 'deathCnt'),
      decideCnt: Xmlutils.searchResult(xml, 'decideCnt'),
      examCnt: Xmlutils.searchResult(xml, 'examCnt'),
      resutlNegCnt: Xmlutils.searchResult(xml, 'resutlNegCnt'),
      seq: Xmlutils.searchResult(xml, 'seq'),
      stateDt: Xmlutils.searchResult(xml, 'stateDt'),
      stateTime: Xmlutils.searchResult(xml, 'stateTime'),
      updateDt: Xmlutils.searchResult(xml, 'updateDt'),
    );
  }
}

