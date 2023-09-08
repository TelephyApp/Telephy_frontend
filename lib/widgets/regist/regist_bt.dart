import 'package:flutter/material.dart';

class RegistBT extends StatelessWidget {
  const RegistBT({
    super.key, 
    required this.titleBT, 
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final String titleBT;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      width: 240,
      height: 35,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color.fromRGBO(134, 210, 252, 1), Color.fromRGBO(204, 173, 249, 1)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            offset: Offset(0, 2),
            spreadRadius: -3,
          )
        ]
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
        onPressed: onPressed,
        child: Text(
          titleBT, 
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),),
      ),
    );
  }
}