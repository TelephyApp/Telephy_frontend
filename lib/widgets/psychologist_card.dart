import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telephy/utils/config.dart';

class PsychologistCard extends StatelessWidget {
  const PsychologistCard({
    required this.psychologistName,
    required this.workplace,
    required this.ratePerHour,
    required this.setBorderCardBottomLeft,
    required this.setBorderCardBottomRight,
    required this.setBorderCardBottomLeft,
    required this.setBorderCardBottomRight,
    this.imagePath,
    this.imageWidth,
    this.imageHeight,
    this.verticalBorderRadius,
    this.horizontalBorderRadius,
    this.imageWidth,
    this.imageHeight,
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
    bool isImageWidth = imageWidth != null;

    return Container(
      margin: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(setBorderCardBottomLeft ? 20 : 0),
            bottomRight: Radius.circular(setBorderCardBottomRight ? 20 : 0)),
        color: Config.accentColor2,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$psychologistName",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.locationCrosshairs,
                        size: 17,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('$workplace'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.stethoscope,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('$ratePerHour บาท / 1 ชั่วโมง'),
                    ],
                  ),
                ],
              ),
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
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
