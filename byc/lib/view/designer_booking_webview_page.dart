import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DesignerBookingWebviewPage extends StatefulWidget {
  const DesignerBookingWebviewPage({super.key});

  @override
  State<DesignerBookingWebviewPage> createState() =>
      _DesignerBookingWebviewPage();
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
        title: Text(
          "Booking Detail",
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          child: WebView(
        initialUrl:
            'https://m.booking.naver.com/booking/13/bizes/430830/items/3816900',
        javascriptMode: JavascriptMode.unrestricted,
      )),
    );
  }
}
