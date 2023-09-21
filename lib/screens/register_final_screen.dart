import 'package:flutter/material.dart';

class RegisterFinishScreen extends StatelessWidget {
  const RegisterFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double marginBtwTF = 25;
    return Column(
      children: [
        const SizedBox(
          height: marginBtwTF,
        ),

        // รูป
        Image.asset(
          'assets/images/thankyou.png',
          scale: 0.9,
        ),

        const SizedBox(
          height: marginBtwTF,
        ),

        // finishing text
        const Text(
          'การลงทะเบียนเสร็จสิ้นแล้ว',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),

        const Text(
          'คลิกที่ปุ่มข้างล่างเพื่อกลับไปยัง',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),

        const Text(
          'หน้าหลัก',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),

        const SizedBox(
          height: marginBtwTF,
        ),
      ],
    );
  }
}
