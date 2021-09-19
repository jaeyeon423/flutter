import 'package:flutter/material.dart';
import 'package:getx/src/controller/count_controller_with_provider.dart';
import 'package:provider/provider.dart';

class WithProvider extends StatelessWidget {
  const WithProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Provider",
            style: TextStyle(fontSize: 50),
          ),
          Consumer<CountControllerWithProvider>(
            builder: (_, snapshot, child) {
              return Text(
                '${snapshot.count}',
                style: TextStyle(fontSize: 35),
              );
            },
          ),
          ElevatedButton(onPressed: () {
            Provider.of<CountControllerWithProvider>(context, listen: false).increase();
          }, child: Text("+"))
        ],
      ),
    );
  }
}
