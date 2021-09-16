
import 'package:corona_copy/src/utils/data_utils.dart';
import 'package:corona_copy/src/utils/xml_utils.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  double? accDefRate;
  double? accExamCnt;
  double? accExamCompCnt;
  double? careCnt;
  double? clearCnt;
  String? createDt;
  double? deathCnt;
  double? decideCnt;
  double? examCnt;
  double? resultNegCnt;
  double? seq;
  double calcDecideCnt = 0;
  double calcExamCnt = 0;
  double calcDeathCnt = 0;
  double calcClearCnt = 0;
  String? CreateDt;
  DateTime? stateDt;
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
    this.resultNegCnt,
    this.seq,
    this.CreateDt,
    this.stateDt,
    this.stateTime,
    this.updateDt
  });

  factory Covid19StatisticsModel.empty(){
    return Covid19StatisticsModel();
  }
  factory Covid19StatisticsModel.fromXml(XmlElement xml){
    return Covid19StatisticsModel(
      accDefRate: Xmlutils.searchResultForDouble(xml, 'accDefRate'),
      accExamCnt: Xmlutils.searchResultForDouble(xml, 'accExamCnt'),
      accExamCompCnt: Xmlutils.searchResultForDouble(xml, 'accExamCompCnt'),
      careCnt: Xmlutils.searchResultForDouble(xml, 'careCnt'),
      clearCnt: Xmlutils.searchResultForDouble(xml, 'clearCnt'),
      createDt: Xmlutils.searchResultForString(xml, 'createDt'),
      deathCnt: Xmlutils.searchResultForDouble(xml, 'deathCnt'),
      decideCnt: Xmlutils.searchResultForDouble(xml, 'decideCnt'),
      examCnt: Xmlutils.searchResultForDouble(xml, 'examCnt'),
      resultNegCnt: Xmlutils.searchResultForDouble(xml, 'resutlNegCnt'),
      seq: Xmlutils.searchResultForDouble(xml, 'seq'),
      stateDt: Xmlutils.searchResultForString(xml, 'stateDt')!= ''? DateTime.parse(Xmlutils.searchResultForString(xml, 'stateDt')) : null,
      stateTime: Xmlutils.searchResultForString(xml, 'stateTime'),
      updateDt: Xmlutils.searchResultForString(xml, 'updateDt'),
    );
  }

  void updateCalcAboutYesterday(Covid19StatisticsModel yesterData){
    _updateCalcDecideCnt(yesterData.decideCnt!);
    _updateCalcDeathCnt(yesterData.deathCnt!);
    _updateCalcClearCnt(yesterData.clearCnt!);
    _updateCalcExamCnt(yesterData.examCnt!);
  }
  void _updateCalcDecideCnt(double beforeCnt){
    calcDecideCnt = decideCnt! - beforeCnt;
  }
  void _updateCalcDeathCnt(double beforeCnt){
    calcDeathCnt = deathCnt! - beforeCnt;
  }
  void _updateCalcClearCnt(double beforeCnt){
    calcClearCnt = clearCnt! - beforeCnt;
  }
  void _updateCalcExamCnt(double beforeCnt){
    calcExamCnt = examCnt! - beforeCnt;
  }
  String get standardDayString => '${DataUtils.simpleDayFormat(stateDt!)} ${stateTime}';
}

