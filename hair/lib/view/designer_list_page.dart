import 'package:flutter/material.dart';

class DesignerList extends StatelessWidget {
  const DesignerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "designer list",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        // decoration: BoxDecoration(color: Colors.deepPurple),
        width: double.infinity,
        height: size.height,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: 180,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/images/0.jpg',
                        ),
                        width: 80,
                      ),
                      Image(
                        image: AssetImage(
                          'assets/images/0.jpg',
                        ),
                        width: 80,
                      ),
                      Image(
                        image: AssetImage(
                          'assets/images/0.jpg',
                        ),
                        width: 80,
                      ),
                      Image(
                        image: AssetImage(
                          'assets/images/0.jpg',
                        ),
                        width: 80,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "부원장 소희 - ${index}년",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("아트라 광교점"),
                  Text("4.9(2194) |  10:00 ~ 21:00")
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
