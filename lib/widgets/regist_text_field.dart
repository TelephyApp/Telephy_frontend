import 'package:flutter/material.dart';

class RegistTextField extends StatelessWidget {
  const RegistTextField({
    super.key,
    required this.title, 
    required this.hintText, 
    required this.type,
    this.suffixIcon, 
    this.tfController, 
  });

  final String title;
  final String hintText;
  final IconData? suffixIcon;
  final TextEditingController? tfController;
  final TextInputType type;

  final boderInputStyle = const OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, 
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: TextField(
            keyboardType: type,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: boderInputStyle,
              enabledBorder: boderInputStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              suffixIcon: Icon(suffixIcon),
            ),
          ),
        ),
      ],
    );
  }
}