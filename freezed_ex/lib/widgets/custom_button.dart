import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilledButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => child));
        },
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
