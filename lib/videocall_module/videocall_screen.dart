import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:telephy/videocall_module/controller.dart';

class VideoCallPage extends GetView<VideoController> {
  const VideoCallPage({Key? key}) : super(key: key);

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
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 690,
                    child: Container(
                      width: 393,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(400, 200),
                        ),
                        color: Color.fromRGBO(221, 222, 252, 0.6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    right: 30,
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "${controller.state.callTime.value}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 36,
                    left: 30,
                    top: 675,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        Color(0XFFD2ACFF),
                                        Color(0XFFB2DDFD)
                                      ]),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: controller.isMicrophoneOn.value
                                      ? FaIcon(FontAwesomeIcons.microphone)
                                      : FaIcon(
                                          FontAwesomeIcons.microphoneSlash),
                                  onPressed: () {
                                    controller.isMicrophoneOn.value =
                                        !controller.isMicrophoneOn.value;
                                    if (controller.isMicrophoneOn.value) {
                                      print("Microphone is on");
                                    } else {
                                      print("Microphone is off");
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: (MediaQuery.of(context).size.width - 70) / 2,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    color:
                                        const Color.fromRGBO(230, 71, 71, 1.0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: FaIcon(FontAwesomeIcons.phoneSlash),
                                  onPressed: () {
                                    print("endcall");
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 36,
                    right: 30,
                    top: 675,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        Color(0XFFD2ACFF),
                                        Color(0XFFB2DDFD)
                                      ]),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: controller.isVideoOn.value
                                      ? FaIcon(FontAwesomeIcons.video)
                                      : FaIcon(FontAwesomeIcons.videoSlash),
                                  onPressed: () {
                                    controller.isVideoOn.value =
                                        !controller.isVideoOn.value;
                                    if (controller.isVideoOn.value) {
                                      print("Video is on");
                                    } else {
                                      print("Video is off");
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
