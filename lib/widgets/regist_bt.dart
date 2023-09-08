import 'package:flutter/material.dart';

class RegistBT extends StatelessWidget {
  const RegistBT({
    super.key, 
    required this.titleBT,
  });

  final String titleBT;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 45),
      width: 240,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color.fromRGBO(134, 210, 252, 1), Color.fromRGBO(204, 173, 249, 1)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // padding: const EdgeInsets.symmetric(vertical: 8),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () {},
        child: Text(
          titleBT, 
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),),
      ),
    );
  }
}