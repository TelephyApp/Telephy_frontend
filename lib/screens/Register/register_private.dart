import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:telephy/widgets/regist/regist_app_bar.dart';
// import 'package:telephy/widgets/regist/regist_bt.dart';
import 'package:telephy/widgets/regist/regist_text_field.dart';

class RegisterPrivateScreen extends StatefulWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController birthDate;
  final SingleValueDropDownController gender;
  final TextEditingController phoneNum;
  final TextEditingController medicalConditional;

  const RegisterPrivateScreen(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.birthDate,
      required this.gender,
      required this.phoneNum, 
      required this.medicalConditional
      })
      : super(key: key);

  @override
  State<RegisterPrivateScreen> createState() => _RegisterPrivateScreenState();
}

class _RegisterPrivateScreenState extends State<RegisterPrivateScreen> {
  
  Widget genderDropDown({required controller, required textFieldDecoration}) {
    return DropDownTextField(
      controller: controller,
      clearOption: true,
      // enableSearch: true,
      // dropdownColor: Colors.green,
      textFieldDecoration: textFieldDecoration,
      validator: (value) {
        if (value == null) {
          return "Required field";
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
    const double marginBtwTF = 25;

    TextStyle hintStyle({bool? isHint}) => TextStyle(
          color: isHint != null ? Colors.black : Colors.grey,
          fontSize: 16,
        );

    const OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );

    InputDecoration decorationTextField(
        {required hintText,
        required TextStyle hintStyle,
        required InputBorder inputBorder,
        Icon? suffixIcon}) {
      return InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        suffixIcon: suffixIcon,
        suffixIconColor: const Color.fromRGBO(210, 172, 255, 1),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegistTextField(
          title: "ชื่อจริง",
          hintText: "Fisrt Name",
          type: TextInputType.name,
          tfController: widget.firstName,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "นามสกุล",
          hintText: "Last Name",
          type: TextInputType.name,
          tfController: widget.lastName,
        ),
        const SizedBox(
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
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                            spreadRadius: -3,
                          )
                        ]),
                    child: TextField(
                      readOnly: true,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      controller: widget.birthDate,
                      decoration: decorationTextField(
                        hintText: "dd/mm/yyyy",
                        hintStyle: hintStyle(), // Style for hint text
                        inputBorder: inputBorder,
                        suffixIcon: const Icon(Icons.calendar_today_rounded),
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
                                      widget.birthDate.text =
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
                  height: 40,
                  width: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          spreadRadius: -3,
                        )
                      ]),
                  child: genderDropDown(
                    controller: widget.gender,
                    textFieldDecoration: decorationTextField(
                        hintText: "gender",
                        hintStyle: hintStyle(),
                        inputBorder: inputBorder),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "อีเมล",
          hintText: "E-mail",
          type: TextInputType.emailAddress,
          tfController: widget.email,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "เบอร์โทรศัพท์",
          hintText: "Phone Number",
          type: TextInputType.phone,
          tfController: widget.phoneNum,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "เงื่อนไขทางการแพทย์",
          hintText: "โรคประจำตัว ยาที่แพ้ ยาที่กินประจำ เป็นต้น",
          type: TextInputType.text,
          tfController: widget.medicalConditional,
        ),
      ],
    );
  }
}
