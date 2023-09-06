import 'dart:ui';

import 'package:flutter/material.dart';

class RegisterMainScreen extends StatelessWidget {
  const RegisterMainScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    const double marginBtwTF = 25;
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController cfPasswordController = TextEditingController();

    const boderInputStyle = OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );

    InputDecoration inputDec(String hintText) {
      return InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: boderInputStyle,
        enabledBorder: boderInputStyle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20)
      );
    }

    const labelxStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    Container nextButton = Container(
      margin: const EdgeInsets.only(top: 45),
      width: 240,
      height: 35,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color.fromRGBO(134, 210, 252, 1), Color.fromRGBO(204, 173, 249, 1)]
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
        ),
        onPressed: () {}, 
        child: const Text("ถัดไป")),
    );

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(124, 129, 255, 1), Color.fromRGBO(174, 178, 253, 1), Color.fromRGBO(215, 216, 255, 0)]),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          const Text("ลงทะเบียน", style: TextStyle(fontSize: 28),),
          const SizedBox(width: 30,)
        ],
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 38,
                  color: Colors.black,
                  margin: const EdgeInsets.only(bottom: 30)), // state container
              const SizedBox(
                  height: marginBtwTF, child: Text("ชื่อผู้ใช้", style: labelxStyle)),
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: inputDec("Username"),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                  height: marginBtwTF, child: Text("รหัสผ่าน", style: labelxStyle)),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: inputDec("Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                  height: marginBtwTF, child: Text("ยืนยันรหัสผ่าน", style: labelxStyle)),
              TextField(
                controller: cfPasswordController,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: inputDec("Confirm Password"),
              ),
              Center(
                child: nextButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
