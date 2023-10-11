import 'package:agora_uikit/agora_uikit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telephy/model/call.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});
  // final Call call;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: '0a79f34a1c954382aa7ae740ca76af20',
      channelName: "test channel",
    ),
  );

  Future<void> _initializeAgora() async {
    await _client.initialize();
  }

  @override
  void initState() {
    _initializeAgora();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: _client,
                layoutType: Layout.oneToOne,
              ),
              AgoraVideoButtons(client: _client)
            ],
          ),
        ),
      ),
    );
  }
}
