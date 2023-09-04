import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhychologistCard extends StatelessWidget {
  const PhychologistCard({
    required this.psychologistName,
    required this.workplace,
    required this.ratePerHour,
    this.imagePath,
    super.key,
  });
  final String psychologistName;
  final String workplace;
  final String ratePerHour;
  final String? imagePath;
  @override
  Widget build(BuildContext context) {
    bool isImageIsEmpty = imagePath == null || imagePath == "";

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$psychologistName",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.location_on,
                    size: 20,
                  ),
                  Text("$workplace")
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  FaIcon(
                    FontAwesomeIcons.stethoscope,
                    size: 17,
                  ),
                  Text("$ratePerHour บาท / 1 ชั่วโมง")
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
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
    );
  }
}
