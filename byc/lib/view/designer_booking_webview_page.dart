import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class DesignerBookingWebviewPage extends StatefulWidget {
  const DesignerBookingWebviewPage({super.key});

  @override
  State<DesignerBookingWebviewPage> createState() => _DesignerBookingWebviewPage();
}

class _DesignerBookingWebviewPage extends State<DesignerBookingWebviewPage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DesignerBookingWebviewPage"),
      ),
      body: Container(
          child: WebView(
            initialUrl:
            'https://m.place.naver.com/hairshop/13502147/stylist/3782681?entry=plt',
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}
