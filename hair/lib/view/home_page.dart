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
            Container(
              height: 150,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(left: 20, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: index == 11 ? Colors.blueGrey : Colors.black12,
                      ),
                      child: HourlyDetails(
                        index: index,
                        cardIndex: 1,
                        temp: 1,
                        timestamp: 1,
                        weatherIcon: "sun",
                      ),
                    ),
                  );
                }),
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
