import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:telephy/widgets/button.dart';

class RegisterFinishScreen extends StatelessWidget {
  const RegisterFinishScreen({super.key});

  void finishReg() {} // เสร็จสิ้นการลงทะเบียน กดเพื่อกลับหน้าหลัก

  void back() {} // กดเพื่อย้อนกลับ

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade200,
            Colors.lightBlue.shade50,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),

                // row : ปุ่มย้อนกลับ, top text
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.chevron_left_rounded,
                      size: 40,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 75,
                    ),
                    Text(
                      'เสร็จสิ้น',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                // progress bar
                StepProgressIndicator(
                  totalSteps: 3,
                  currentStep: 3,
                  padding: 10,
                  size: 20,
                  selectedColor: Colors.green,
                  unselectedColor: Colors.grey,
                  roundedEdges: Radius.circular(15),
                ),

                const SizedBox(
                  height: 30,
                ),

                // รูป
                Image.asset(
                  'assets/images/thankyou.png',
                  scale: 0.9,
                ),

                const SizedBox(
                  height: 30,
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
                  height: 30,
                ),

                // ปุ่ม เสร็จสิ้น
                MyButton(
                  onTap: finishReg,
                  text: 'เสร็จสิ้น',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
