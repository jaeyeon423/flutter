import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentPage = 0;
                    int a = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  color: currentPage == 0 ? Colors.pink : Colors.black,
                )),
            Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentPage = 1;
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: currentPage == 1 ? Colors.pink : Colors.black,
                )),
            Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentPage = 2;
                  });
                },
                icon: Icon(
                  Icons.ondemand_video,
                  color: currentPage == 2 ? Colors.pink : Colors.black,
                )),
            Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentPage = 3;
                  });
                },
                icon: Icon(
                  Icons.card_travel,
                  color: currentPage == 3 ? Colors.pink : Colors.black,
                )),
            Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentPage = 4;
                  });
                },
                icon: Icon(
                  Icons.person,
                  color: currentPage == 4 ? Colors.pink : Colors.black,
                )),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
