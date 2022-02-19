// import 'package:delivery_app/screens/main_screen.dart';
// import 'package:flutter/material.dart';

// class FoodCategory extends StatefulWidget {
//   @override
//   State<FoodCategory> createState() => _FoodCategoryState();
// }

// class _FoodCategoryState extends State<FoodCategory> {
//   var category_food = ['전체', '한식', '치킨', '중식', '양식', '디저트'];

//   Widget _button_cate(int cate_num) {
//     return Container(
//       margin: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: ElevatedButton(
//         onPressed: () {
//           setState(() {
//             category_num = cate_num;
//           });
//         },
//         child: Text(
//           category_food[cate_num],
//           style: TextStyle(color: Colors.black54),
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.white,
//           side: BorderSide(
//             color: category_num == cate_num ? Colors.black54 : Colors.white,
//             width: 2,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       child: Container(
//         color: Colors.white,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: [
//             for (var i = 0; i < 5; i++)
//               Container(
//                 child: _button_cate(i),
//                 width: 100,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
