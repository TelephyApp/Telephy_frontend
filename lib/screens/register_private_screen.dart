import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:telephy/widgets/regist/regist_app_bar.dart';
// import 'package:telephy/widgets/regist/regist_bt.dart';
import 'package:telephy/widgets/regist/regist_text_field.dart';

class RegisterPrivateScreen extends StatefulWidget {
  const RegisterPrivateScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPrivateScreen> createState() => _RegisterPrivateScreenState();
}

class _RegisterPrivateScreenState extends State<RegisterPrivateScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _birthDate = TextEditingController();
  final SingleValueDropDownController _gender = SingleValueDropDownController();
  final TextEditingController _phoneNum = TextEditingController();

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
          tfController: _firstName,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "นามสกุล",
          hintText: "Last Name",
          type: TextInputType.name,
          tfController: _lastName,
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
                      style: hintStyle(isHint: false), // Style for entered text
                      controller: _birthDate,
                      decoration: decorationTextField(
                        hintText: "dd/mm/yyyy",
                        hintStyle: hintStyle(), // Style for hint text
                        inputBorder: inputBorder,
                        suffixIcon: const Icon(Icons.calendar_today_rounded),
                      ),
                      onTap: () async {
                        DateTime? datePick = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );

                        if (datePick != null) {
                          String dateText =
                              DateFormat('dd-MM-yyyy').format(datePick);
                          setState(() {
                            _birthDate.text = dateText;
                          });
                        }
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
                  child: GenderDropDown(
                    controller: _gender,
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
          tfController: _email,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "เบอร์โทรศัพท์",
          hintText: "Phone Number",
          type: TextInputType.phone,
          tfController: _phoneNum,
        ),
      ],
    );
  }
}

class GenderDropDown extends StatelessWidget {
  const GenderDropDown({
    super.key,
    required this.controller,
    required this.textFieldDecoration,
  });

  final SingleValueDropDownController controller;
  final InputDecoration textFieldDecoration;

  @override
  Widget build(BuildContext context) {
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
}
