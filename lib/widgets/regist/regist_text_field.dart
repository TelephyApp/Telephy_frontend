import 'package:flutter/material.dart';

class RegistTextField extends StatelessWidget {
  const RegistTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.type,
    required this.tfController,
    this.suffixIcon,
  });

  final String title;
  final String hintText;
  final IconData? suffixIcon;
  final TextEditingController tfController;
  final TextInputType type;

  final boderInputStyle = const OutlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.solid,
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF000000),
              fontWeight: FontWeight.w400,
            )),
        // const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
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
