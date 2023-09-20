import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telephy/pages/message/chat/index.dart';
import 'package:telephy/widgets/message/head_tab.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void handleBack() {
    Get.toNamed("/main");
  }

  Widget _buildUserList(DocumentSnapshot document) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildUserListItem(doc))
                .toList(),
          );
        }));
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: data['email'],
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatPage()));
        },
      );
    } else {
      return Center(child: Text("no data"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text("data"),
                pinned: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFCCADF9),
                        Color(0xFF86D1FC),
                      ],
                    ),
                  ),
                ),
                leading: IconButton(
                    onPressed: handleBack,
                    icon: SvgPicture.asset(
                        "assets/images/ionchevron-back-outline.svg")),
              ),
              SliverToBoxAdapter(
                child: HeadTab(),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Container(
                      width: 145,
                      height: 31,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 95.74,
                            height: 20,
                            child: Text(
                              "สวัสดี ทำอะไรอยู่",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Mitr',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
