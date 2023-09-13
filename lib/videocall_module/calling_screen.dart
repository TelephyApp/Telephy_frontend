import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:telephy/videocall_module/controller.dart';

class CallingPage extends GetView<VideoController> {
  const CallingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Obx(() => Container(
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/docpic.png"),
                          filterQuality: FilterQuality.low,
                          opacity: 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 30,
                    right: 30,
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "${controller.state.to_name.value}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 70,
                        //   height: 100,
                        //   margin: EdgeInsets.only(top: 150),
                        //   child: Image.asset(
                        //       "${controller.state.to_avatar.value}"),
                        // ),
                        // Text(
                        //   "${controller.state.to_name.value}",
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 50,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    color: Colors.red),
                                child: IconButton(
                                  iconSize: 40,
                                  color: Colors.white,
                                  icon: FaIcon(FontAwesomeIcons.phoneSlash),
                                  onPressed: () {
                                    print("decline");
                                  },
                                ),
                              ),
                            ),
                            Container(
                              child: Text("Decline",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 80,
                      right: 50,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      color: const Color.fromARGB(
                                          255, 43, 219, 49)),
                                  child: IconButton(
                                    iconSize: 40,
                                    color: Colors.white,
                                    icon: FaIcon(FontAwesomeIcons.phone),
                                    onPressed: () {
                                      print("accept");
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
