import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Get.offNamed('login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFFCCADF9), Color(0xFF86D2FC), Colors.white],
            ),
          ),
          child: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Stack(
                children: [
                  //logout bt
                  Positioned(
                    top: 40,
                    right: 20,
                    child: GestureDetector(
                      onTap: signUserOut,
                      child: Image.asset(
                        'assets/images/logout.png',
                        width: 20,
                        height: 20,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(top: 160.0),
                      padding: EdgeInsets.only(top: 100.0, bottom: 30.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                            'สมหญิง สีสีสี',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Somying12@gmail.com',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),

                          //start text data

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('ชื่อผู้ใช้',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 10.0),
                                    TextField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .transparent), // Transparent border on focus
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .transparent), // Transparent border when enabled
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        filled: true,
                                        fillColor: Color(
                                            0xFFDDDEFA), // Background color
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('ชื่อ-นามสกุล',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 10.0),
                                    TextField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .transparent), // Transparent border on focus
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .transparent), // Transparent border when enabled
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        filled: true,
                                        fillColor: Color(
                                            0xFFDDDEFA), // Background color
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('เพศ',
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 10.0),
                                          TextField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .transparent), // Transparent border on focus
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .transparent), // Transparent border when enabled
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              filled: true,
                                              fillColor: Color(
                                                  0xFFDDDEFA), // Background color
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            50), // Add spacing between "Sex" and "Birthday"
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('วันเดือนปีเกิด',
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 10.0),
                                          TextField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .transparent), // Transparent border on focus
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .transparent), // Transparent border when enabled
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              filled: true,
                                              fillColor: Color(
                                                  0xFFDDDEFA), // Background color
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('เบอร์โทร',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 10.0),
                                    TextField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .transparent), // Transparent border on focus
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .transparent), // Transparent border when enabled
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        filled: true,
                                        fillColor: Color(
                                            0xFFDDDEFA), // Background color
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('คำอธิบาย',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 10.0),
                                    TextField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .transparent), // Transparent border on focus
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .transparent), // Transparent border when enabled
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        filled: true,
                                        fillColor: Color(
                                            0xFFDDDEFA), // Background color
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  //profile pic
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80.0,
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
