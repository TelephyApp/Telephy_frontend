import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:telephy/pages/message/message_page.dart';
import 'package:time_remaining/time_remaining.dart';
import 'package:telephy/utils/config.dart';

class VideoCallScreen extends StatefulWidget {
  final bool inTime;
  final bool isPsy;
  final Duration timeDiff;
  const VideoCallScreen(
      {super.key,
      required this.inTime,
      required this.isPsy,
      required this.timeDiff});

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
    if (!widget.inTime) {
      Navigator.pop(context);
    }
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
              AgoraVideoButtons(client: _client),
              Positioned(
                bottom: 20,
                left: 30,
                right: 30,
                child: Column(
                  children: [
                    Offstage(
                      offstage: !isPsy,
                      child: TimeRemaining(
                        style: Config.normalFont,
                        formatter: (duration) {
                          return "${duration.inMinutes.remainder(60)}m:${duration.inSeconds.remainder(60)}s left";
                        },
                        duration:
                            Duration(seconds: 3600 - widget.timeDiff.inSeconds),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
