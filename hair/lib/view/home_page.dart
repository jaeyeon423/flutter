import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text("날짜"),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 370,
              color: Colors.red,
              child: Center(child: Text("image")),
            ),
            Container(
              height: 170,
              color: Colors.orange,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 65,
                        height: 65,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 65,
                        height: 65,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 65,
                        height: 65,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 65,
                        height: 65,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 65,
                        height: 65,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 65,
                        height: 65,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 65,
                        height: 65,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 65,
                        height: 65,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
