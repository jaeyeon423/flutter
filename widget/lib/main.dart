import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaterialBanner'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Show Dialog'),
          onPressed: () {
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                padding: const EdgeInsets.all(5),
                content: const Text("Subscribe"),
                leading: const Icon(Icons.notifications_active_outlined),
                backgroundColor: Colors.white12,
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    child: const Text("Dismis"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
