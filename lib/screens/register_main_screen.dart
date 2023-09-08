import 'package:flutter/material.dart';
import 'package:telephy/widgets/regist_app_bar.dart';
import 'package:telephy/widgets/regist_bt.dart';
import 'package:telephy/widgets/regist_text_field.dart';

class RegisterMainScreen extends StatelessWidget {
  const RegisterMainScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    const double marginBtwTF = 25;
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController cfPasswordController = TextEditingController();


    return Scaffold(
      appBar: const RegisterAppBar(title: "ลงทะเบียน"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 38,
                  color: Colors.black,
                  margin: const EdgeInsets.only(bottom: 30)
              ), // state container
              RegistTextField(
                title: "ชื่อผู้ใช้", 
                hintText: "Username", 
                type: TextInputType.name,
                tfController: usernameController,
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              RegistTextField(
                title: "รหัสผ่าน", 
                hintText: "Password", 
                type: TextInputType.visiblePassword, 
                tfController: passwordController,
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              RegistTextField(
                title: "ยืนยันรหัสผ่าน", 
                hintText: "Confirm Password", 
                type: TextInputType.name,
                tfController: cfPasswordController,
              ),
              const Center(
                child: RegistBT(titleBT: "ถัดไป"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
