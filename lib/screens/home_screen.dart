// import 'package:flutter/material.dart';
// import 'package:telephy/utils/config.dart';
// import 'package:sliding_card/sliding_card.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen(
//     this.controller, {
//     super.key,
//     required this.onTapped,
//   });

//   // SlidingCardController slidingCardController;
//   final Function onTapped;

  

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//     SlidingCardController controller;
//   @override
//   Widget build(BuildContext context) {
//   void initState() {
//     super.initState();
//     controller = SlidingCardController();
//   }
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           InterviewCard(
//             onTapped: () {
//               if (controller.isCardSeparated == true) {
//                 controller.collapseCard();
//               } else {
//                 controller.expandCard();
//               }
//             },
//             slidingCardController: controller,
//           )
//         ],
//       ),
//     );
//   }
// }
