import 'package:flutter/material.dart';
import 'package:telephy/widgets/regist_app_bar.dart';
import 'package:telephy/widgets/regist_bt.dart';

class RegisterFinishScreen extends StatelessWidget {
  const RegisterFinishScreen({super.key});

  void finishReg() {} // เสร็จสิ้นการลงทะเบียน กดเพื่อกลับหน้าหลัก

  void back() {} // กดเพื่อย้อนกลับ

  @override
  Widget build(BuildContext context) {
    const double marginBtwTF = 25;
    return Scaffold(
      appBar: const RegisterAppBar(title: 'เสร็จสิ้น'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: marginBtwTF,
            ),

            // progress bar
            Text('progress bar ปิ้ววๆๆ'),

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
            Text(
              'การลงทะเบียนเสร็จสิ้นแล้ว',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            Text(
              'คลิกที่ปุ่มข้างล่างเพื่อกลับไปยัง',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            Text(
              'หน้าหลัก',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),

            const SizedBox(
              height: marginBtwTF,
            ),

            // ปุ่ม เสร็จสิ้น
            const Center(
              child: RegistBT(titleBT: 'เสร็จสิ้น'),
            ),
          ],
        ),
      ),
    );
  }
}
