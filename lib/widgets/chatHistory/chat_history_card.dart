import 'package:flutter/material.dart';
import 'package:telephy/utils/config.dart';

class ChatCard extends StatelessWidget {
  final String username;
  final String lastMessage;
  final int numberUnseenMessage;
  final String timeLastMessage;

  const ChatCard({
    super.key,
    required this.username,
    required this.lastMessage,
    required this.numberUnseenMessage,
    required this.timeLastMessage,
  });

  @override
  Widget build(BuildContext context) {
    const double marginBtwMedium = 20;
    const double marginBtwSmall = 5;

    return Card(
      elevation: 2, // Add elevation for the drop shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Set the radius to 12
      ),
      color: Config.baseColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            marginBtwMedium, // Left
            15.0, // Top
            marginBtwMedium, // Right
            15.0, // Bottom
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: 'Mitr',
                      ),
                    ),
                    const SizedBox(height: marginBtwSmall),
                    Text(
                      lastMessage,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Mitr',
                        color: Color(0xFF717C8E),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: marginBtwMedium),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    timeLastMessage,
                    style: Config.normalFont,
                  ),
                  const SizedBox(height: 15),
                  numberUnseenMessage > 0
                      ? CircleAvatar(
                          backgroundColor: Config.accentColor2,
                          radius: 10,
                          child: Text(
                            numberUnseenMessage.toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                fontFamily: 'Mitr',
                                color: Color(0xFFFFFFFF)),
                          ),
                        )
                      : const SizedBox(), // Empty SizedBox if no unseen messages
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
