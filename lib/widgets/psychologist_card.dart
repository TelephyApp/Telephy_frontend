import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/utils/config.dart';

class PhychologistCard extends StatelessWidget {
  const PhychologistCard({
    required this.psychologistName,
    required this.workplace,
    required this.ratePerHour,
    required this.setBorderCardBottomLeft,
    required this.setBorderCardBottomRight,
    this.imagePath,
    this.imageWidth,
    this.imageHeight,
    this.verticalBorderRadius,
    this.horizontalBorderRadius,
    super.key,
  });

  final String psychologistName;
  final String workplace;
  final String ratePerHour;
  final String? imagePath;
  final double? imageWidth;
  final double? imageHeight;
  final bool? verticalBorderRadius;
  final bool? horizontalBorderRadius;
  final bool setBorderCardBottomLeft;
  final bool setBorderCardBottomRight;

  @override
  Widget build(BuildContext context) {
    bool isImageIsEmpty = imagePath == null || imagePath == "";
    bool isImageHeight = imageHeight != null;
    bool isImageWidth = imageWidth != null;

    return Container(
      margin: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(setBorderCardBottomLeft ? 20 : 0),
            bottomRight: Radius.circular(setBorderCardBottomRight ? 20 : 0)),
        color: Config.mainColor1,
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
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "$psychologistName",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    isImageIsEmpty ? "assets/images/erum.png" : "$imagePath",
                    width: isImageWidth ? imageWidth : 120,
                    // height: isImageHeight ? imageHeight : 150,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
