import 'package:flutter/material.dart';
import 'package:telephy/utils/config.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_new),
              label: Text("นัดพบนักจิตวิทยา")),
        ],
      ),
    );
  }
}
