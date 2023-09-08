import 'package:flutter/material.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/screens/register_main_screen.dart';
import 'package:telephy/screens/register_private_screen.dart';
import 'package:telephy/widgets/regist/regist_app_bar.dart';
import 'package:telephy/widgets/regist/regist_bt.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegisterAppBar(
        title: "Register",
        onPressed: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
          else {
            // route back to login screen
            _goToLoginPage(context);
          }
        },
      ),
      
      body: Stepper(
        elevation: 0,
        connectorThickness: 5,
        connectorColor: const MaterialStatePropertyAll(Color.fromRGBO(210, 172, 255, 1)),
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
          }
          else {
            // route back to login screen
            _goToLoginPage(context);
          }
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Center(
            child: RegistBT(
                titleBT: _currentStep < 2 ? 'ถัดไป' : 'เสร็จสิ้น',
                onPressed: () {
                  if (_currentStep != 2) {
                    setState(() {
                      _currentStep++;
                    });
                  }
                  else {
                    // update db and what next i dont know
                  }
                },
              ),
          );
        }
      ),
    );
  }

  List<Step> getSteps() => [
    Step(
      isActive: _currentStep == 0,
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      title: const Text("ลงทะเบียน"), 
      content: RegisterMainScreen()
    ),
    Step(
      isActive: _currentStep == 1,
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      title: const Text("ข้อมูลส่วนตัว"), 
      content: RegisterPrivateScreen()
    ),
    Step(
      isActive: _currentStep == 2,
      state: StepState.complete,
      title: const Text("เสร็จสิ้น"), 
      content: Text("Finish")
    ),

  ];


  void _goToLoginPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}

  
}