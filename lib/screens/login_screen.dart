// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:telephy/widgets/button.dart';
import 'package:telephy/widgets/textfield_login.dart';
import 'package:telephy/widgets/square_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obsecurePass = true;

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        // wrap Container ไว้เพื่อทำสีแบบ gradient
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.deepPurple.shade200,
              Colors.lightBlue.shade200
            ])),
        child: Scaffold(
          // นี่คือตัวจัด layout หลัก
          backgroundColor: Colors.transparent,
          body: SafeArea(
            // wrap Column ไว้ทำให้ไม่ทับขอบบน
            child: Center(
              child: Column(
                children: [
                  // sizedbox = ทำที่ว่าง
                  const SizedBox(
                    height: 120,
                  ),
                  // logo
                  Icon(
                    Icons.person_add,
                    size: 100,
                    color: Colors.white,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // top text
                  Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // username textfield
                  MyTextField(
                    controller: _usernameController,
                    prefixIcon: Icon(Icons.person),
                    hintText: 'ชื่อผู้ใช้',
                    obscureText: false,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // password textfield
                  MyTextField(
                    controller: _passwordController,
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'รหัสผ่าน',
                    obscureText: true,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // ปุ่ม sign in
                  MyButton(
                    text: 'เข้าสู่ระบบ',
                    onTap: signUserIn,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // google sign in button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(imagePath: 'assets/images/google.png'),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // register text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ยังไม่มีบัญชีผู้ใช้?'),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'ลงทะเบียน',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
