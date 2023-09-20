// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/widgets/login_button.dart';
import 'package:telephy/widgets/regist/regist_text_field.dart';
import 'package:telephy/widgets/textfield_login.dart';
import 'package:telephy/widgets/square_tile.dart';
import '../utils/config.dart';
import '../services/google_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obsecurePass = true;

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    final boderInputStyle = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.0));

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Config.mainColor1, Config.mainColor2],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Icon(
                    Icons.person_add,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 250,
                        child: TextField(
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "ชื่อผู้ใข้",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: boderInputStyle,
                              enabledBorder: boderInputStyle,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              prefixIcon: Icon(Icons.person),
                              prefixIconColor: Colors.black),
                        ),
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        height: 45,
                        width: 250,
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "รหัสผ่าน",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: boderInputStyle,
                              enabledBorder: boderInputStyle,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              prefixIcon: Icon(Icons.lock_rounded),
                              prefixIconColor: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LoginButton(
              text: 'เข้าสู่ระบบ',
              onTap: signUserIn,
            ),
            const SizedBox(height: 30),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'assets/images/google.png'),
                ],
              ),
              onTap: () {
                print("login");
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ยังไม่มีบัญชีผู้ใช้?'),
                const SizedBox(width: 4),
                Text(
                  'ลงทะเบียน',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 198,
              child: Image.asset(
                'assets/images/cloud.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
