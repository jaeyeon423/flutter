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
        title: Text("BookingWebviewPage"),
      ),
      body: Container(
          child: WebView(
            initialUrl:
            'https://m.place.naver.com/restaurant/1961769435/booking?theme=place&entry=pll',
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}
