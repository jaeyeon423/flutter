import 'package:flutter/material.dart';

class DesignerInfoWidget extends StatelessWidget {
  const DesignerInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            width: MediaQuery.of(context).size.width,
            height: 180,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 5, left: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(right: 1),
                          height: 100,
                          child: Image(
                            image: AssetImage(
                              'assets/images/1.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(right: 1),
                          height: 100,
                          child: Image(
                            image: AssetImage(
                              'assets/images/2.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(right: 1),
                          height: 100,
                          child: Image(
                            image: AssetImage(
                              'assets/images/3.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 100,
                          child: Center(
                            child: Text(
                              "···",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Designer Name · 10년",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("미용실 위치"),
                          ],
                        ),
                      ),
                      flex: 4,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print(index);
                        },
                        child: Center(
                          child: Icon(Icons.star_border),
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
