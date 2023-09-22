import 'package:flutter/material.dart';
import 'package:telephy/screens/Register/regist_ctrl.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/Register/register_final.dart';
import 'package:telephy/screens/Register/register_main.dart';
import 'package:telephy/screens/Register/register_private.dart';
import 'package:telephy/widgets/regist/regist_app_bar.dart';
import 'package:telephy/widgets/regist/regist_bt.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 0;
  final RegistController controller = RegistController();
  final finalScreen = const RegisterFinishScreen();
  late RegisterMainScreen mainScreen;
  late RegisterPrivateScreen privateScreen;

  @override
  void initState() {
    super.initState();
    mainScreen = RegisterMainScreen(
        username: controller.username,
        password: controller.password,
        cfPassword: controller.cfPassword);
    privateScreen = RegisterPrivateScreen(
      firstName: controller.firstName,
      lastName: controller.lastName,
      email: controller.email,
      birthDate: controller.birthDate,
      gender: controller.gender,
      phoneNum: controller.phoneNum,
      medicalConditional: controller.medicalConditional,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegisterAppBar(
        title: _currentStep == 0
            ? "ลงทะเบียน"
            : _currentStep == 1
                ? "ประวัติส่วนตัว"
                : "เสร็จสิ้น",
        onPressed: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          } else {
            // route back to login screen
            _goToLoginPage(context);
          }
        },
      ),
      body: Stepper(
          elevation: 0,
          connectorThickness: 4,
          connectorColor:
              const MaterialStatePropertyAll(Color.fromRGBO(210, 172, 255, 1)),
          type: StepperType.horizontal,
          currentStep: _currentStep,
          steps: getSteps(),
          onStepTapped: (int newStep) {
            setState(() {
              _currentStep = newStep;
            });
          },
          onStepContinue: () {
            if (_currentStep != 2) {
              setState(() {
                _currentStep++;
              });
            }
          },
          onStepCancel: () {
            if (_currentStep != 0) {
              setState(() {
                _currentStep--;
              });
            } else {
              // route back to login screen
              _goToLoginPage(context);
            }
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Center(
              child: RegistBT(
                titleBT: _currentStep < 2 ? 'ถัดไป' : 'เสร็จสิ้น',
                onPressed: () {
                  if (_currentStep >= 0) {
                    setState(() {
                      _currentStep++;
                    });
                  } else if (_currentStep == 2) {
                    // update db and what next i dont know
                  }
                },
              ),
            );
          }),
    );
  }

  List<Step> getSteps() => [
        Step(
            isActive: _currentStep == 0,
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            title: const Text("ลงทะเบียน"),
            content: mainScreen),
        Step(
            isActive: _currentStep == 1,
            state: _currentStep == 1
                ? StepState.editing
                : (_currentStep > 1 ? StepState.complete : StepState.disabled),
            title: const Text("ข้อมูลส่วนตัว"),
            content: privateScreen),
        Step(
          isActive: _currentStep == 2,
          state: _currentStep <= 1 ? StepState.disabled : StepState.complete,
          title: const Text("เสร็จสิ้น"),
          content: finalScreen,
        ),
      ];

  void _goToLoginPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
