import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/services/google_auth_services.dart';
import 'package:telephy/services/psychologist_service.dart';

class PsychProfileScreen extends StatefulWidget {
  const PsychProfileScreen({Key? key}) : super(key: key);

  @override
  State<PsychProfileScreen> createState() => _PsychProfileScreenState();
}

class _PsychProfileScreenState extends State<PsychProfileScreen> {
  Psychologist? psychologists;
  bool _isNetworkImage = false;
  final _fullName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _gender = TextEditingController();
  final _age = TextEditingController();
  final _detail = TextEditingController();
  final _hospital = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPsychs();
    checkImageNetwork();
  }

  void signUserOut() {
    GoogleAuthService().signOut();
    Get.offNamed('login');
  }

  Future<void> getPsychs() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        psychologists = await PsychologistService()
            .getPsychologistByUID(FirebaseAuth.instance.currentUser!.uid);
        if (psychologists != null) {
          _fullName.text =
              "${psychologists!.firstname} ${psychologists!.lastname}";
          _phoneNumber.text = psychologists!.phone;
          _gender.text = psychologists!.gender;
          _age.text = psychologists!.age.toString();
          _detail.text = psychologists!.detail;
          _hospital.text = psychologists!.hospital;
        }
        setState(() {});
      } else {
        print("Psychologist is not authenticated");
      }
    } catch (error) {
      print("Error fetching psychologist data: $error");
    }
  }

  void checkImageNetwork() {
    if ((psychologists?.imagePath ?? "").startsWith("http")) {
      setState(() {
        _isNetworkImage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? backgroundImage;
    if (_isNetworkImage) {
      backgroundImage = NetworkImage(psychologists?.imagePath ?? "");
    } else {
      backgroundImage =
          AssetImage(psychologists?.imagePath ?? "assets/images/psy.png");
    }
    print(backgroundImage);
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: getPsychs(),
          builder: (context, snapshot) {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("psychologists")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  while (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
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
                                  '${snapshot.data?['firstname'] ?? ""} ${snapshot.data?['lastname'] ?? ""}',
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  '${psychologists?.hospital ?? ""}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    //decoration: TextDecoration.underline
                                  ),
                                ),

                                //start text data

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // ของหมอจะไม่มี username แสดง

                                      // const SizedBox(height: 16.0),
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     const Text('ชื่อผู้ใช้',
                                      //         style: TextStyle(fontSize: 16)),
                                      //     SizedBox(height: 10.0),
                                      //     TextField(
                                      //       decoration: InputDecoration(
                                      //         contentPadding:
                                      //             EdgeInsets.symmetric(
                                      //                 vertical: 8.0),
                                      //         focusedBorder: OutlineInputBorder(
                                      //           borderSide: BorderSide(
                                      //               color: Colors
                                      //                   .transparent), // Transparent border on focus
                                      //           borderRadius:
                                      //               BorderRadius.circular(20.0),
                                      //         ),
                                      //         enabledBorder: OutlineInputBorder(
                                      //           borderSide: BorderSide(
                                      //               color: Colors
                                      //                   .transparent), // Transparent border when enabled
                                      //           borderRadius:
                                      //               BorderRadius.circular(20.0),
                                      //         ),
                                      //         filled: true,
                                      //         fillColor: Color(
                                      //             0xFFDDDEFA), // Background color
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      const SizedBox(height: 16.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('ชื่อ-นามสกุล',
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 10.0),
                                          TextField(
                                            controller: _fullName,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16.0),
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
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10.0),
                                                TextField(
                                                  controller: _gender,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.0,
                                                            horizontal: 16.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent), // Transparent border on focus
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent), // Transparent border when enabled
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
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
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10.0),
                                                TextField(
                                                  controller: _age,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.0,
                                                            horizontal: 16.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent), // Transparent border on focus
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent), // Transparent border when enabled
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('เบอร์โทร',
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 10.0),
                                          TextField(
                                            controller: _phoneNumber,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16.0),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('คำอธิบาย',
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 10.0),
                                          TextField(
                                            controller: _detail,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16.0),
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
                        Positioned(
                          top: 80,
                          left: (MediaQuery.of(context).size.width / 2) - 80,
                          child: CircleAvatar(
                            radius: 80.0,
                            backgroundImage: backgroundImage,
                            backgroundColor: Colors.white,
                          ),
                        ), //profile pic
                      ]),
                    ),
                  );
                });
          }),
    ));
  }
}
