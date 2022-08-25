import 'package:flutter/material.dart';
import 'package:hair/widgets/hour_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            day_list(),
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
