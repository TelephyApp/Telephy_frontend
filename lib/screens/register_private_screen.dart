import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
// import 'package:telephy/widgets/regist/regist_app_bar.dart';
// import 'package:telephy/widgets/regist/regist_bt.dart';
import 'package:telephy/widgets/regist/regist_text_field.dart';

class RegisterPrivateScreen extends StatefulWidget {
  const RegisterPrivateScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPrivateScreen> createState() => _RegisterPrivateScreenState();
}

class _RegisterPrivateScreenState extends State<RegisterPrivateScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final SingleValueDropDownController gender = SingleValueDropDownController();
  final TextEditingController phoneNum = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    const double marginBtwTF = 25;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegistTextField(
          title: "ชื่อจริง",
          hintText: "Fisrt Name",
          type: TextInputType.name,
          tfController: firstName,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "นามสกุล",
          hintText: "Last Name",
          type: TextInputType.name,
          tfController: lastName,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const Placeholder(fallbackHeight: 40,),
            // const SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // date picker left here
                const Text(
                  "เพศ", 
                  style: TextStyle(),
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
                    ]
                  ),
                  child: genderDropDown(controller: gender),
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
          tfController: email,
        ),
        const SizedBox(
          height: marginBtwTF,
        ),
        RegistTextField(
          title: "เบอร์โทรศัพท์",
          hintText: "Phone Number",
          type: TextInputType.phone,
          tfController: phoneNum,
        ),
        // Center(
        //   child: RegistBT(titleBT: "ถัดไป"),
        // )
      ],
    );
  }
}

class genderDropDown extends StatelessWidget {
  const genderDropDown({
    super.key,
    required this.controller,
  });

  final SingleValueDropDownController controller;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      controller: controller,
      clearOption: true,
      // enableSearch: true,
      // dropdownColor: Colors.green,
      textFieldDecoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: "Gender",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
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
        DropDownValueModel(name: 'อื่นๆ', value: "อื่นๆ"),
      ],
      onChanged: (val) {},
    );
  }
}
