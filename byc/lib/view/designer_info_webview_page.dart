import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DesignerInfoWebviewPage extends StatefulWidget {
  const DesignerInfoWebviewPage({super.key});

  @override
  State<DesignerInfoWebviewPage> createState() => _DesignerBookingWebviewPage();
}

class _DesignerBookingWebviewPage extends State<DesignerInfoWebviewPage> {
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
          title: Text("DesignerInfoWebviewPage"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 600,
                child: WebView(
                  initialUrl: 'https://m.place.naver.com/restaurant/1961769435/booking?theme=place&entry=pll',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("move booking page"),
              ),
            ],
          ),
        ));
  }
}
