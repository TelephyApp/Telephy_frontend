import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/screens/login_screen.dart';
import 'package:telephy/services/user_service.dart';
import 'package:telephy/widgets/regist/register_final.dart';
import 'package:telephy/widgets/regist/regist_app_bar.dart';
import 'package:telephy/widgets/regist/regist_bt.dart';
import 'package:telephy/widgets/regist/regist_text_field.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // formkeys for each step(main, private)
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  //firebase
  final _userService = UserService();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  late final Users userData;

  //var to check does email existed
  String? emailError;

  // controllers
  final username = TextEditingController();
  final password = TextEditingController();
  final cfPassword = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final birthDate = TextEditingController();
  final gender = SingleValueDropDownController();
  final phoneNum = TextEditingController();
  final medicalConditional = TextEditingController();

  int _currentStep = 0;
  final finalScreen = const RegisterFinishScreen();
  final double marginBtwTF = 25;

  final inputBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.solid,
      width: 1,
      color: Colors.black,
    ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

  final errorBorderInputStyle = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      style: BorderStyle.solid,
      width: 0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

  Future<void> validateEmail(String email) async {
    bool result = await _userService.doesEmailExist(email);
    if (result == true) {
      setState(() {
        emailError = "อีเมลถูกใช้งานแล้ว";
      });
    } else {
      setState(() {
        emailError = null;
      });
    }
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    cfPassword.dispose();
    firstName.dispose();
    lastName.dispose();
    birthDate.dispose();
    email.dispose();
    gender.dispose();
    phoneNum.dispose();
    medicalConditional.dispose();

    super.dispose();
  }

  Widget genderDropDown({required controller, required textFieldDecoration}) {
    return DropDownTextField(
      controller: controller,
      clearOption: true,
      // enableSearch: true,
      // dropdownColor: Colors.green,
      textFieldDecoration: textFieldDecoration,
      validator: (value) {
        if (value == "") {
          return "โปรดระบุเพศ";
        } else {
          return null;
        }
      },
      dropDownItemCount: 3,
      dropDownList: const [
        DropDownValueModel(name: 'ชาย', value: "ชาย"),
        DropDownValueModel(name: 'หญิง', value: "หญิง"),
        DropDownValueModel(name: 'ไม่ระบุ', value: "ไม่ระบุ"),
      ],
      onChanged: (val) {},
    );
  }

  // }
  void goToLoginPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Widget mainForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegistTextField(
          title: "ชื่อผู้ใช้",
          hintText: "Username",
          type: TextInputType.name,
          tfController: username,
          validators: RequiredValidator(errorText: 'โปรดระบุชื่อผู้ใช้'),
        ),
        SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "รหัสผ่าน",
          hintText: "Password",
          type: TextInputType.visiblePassword,
          tfController: password,
          isPassword: true,
          validators: MultiValidator([
            RequiredValidator(errorText: 'โปรดระบุรหัสผ่าน'),
            MinLengthValidator(6,
                errorText: 'รหัสผ่านต้องยาวอย่างน้อย 6 ตัวอักษร'),
          ]),
        ),
        SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
            title: "ยืนยันรหัสผ่าน",
            hintText: "Confirm Password",
            type: TextInputType.visiblePassword,
            tfController: cfPassword,
            isPassword: true,
            validators: (value) {
              if (cfPassword.text == "") {
                return 'โปรดระบุการยืนยันรหัสผ่าน';
              } else if (cfPassword.text != password.text) {
                return 'ยืนยันรหัสผ่านไม่ตรงกับรหัสผ่าน';
              } else {
                return null;
              }
            }),
        SizedBox(
          height: marginBtwTF,
        ),
      ],
    );
  }

  Widget privateForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegistTextField(
          title: "ชื่อจริง",
          hintText: "Fisrt Name",
          type: TextInputType.name,
          tfController: firstName,
          validators: RequiredValidator(errorText: "โปรดระบุนชื่อจริง"),
        ),
        SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "นามสกุล",
          hintText: "Last Name",
          type: TextInputType.name,
          tfController: lastName,
          validators: RequiredValidator(errorText: "โปรดระบุนามสกุล"),
        ),
        SizedBox(
          height: marginBtwTF,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "วันเกิด",
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    // height: 40,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //     boxShadow: const [
                    //       BoxShadow(
                    //         color: Colors.black,
                    //         blurRadius: 5,
                    //         offset: Offset(0, 2),
                    //         spreadRadius: -3,
                    //       )
                    //     ]),
                    child: TextFormField(
                      validator:
                          RequiredValidator(errorText: "โปรดระบุวันเกิด"),
                      readOnly: true,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      controller: birthDate,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "dd/mm/yyyy",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ), // Style for hint text
                        focusedBorder: inputBorder,
                        enabledBorder: inputBorder,
                        errorBorder: errorBorderInputStyle,
                        focusedErrorBorder: errorBorderInputStyle,
                        suffixIcon: const Icon(Icons.calendar_today_rounded),
                        suffixIconColor: const Color.fromRGBO(210, 172, 255, 1),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Container(
                            height: 216,
                            padding: const EdgeInsets.only(top: 6.0),
                            // The Bottom margin is provided to align the popup above the system
                            // navigation bar.
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            // Provide a background color for the popup.
                            color: CupertinoColors.systemBackground
                                .resolveFrom(context),
                            // Use a SafeArea widget to avoid system overlaps.
                            child: SafeArea(
                              top: false,
                              child: CupertinoDatePicker(
                                  backgroundColor: Colors.white,
                                  initialDateTime: DateTime.now(),
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (DateTime selectedTime) {
                                    setState(() {
                                      birthDate.text = DateFormat('dd/MM/yyyy')
                                          .format(selectedTime);
                                    });
                                  }),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "เพศ",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  // height: 40,
                  width: 125,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(30),
                  //     boxShadow: const [
                  //       BoxShadow(
                  //         color: Colors.black,
                  //         blurRadius: 5,
                  //         offset: Offset(0, 2),
                  //         spreadRadius: -3,
                  //       )
                  //     ]),
                  child: genderDropDown(
                    controller: gender,
                    textFieldDecoration: InputDecoration(
                      hintText: "เพศ",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: inputBorder,
                      enabledBorder: inputBorder,
                      errorBorder: errorBorderInputStyle,
                      focusedErrorBorder: errorBorderInputStyle,
                      // errorMaxLines: 1,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "อีเมล",
          hintText: "E-mail",
          type: TextInputType.emailAddress,
          tfController: email,
          validators: (value) {
            if (value == "") {
              return ("โปรดระบุอีเมล");
            } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                .hasMatch(value!)) {
              return ("โปรดระบุรูปแบบอีเมลให้ถูกต้อง");
            } else if (emailError != null) {
              return emailError;
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "หมายเลขโทรศัพท์",
          hintText: "Phone Number",
          type: TextInputType.phone,
          tfController: phoneNum,
          validators: (value) {
            if (value == "") {
              return "โปรดระบุหมายเลขโทรศัพท์";
            } else if (!value!.isNum) {
              return "ต้องเป็นหมายเลขเท่านั้น";
            } else if (value.length > 10 || value.length < 10) {
              return "หมายเลขโทรศัพท์ต้องมีความยาว 10 หลัก";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "เงื่อนไขทางการแพทย์",
          hintText: "โรคประจำตัว ยาที่แพ้ เป็นต้น (หากมี)",
          type: TextInputType.text,
          tfController: medicalConditional,
        ),
      ],
    );
  }

  List<Step> getSteps() => [
        Step(
            isActive: _currentStep == 0,
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            title: const Text("ลงทะเบียน"),
            content: Form(key: formKeys[0], child: mainForm())),
        Step(
            isActive: _currentStep == 1,
            state: _currentStep == 1
                ? StepState.editing
                : (_currentStep > 1 ? StepState.complete : StepState.disabled),
            title: const Text("ข้อมูลส่วนตัว"),
            content: Form(key: formKeys[1], child: privateForm())),
        Step(
          isActive: _currentStep == 2,
          state: _currentStep <= 1 ? StepState.disabled : StepState.complete,
          title: const Text("เสร็จสิ้น"),
          content: finalScreen,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
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
                  // goToLoginPage(context);
                  Get.offNamed('/login');
                }
              },
            ),
            body: Stepper(
                elevation: 0,
                connectorThickness: 4,
                connectorColor: const MaterialStatePropertyAll(
                    Color.fromRGBO(210, 172, 255, 1)),
                type: StepperType.horizontal,
                currentStep: _currentStep,
                steps: getSteps(),
                onStepTapped: (int newStep) {
                  setState(() {
                    _currentStep = newStep;
                  });
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Center(
                    child: RegistBT(
                      titleBT: _currentStep < 2 ? 'ถัดไป' : 'เสร็จสิ้น',
                      onPressed: () async {
                        if (_currentStep == 1) {
                          // await Future.delayed(Duration(seconds: 1), () async {
                          //   await validateEmail(email.text);
                          // });
                          await validateEmail(email.text);
                        }

                        if (_currentStep < 2 &&
                            formKeys[_currentStep].currentState!.validate()) {
                          setState(() {
                            _currentStep++;
                          });
                        } else if (_currentStep == 2 &&
                            formKeys[0].currentState!.validate() &&
                            formKeys[1].currentState!.validate()) {
                          DateTime birthday =
                              DateFormat("dd/mm/yyyy").parse(birthDate.text);
                          int age =
                              ((DateTime.now().difference(birthday).inDays) /
                                      365)
                                  .floor();

                          userData = Users(
                              username: username.text,
                              firstname: firstName.text,
                              lastname: lastName.text,
                              email: email.text,
                              gender: gender.dropDownValue!.value,
                              age: age,
                              phone: phoneNum.text,
                              birthday: birthDate.text,
                              imagePath: "");

                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);

                            User user = userCredential.user!;
                            await _userService.storeUserData(user, userData);

                            dispose();
                            Get.offNamed('/main-user');
                          } on FirebaseAuthException catch (e) {
                            // print(e.code);
                            // String message;
                            // if (e.code == 'email-already-in-use') {
                            //   message =
                            //       "มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน";
                            // } else if (e.code == 'weak-password') {
                            //   message =
                            //       "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                            // } else {
                            //   message = e.message!;
                            // }
                            // Fluttertoast.showToast(
                            //     msg: message, gravity: ToastGravity.CENTER);
                          }
                        }
                      },
                    ),
                  );
                }),
          );
        }));
  }
}
