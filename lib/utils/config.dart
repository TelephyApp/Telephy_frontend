//set constant config here
import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  //width and height initialization
  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heightSize {
    return screenHeight;
  }

  //define spacing height
  static const spaceSmall = SizedBox(
    height: 25,
  );
  static final spaceMedium = SizedBox(
    height: screenHeight! * 0.05,
  );
  static final spaceBig = SizedBox(
    height: screenHeight! * 0.08,
  );

  //textform field border
  static const outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
      ));
  static const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.red,
      ));

  static const normalFont = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Mitr',
    fontWeight: FontWeight.w400,
  );

  static const smallFont = TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontFamily: 'Mitr',
    fontWeight: FontWeight.w400,
  );

  static const mainColor1 = Color(0xFFB2B4FE);
  static const mainColor2 = Color(0xFFB2DDFD);
  static const lighterToneColor = Color(0xFFDDDEFC);
  static const accentColor1 = Color(0xFFE4DAD1);
  static const accentColor2 = Color(0xFFD2ACFF);
  static const baseColor = Color(0xFFFEFEFE);
  static const darkerToneColor = Color(0xFF0F1B2D);
  static const backgroundColor = Color(0xFFDDDEFA);

  static const loadingWidget = const CircularProgressIndicator(
    color: mainColor1,
    backgroundColor: baseColor,
  );
}
