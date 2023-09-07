import 'package:flutter/material.dart';
import 'package:telephy/widgets/regist_app_bar.dart';
import 'package:telephy/widgets/regist_bt.dart';
import 'package:telephy/widgets/regist_text_field.dart';

class RegisterPrivateScreen extends StatefulWidget {
  const RegisterPrivateScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPrivateScreen> createState() => _RegisterPrivateScreenState();
}

class _RegisterPrivateScreenState extends State<RegisterPrivateScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedGender;
  final List<String> genderOptions = ['ชาย', 'หญิง', 'อื่นๆ'];

  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    const double marginBtwTF = 25;

    return Scaffold(
      appBar: const RegisterAppBar(title: "ข้อมูลส่วนตัว"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 38,
                color: Colors.black,
                margin: const EdgeInsets.only(bottom: 30),
              ),
              const RegistTextField(
                title: "ชื่อจริง", 
                hintText: "Fisrt Name",
                type: TextInputType.name,
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              const RegistTextField(
                title: "นามสกุล", 
                hintText: "Last Name",
                type: TextInputType.name,
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       flex: 2,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const SizedBox(
              //               height: marginBtwTF,
              //               child: Text("วันเกิด", style: labelxStyle)),
              //           InkWell(
              //             onTap: () {
              //               _selectDate(context);
              //             },
              //             child: InputDecorator(
              //               decoration: inputDec(
              //                   "dd/mm/yyyy",
              //                   suffixIcon: Icons.date_range_rounded),
              //               child: Row(
              //                 children: <Widget>[
              //                   Text(
              //                     "${selectedDate.toLocal()}"
              //                         .split(' ')[0],
              //                     style: const TextStyle(
              //                       fontSize: 16,
              //                       color: Colors.black,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(width: 25,),
              //     Expanded(
              //       flex: 1,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const SizedBox(
              //             height: marginBtwTF,
              //             child: Text("เพศ", style: labelxStyle),
              //           ),
              //           DropdownButtonFormField<String>(
              //             value: selectedGender,
              //             onChanged: (String? newValue) {
              //               setState(() {
              //                 selectedGender = newValue;
              //               });
              //             },
              //             items: genderOptions.map((String gender) {
              //               return DropdownMenuItem<String>(
              //                 value: gender,
              //                 child: Text(gender),
              //               );
              //             }).toList(),
              //             decoration: inputDec("Gender"),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: marginBtwTF,
              ),
              const RegistTextField(
                title: "อีเมล", 
                hintText: "E-mail",
                type: TextInputType.emailAddress, 
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              const RegistTextField(
                title: "เบอร์โทรศัพท์", 
                hintText: "Phone Number",
                type: TextInputType.phone,  
              ),
              const Center(
                child: RegistBT(titleBT: "ถัดไป"),
              )
            ],
          ),
        ),
      ),
    );
  }
}




