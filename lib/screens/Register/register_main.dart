import 'package:flutter/material.dart';
// import 'package:telephy/widgets/regist/regist_app_bar.dart';
// import 'package:telephy/widgets/regist/regist_bt.dart';
import 'package:telephy/widgets/regist/regist_text_field.dart';

class RegisterMainScreen extends StatefulWidget {
  final TextEditingController username;
  final TextEditingController password;
  final TextEditingController cfPassword;

  const RegisterMainScreen(
      {super.key,
      required this.username,
      required this.password,
      required this.cfPassword});

  @override
  State<RegisterMainScreen> createState() => _RegisterMainScreenState();
}

class _RegisterMainScreenState extends State<RegisterMainScreen> {
  @override
  Widget build(BuildContext context) {
    const double marginBtwTF = 25;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegistTextField(
          title: "ชื่อผู้ใช้",
          hintText: "Username",
          type: TextInputType.name,
          tfController: widget.username,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "รหัสผ่าน",
          hintText: "Password",
          type: TextInputType.visiblePassword,
          tfController: widget.password,
          isPassword: true,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "ยืนยันรหัสผ่าน",
          hintText: "Confirm Password",
          type: TextInputType.visiblePassword,
          tfController: widget.cfPassword,
          isPassword: true,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
      ],
    );
  }
}
