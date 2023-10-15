import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/services/user_service.dart';
import 'package:telephy/widgets/regist/regist_app_bar.dart';
import 'package:telephy/widgets/regist/regist_bt.dart';
import 'package:telephy/widgets/regist/regist_text_field.dart';

class RegistGoogle extends StatefulWidget {
  const RegistGoogle({super.key});

  @override
  State<RegistGoogle> createState() => RegistGoogleState();
}

class RegistGoogleState extends State<RegistGoogle> {
  final double marginBtwTF = 25.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  late final Users userData;
  //controllers
  final _username = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _birthDate = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _gender = SingleValueDropDownController();
  final _medicalConditional = TextEditingController();

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
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegisterAppBar(
          title: "ประวัติส่วน", onPressed: FirebaseAuth.instance.signOut),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegistTextField(
                  title: "ชื่อผู้ใช้",
                  hintText: "Username",
                  type: TextInputType.name,
                  tfController: _username,
                  validators:
                      RequiredValidator(errorText: 'โปรดระบุชื่อผู้ใช้'),
                ),
                SizedBox(
                  height: marginBtwTF,
                ),
                RegistTextField(
                  title: "ชื่อจริง",
                  hintText: "Fisrt Name",
                  type: TextInputType.name,
                  tfController: _firstName,
                  validators: RequiredValidator(errorText: "โปรดระบุนชื่อจริง"),
                ),
                SizedBox(
                  height: marginBtwTF,
                ),
                RegistTextField(
                  title: "นามสกุล",
                  hintText: "Last Name",
                  type: TextInputType.name,
                  tfController: _lastName,
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
                              validator: (val) {
                                if (val == "") {
                                  return "โปรดระบุวันเกิด";
                                } else {
                                  List<String> dateParts = val!.split('/');
                                  int year = int.parse(dateParts[2]);
                                  if (year > 2012) {
                                    return "ปีเกิดต้องต่ำกว่า 2013";
                                  }
                                }
                                return null;
                              },
                              readOnly: true,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              controller: _birthDate,
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
                                suffixIcon:
                                    const Icon(Icons.calendar_today_rounded),
                                suffixIconColor:
                                    const Color.fromRGBO(210, 172, 255, 1),
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
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    // Provide a background color for the popup.
                                    color: CupertinoColors.systemBackground
                                        .resolveFrom(context),
                                    // Use a SafeArea widget to avoid system overlaps.
                                    child: SafeArea(
                                      top: false,
                                      child: CupertinoDatePicker(
                                          backgroundColor: Colors.white,
                                          // initialDateTime: DateTime.now(),
                                          maximumYear: 2013,
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged:
                                              (DateTime selectedTime) {
                                            setState(() {
                                              _birthDate.text =
                                                  DateFormat('dd/MM/yyyy')
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
                            controller: _gender,
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
                  title: "หมายเลขโทรศัพท์",
                  hintText: "Phone Number",
                  type: TextInputType.phone,
                  tfController: _phoneNumber,
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
                  tfController: _medicalConditional,
                ),
                SizedBox(
                  height: marginBtwTF,
                ),
                Center(
                  child: RegistBT(
                    titleBT: "เสร็จสิ้น",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null && user.email != null) {
                            DateTime birthday =
                                DateFormat("dd/MM/yyyy").parse(_birthDate.text);
                            int age =
                                ((DateTime.now().difference(birthday).inDays) /
                                        365)
                                    .floor();
                            String userEmail =
                                await UserService().getGoogleSignInEmail();
                            userData = Users(
                                username: _username.text,
                                firstname: _firstName.text,
                                lastname: _lastName.text,
                                email: userEmail,
                                gender: _gender.dropDownValue!.value,
                                age: age,
                                phone: _phoneNumber.text,
                                birthday: _birthDate.text,
                                imagePath: "",
                                chatRoomsId: [],
                                medicalCondition: _medicalConditional.text != ""
                                    ? _medicalConditional.text
                                    : "");

                            await UserService().storeUserData(user, userData);
                            Get.offNamed('/main-user');
                          } else {
                            // Handle the case where user or user.email is null
                            // You can show an error message or take appropriate action.
                            print("User or email is null");
                          }
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
