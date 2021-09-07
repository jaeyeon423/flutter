import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:corona_copy/main.dart';
import 'package:xml/xml.dart';

void main() {
  final bookshelfXml =
      '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                            <response>
                                <header>
                                    <resultCode>00</resultCode>
                                    <resultMsg>NORMAL SERVICE.</resultMsg>
                                </header>
                                <body>
                                    <items>
                                        <item>
                                            <accDefRate>2.0899643437</accDefRate>
                                            <accExamCnt>13416747</accExamCnt>
                                            <accExamCompCnt>12525429</accExamCompCnt>
                                            <careCnt>25755</careCnt>
                                            <clearCnt>233695</clearCnt>
                                            <createDt>2021-09-06 09:43:09.889</createDt>
                                            <deathCnt>2327</deathCnt>
                                            <decideCnt>261777</decideCnt>
                                            <examCnt>891318</examCnt>
                                            <resutlNegCnt>12263652</resutlNegCnt>
                                            <seq>627</seq>
                                            <stateDt>20210906</stateDt>
                                            <stateTime>00:00</stateTime>
                                            <updateDt>2021-09-07 10:25:49.129</updateDt>
                                        </item>
                                        <item>
                                            <accDefRate>2.0818764374</accDefRate>
                                            <accExamCnt>13382737</accExamCnt>
                                            <accExamCompCnt>12508043</accExamCompCnt>
                                            <careCnt>25747</careCnt>
                                            <clearCnt>232334</clearCnt>
                                            <createDt>2021-09-05 10:48:36.114</createDt>
                                            <deathCnt>2321</deathCnt>
                                            <decideCnt>260402</decideCnt>
                                            <examCnt>874694</examCnt>
                                            <resutlNegCnt>12247641</resutlNegCnt>
                                            <seq>626</seq>
                                            <stateDt>20210905</stateDt>
                                            <stateTime>00:00</stateTime>
                                            <updateDt>2021-09-07 10:25:39.033</updateDt>
                                        </item>
                                    </items>
                                    <numOfRows>10</numOfRows>
                                    <pageNo>1</pageNo>
                                    <totalCount>2</totalCount>
                                </body>
                            </response>''';

  test('corona test', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');
    var cobidStatics = <Covid19StatisticsModel>[];
    items.forEach((node) {
      cobidStatics.add(Covid19StatisticsModel.fromXml(node));
      // print(node);
    });
    print(cobidStatics.length);
    cobidStatics.forEach((element) {
      print('${element.stateDt} : ${element.decideCnt}');
    });
  });
}

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

class Xmlutils{
  static String searchResult(XmlElement xml, String key){
    return xml.findAllElements(key).map((e) => e.text).isEmpty? "" :xml.findAllElements(key).map((e) => e.text).first;

  }
}
