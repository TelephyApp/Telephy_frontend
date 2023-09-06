import 'package:flutter/material.dart';

class RegisterPrivateScreen extends StatelessWidget {
  const RegisterPrivateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double marginBtwTF = 25;
    // final TextEditingController usernameController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();
    // final TextEditingController cfPasswordController = TextEditingController();

    const boderInputStyle = OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );

    InputDecoration inputDec(String hintText, {IconData? suffixIcon}) {
      return InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: boderInputStyle,
        enabledBorder: boderInputStyle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        suffixIcon: Icon(suffixIcon),
      );
    }

    const labelxStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    Container nextButton = Container(
      margin: const EdgeInsets.only(top: 45),
      width: 240,
      height: 35,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color.fromRGBO(134, 210, 252, 1), Color.fromRGBO(204, 173, 249, 1)]
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
        ),
        onPressed: () {}, 
        child: const Text("ถัดไป")),
    );

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(124, 129, 255, 1), Color.fromRGBO(174, 178, 253, 1), Color.fromRGBO(215, 216, 255, 0)]),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          const Text("ข้อมูลส่วนตัว", style: TextStyle(fontSize: 28),),
          const SizedBox(width: 30,)
        ],
      )),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 38,
                  color: Colors.black,
                  margin: const EdgeInsets.only(bottom: 30)), // state container
              const SizedBox(
                  height: marginBtwTF, child: Text("ชื่อจริง", style: labelxStyle)),
              TextField(
                // controller: usernameController,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: inputDec("First Name"),
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              const SizedBox(
                  height: marginBtwTF, child: Text("นามสกุล", style: labelxStyle)),
              TextField(
                // controller: passwordController,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: inputDec("Last Name"),
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: marginBtwTF, child: Text("วันเกิด", style: labelxStyle)),
                      SizedBox(
                        width: 180,
                        child: TextField(
                          // controller: cfPasswordController,
                          keyboardType: TextInputType.datetime,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: inputDec("dd/mm/yyyy", suffixIcon: Icons.date_range_rounded),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    //! Not done yet, need to replace with dropdown
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: marginBtwTF, child: Text("เพศ", style: labelxStyle)),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          // controller: cfPasswordController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: inputDec("gender", suffixIcon: Icons.arrow_drop_down_rounded),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              const SizedBox(
                  height: marginBtwTF, child: Text("อีเมล", style: labelxStyle)),
              TextField(
                // controller: cfPasswordController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: inputDec("Email"),
              ),
              const SizedBox(
                height: marginBtwTF,
              ),
              const SizedBox(
                  height: marginBtwTF, child: Text("เบอร์โทรศัพท์", style: labelxStyle)),
              TextField(
                // controller: cfPasswordController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: inputDec("Phone Number"),
              ),
              Center(
                child: nextButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}