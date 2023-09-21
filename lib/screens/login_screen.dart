import 'package:flutter/material.dart';

import 'package:telephy/screens/register_screen.dart';
import 'package:telephy/widgets/login_button.dart';

import 'package:get/get.dart';
import 'package:telephy/user_layout.dart';
import 'package:telephy/widgets/login_button.dart';
import 'package:telephy/psych_layout.dart';

import 'package:telephy/widgets/square_tile.dart';
import '../utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/signIn_google.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obsecurePass = true;

  void onTap_reg() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => RegisterScreen())));
  }

  // sign user in method

  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage("Incorrect Email or Password");
    }
  }

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          content: Icon(
            Icons.close,
            size: 65,
            color: Colors.red,
          ),
        );
      },

    );
  }


  //-----------------------------

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
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "อีเมล",
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
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor: Colors.black),
                        ),
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        height: 45,
                        width: 250,
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
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
              onTap: signIn,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(
                    onTap: () => AuthService().signInWithGoogle(),
                    imagePath: 'assets/images/google.png'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ยังไม่มีบัญชีผู้ใช้?'),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: onTap_reg,
                  child: Text(
                    'ลงทะเบียน',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
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
