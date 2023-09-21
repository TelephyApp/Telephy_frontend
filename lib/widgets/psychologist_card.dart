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
    this.imagePath,
    this.imageWidth,
    this.imageHeight,
    this.verticalBorderRadius,
    this.horizontalBorderRadius,
    this.backgroundImage,
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
  final String? backgroundImage;
  final bool setBorderCardBottomLeft;
  final bool setBorderCardBottomRight;

  @override
  Widget build(BuildContext context) {
    bool isImageIsEmpty = imagePath == null || imagePath == "";
    bool isImageWidth = imageWidth != null;
    bool isImageBackgroundIsEmpty =
        backgroundImage == null || backgroundImage == "";

    return Container(
<<<<<<< HEAD
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
=======
      height: 150,
>>>>>>> 95c1daa9d2be5831a2c1a13a95b74bb27adf4d62
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(setBorderCardBottomLeft ? 20 : 0),
            bottomRight: Radius.circular(setBorderCardBottomRight ? 20 : 0)),
        color: isImageBackgroundIsEmpty ? Config.lighterToneColor : null,
        image: isImageBackgroundIsEmpty
            ? null
            : DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
<<<<<<< HEAD
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
=======
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
>>>>>>> 95c1daa9d2be5831a2c1a13a95b74bb27adf4d62
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
<<<<<<< HEAD
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
=======
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  isImageIsEmpty ? "assets/images/user.png" : "$imagePath",
                  width: isImageWidth ? imageWidth : 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
>>>>>>> 95c1daa9d2be5831a2c1a13a95b74bb27adf4d62
      ),
    );
  }
}
