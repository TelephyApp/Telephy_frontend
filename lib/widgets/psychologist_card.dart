import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/utils/config.dart';

class PhychologistCard extends StatelessWidget {
  const PhychologistCard({
    required this.psychologistName,
    required this.workplace,
    required this.ratePerHour,
    this.imagePath,
    this.body,
    super.key,
  });
  final String psychologistName;
  final String workplace;
  final String ratePerHour;
  final String? imagePath;
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    bool isImageIsEmpty = imagePath == null || imagePath == "";
    bool hasBody = body != null;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Config.lighterToneColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        psychologistName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.location_on,
                        size: 20,
                      ),
                      Text(workplace)
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      const FaIcon(
                        FontAwesomeIcons.stethoscope,
                        size: 17,
                      ),
                      Text("$ratePerHour บาท / 1 ชั่วโมง")
                    ],
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    isImageIsEmpty ? "assets/images/user.png" : "$imagePath",
                    width: 100,
                  ),
                ),
              )
            ],
          ),
          hasBody
              ? body!
              : const SizedBox(
                  height: 0,
                )
        ],
      ),
    );
  }
}
