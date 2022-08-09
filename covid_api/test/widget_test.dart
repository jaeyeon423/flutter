// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:covid_api/main.dart';
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
                <accDefRate>1.639564831</accDefRate>
                <accExamCnt>11251982</accExamCnt>
                <createDt>2021-07-20 00:00:00.000</createDt>
                <deathCnt>2059</deathCnt>
                <decideCnt>180472</decideCnt>
                <seq>548</seq>
                <stateDt>20210720</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
            <item>
                <accDefRate>1.634722225</accDefRate>
                <accExamCnt>11202429</accExamCnt>
                <createDt>2021-07-19 00:00:00.000</createDt>
                <deathCnt>2058</deathCnt>
                <decideCnt>179194</decideCnt>
                <seq>547</seq>
                <stateDt>20210719</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-10-07 10:30:51.51</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>2</totalCount>
    </body>
</response>''';

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final document = XmlDocument.parse(bookshelfXml);

    final items = document.findAllElements('item');

    var covid19Statistics = <covid_model>[];

    items.forEach((element) {
      covid19Statistics.add(covid_model.fromXml(element));
    });
    print(covid19Statistics);
  });
}

class covid_model {
  String? accDefRate;
  String? accExamCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;

  covid_model({
    this.accDefRate,
    this.accExamCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt
  });

  factory covid_model.fromXml(XmlElement xml){
    return covid_model(
      accDefRate: xmlUtils.searchResult(xml, "accDefRate"),
      accExamCnt: xmlUtils.searchResult(xml, "accExamCnt"),
      createDt: xmlUtils.searchResult(xml, "createDt"),
      deathCnt: xmlUtils.searchResult(xml, "deathCnt"),
      decideCnt: xmlUtils.searchResult(xml, "decideCnt"),
      seq: xmlUtils.searchResult(xml, "seq"),
      stateDt: xmlUtils.searchResult(xml, "stateDt"),
      stateTime: xmlUtils.searchResult(xml, "stateTime"),
      updateDt: xmlUtils.searchResult(xml, "updateDt"),
    );
  }

}

class xmlUtils{
  static String searchResult(XmlElement xml, String key){

    return xml.findAllElements(key).map((e) => e.text).isEmpty ? "" : xml.findAllElements(key).map((e) => e.text).first;
  }
}