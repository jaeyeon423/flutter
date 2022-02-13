import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';


const Map<String, String> UNIT_ID = kReleaseMode
    ? {
  'android': 'ca-app-pub-3498620342075846/9866553053',
}
    : {
  'android': 'ca-app-pub-3498620342075846/9866553053',
};

class UrlInfoScreen extends StatelessWidget {
  BannerAd banner = BannerAd(
    listener: BannerAdListener(),
    size: AdSize.banner,
    adUnitId: UNIT_ID['android']!,
    request: AdRequest(),
  )..load();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rul Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Text(
                Get.arguments,
                style: TextStyle(fontSize: 20),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.blue
                )
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: () async{
              String url = Get.arguments;
              if (url != null) {
                print(url);
                if (await canLaunch(url)) {
              await launch(url);
              } else {
              throw 'Could not launch $url';
              }
              } else {
              print("url is null");
              }
            }, child: Text("Go!")),
            Container(
              height: 50,
              width: 350,
              child: AdWidget(
                ad: banner,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
