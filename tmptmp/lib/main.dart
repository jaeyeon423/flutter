import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Beep Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text("Beep Success"),
                onPressed: () => FlutterBeep.beep(),
              ),
              ElevatedButton(
                child: Text("Beep Fail"),
                onPressed: () => FlutterBeep.beep(false),
              ),
              ElevatedButton(
                child: Text("Beep Android Custom"),
                onPressed: () => FlutterBeep.playSysSound(
                    AndroidSoundIDs.TONE_SUP_RINGTONE),
              ),
              ElevatedButton(
                child: Text("Beep something"),
                onPressed: () => FlutterBeep.playSysSound(41),
              ),
              ElevatedButton(
                child: Text("Beep iOS Custom"),
                onPressed: () =>
                    FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy),
              ),
            ],
          ),
        ),
      ),
    );
  }
}