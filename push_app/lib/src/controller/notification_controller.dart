import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    _initNotification();
    super.onInit();
  }

  void _initNotification() {
    _messaging.getInitialMessage().then((value) => print("value= ${value}"));

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("onMessageOpenedApp data : ${event.data}");
    });

    FirebaseMessaging.onMessage.listen((event) {
      print("Get a message while in the foreground");
      print("onMessage data : ${event.data}");
    });
  }
}
