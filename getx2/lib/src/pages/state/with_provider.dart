import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:getx2/src/controller/count_controller_with_provider.dart';

class WithProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Provider",
              style: TextStyle(fontSize: 50),
            ),
            Consumer<CountControllerWithProvider>(builder: (context, snapshot, child){
              return Text(
                "${snapshot.count}",
                style: TextStyle(fontSize: 50),
              );
            }),

            ElevatedButton(
              onPressed: () {
                Provider.of<CountControllerWithProvider>(context, listen: false).increase();
              },
              child: Text(
                "+",
                style: TextStyle(fontSize: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
