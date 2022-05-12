import 'package:flutter/material.dart';
import 'package:getx_eample/src/controller/count_controller_with_provider.dart';
import 'package:provider/provider.dart';


class WithProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Provider"),
          Consumer<CountControllerWithProvider>(builder: (_,snapshot,child){
            return Text("${snapshot.count}");
          }),
          ElevatedButton(onPressed: () {
            Provider.of<CountControllerWithProvider>(context, listen: false).increase();
          }, child: Text("+"),),
        ],
      ),
    );
  }
}
