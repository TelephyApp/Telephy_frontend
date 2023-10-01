import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/services/google_auth_services.dart';

class PsychProfileScreen extends StatelessWidget {
  const PsychProfileScreen({Key? key}) : super(key: key);

  void signUserOut() {
    GoogleAuthService().signOut();
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
              colors: [Color(0xFF86D2FC), Color(0xFFCCADF9)],
            ),
          ),
          child: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  onTap: signUserOut,
                  child: Image.asset('assets/images/logout.png',
                      color: Color(0xFF9747FF)),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 160.0),
                  padding: EdgeInsets.only(top: 80, bottom: 30.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Username',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'โรงพยาบาลบลาๆๆ',
                        style: TextStyle(
                          fontSize: 16,
                          //decoration: TextDecoration.underline
                        ),
                      ),

                      //start text data

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .transparent), // Transparent border when enabled
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color(0xFFDDDEFA), // Background color
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
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .transparent), // Transparent border when enabled
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color(0xFFDDDEFA), // Background color
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          contentPadding: EdgeInsets.symmetric(
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
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('อายุ',
                                          style: TextStyle(fontSize: 16)),
                                      SizedBox(height: 10.0),
                                      TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
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
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .transparent), // Transparent border when enabled
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color(0xFFDDDEFA), // Background color
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
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .transparent), // Transparent border when enabled
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color(0xFFDDDEFA), // Background color
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Positioned(
                top: 80,
                left: (MediaQuery.of(context).size.width / 2) - 80,
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.black,
                ),
              ), //profile pic
            ]),
          ),
        ),
      ),
    );
  }
}
