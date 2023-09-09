import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final prefixIcon;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55.0,vertical: 0.0,),
      child: SizedBox(
        height: 45,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(15.0)),
            prefixIcon: prefixIcon,
            prefixIconColor: Colors.black,
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade700),
          ),
        ),
      ),
    );
  }
}
