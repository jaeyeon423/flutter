import 'package:flutter/material.dart';

const boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    boxShadow: [
      BoxShadow(
        color: Colors.black45,
        spreadRadius: 0.1,
        blurRadius: 3,
        offset: Offset(1.5, 1.5),
      ),
    ],
  );
