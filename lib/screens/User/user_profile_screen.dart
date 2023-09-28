import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/services/google_auth_services.dart';
import 'package:telephy/services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Users? users;
  bool _isNetworkImage = false;
  final _username = TextEditingController();
  final _fullName = TextEditingController();
  final _birthDate = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _gender = TextEditingController();
  final _medicalConditional = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
    checkImageNetwork();
  }

  void signUserOut() {
    GoogleAuthService().signOut();
    Get.offNamed('login');
  }

  Future<void> getUsers() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        users = await UserService()
            .getUserByUID(FirebaseAuth.instance.currentUser!.uid);
        if (users != null) {
          _username.text = users!.username;
          _fullName.text = "${users!.firstname} ${users!.lastname}";
          _birthDate.text = users!.birthday;
          _phoneNumber.text = users!.phone;
          _gender.text = users!.gender;
          _medicalConditional.text = users!.medicalCondition!;
        }
        setState(() {});
      } else {
        // Handle case where user is not authenticated
        print("User is not authenticated");
      }
    } catch (e) {
      // Handle any errors during user data retrieval
      print("Error fetching user data: $e");
    }
  }

  void checkImageNetwork() {
    if ((users?.imagePath ?? "").startsWith('http')) {
      setState(() {
        _isNetworkImage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? backgroundImage;
    if (_isNetworkImage) {
      backgroundImage = NetworkImage(users?.imagePath ?? "");
    } else {
      backgroundImage =
          AssetImage(users?.imagePath ?? "assets/images/user.png");
    }
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: getUsers(),
            builder: (context, snapshot) {
              return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
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
                          colors: [
                            Color(0xFFCCADF9),
                            Color(0xFF86D2FC),
                            Colors.white
                          ],
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
                                  padding:
                                      EdgeInsets.only(top: 100.0, bottom: 30.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20.0),
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
                                        '${users?.email ?? ""}',
                                        style: TextStyle(
                                          fontSize: 16,
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
                                            const SizedBox(height: 16.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('ชื่อผู้ใช้',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10.0),
                                                TextField(
                                                  controller: _username,
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
                                            const SizedBox(height: 16.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('ชื่อ-นามสกุล',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10.0),
                                                TextField(
                                                  controller: _fullName,
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
                                            const SizedBox(height: 8.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text('เพศ',
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                      SizedBox(height: 10.0),
                                                      TextField(
                                                        controller: _gender,
                                                        readOnly: true,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.0,
                                                                      horizontal:
                                                                          16.0),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent), // Transparent border on focus
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent), // Transparent border when enabled
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                          'วันเดือนปีเกิด',
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                      SizedBox(height: 10.0),
                                                      TextField(
                                                        controller: _birthDate,
                                                        readOnly: true,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.0,
                                                                      horizontal:
                                                                          16.0),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent), // Transparent border on focus
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent), // Transparent border when enabled
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10.0),
                                                TextField(
                                                  controller: _phoneNumber,
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
                                            const SizedBox(height: 16.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('คำอธิบาย',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10.0),
                                                TextField(
                                                  controller:
                                                      _medicalConditional,
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
                                        backgroundImage: backgroundImage,
                                        backgroundColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
