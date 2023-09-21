import 'package:flutter/material.dart';

class HeadTab extends StatefulWidget {
  const HeadTab({Key? key}) : super(key: key);

  @override
  _HeadTabState createState() => _HeadTabState();
}

class _HeadTabState extends State<HeadTab> {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text("Bubu"),);
  }
}
