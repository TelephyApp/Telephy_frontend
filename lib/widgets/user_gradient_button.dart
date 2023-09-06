// import 'package:flutter/material.dart';

// class UserButton extends StatelessWidget {
//   final String _title;
//   final double _height;
//   final double _width;

//   const UserButton(this._title, this._height, this._width, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 240,
//       height: 35,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [Color.fromRGBO(134, 210, 252, 1), Color.fromRGBO(204, 173, 249, 1)]
//         ),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(30))
//           ),
//         ),
//         onPressed: () {}, 
//         child: const Text("ถัดไป")),
//     );
//   }
// }