import 'package:flutter/material.dart';
import 'dart:ui';

class AppWidgetSize {
// Default properties
  static double uiWidthpx = 375; // Minumum screen width Ratio as per the UI/UX
  static double uiHeightpx =
      667; // Minumum screen height  Ratio as per the UI/UX
  static double scaleWidth = 1;

// Initial dimension size
  static double bodyPadding = 16;
  static double dimen_1 = 1;
  static double dimen_2 = 2;
  static double dimen_3 = 3;
  static double dimen_4 = 4;
  static double dimen_5 = 5;
  static double dimen_6 = 6;
  static double dimen_7 = 7;
  static double dimen_8 = 8;
  static double dimen_9 = 9;
  static double dimen_10 = 10;
  static double dimen_11 = 11;
  static double dimen_12 = 12;
  static double dimen_13 = 13;
  static double dimen_14 = 14;
  static double dimen_15 = 15;
  static double dimen_16 = 16;
  static double dimen_17 = 17;
  static double dimen_18 = 18;
  static double dimen_19 = 19;
  static double dimen_20 = 20;
  static double dimen_24 = 24;
  static double dimen_25 = 25;
  static double dimen_30 = 30;
  static double dimen_32 = 32;
  static double dimen_35 = 35;
  static double dimen_40 = 40;
  static double dimen_45 = 45;
  static double dimen_48 = 48;
  static double dimen_50 = 50;
  static double dimen_60 = 60;
  static double dimen_70 = 70;
  static double dimen_80 = 80;
  static double dimen_90 = 90;
  static double dimen_100 = 100;
  static double dimen_110 = 110;
  static double dimen_120 = 120;
  static double dimen_130 = 130;
  static double dimen_140 = 140;
  static double dimen_150 = 150;
  static double dimen_200 = 200;
  static double dimen_250 = 250;

// FONT SIZE CONFIG

  static double headline6Size = 16;
  static double captionSize = 14;
  static double headline5Size = 16;
  static double subtitle1Size = 14;
  static double bodyText2Size = 12;
  static double bodyText1Size = 10;
  static double headline4Size = 16;
  static double headline3Size = 14;
  static double headline2Size = 12;
  static double headline1Size = 10;
  static double fontSize15 = 15;
  static double fontSize24 = 24;
  static double fontSize8 = 8;

  static double inputSize = 16;
  static double inputLabelSize = 14;
  static double buttonTextSize = 14;

  static double bigTextSize = 18;
  static double textSize = 16;
  static double smallTextSize = 13;

  static const double buttonHeight = 45;
  static BorderRadius buttonBorderRadius = BorderRadius.circular(7);

  static double smallLoaderWidgetSize = 60;

  static double safeAreaSpace = 0;

// SCREEN SIZE CONFIG
  static initSetSize() async {
    final double screenWidth = MediaQueryData.fromWindow(window).size.width;
    if (screenWidth != 0.0) {
      scaleWidth = screenWidth / uiWidthpx;

      headline6Size = headline6Size * scaleWidth;
      captionSize = captionSize * scaleWidth;
      headline5Size = headline5Size * scaleWidth;
      subtitle1Size = subtitle1Size * scaleWidth;
      bodyText2Size = bodyText2Size * scaleWidth;
      bodyText1Size = bodyText1Size * scaleWidth;
      headline4Size = headline4Size * scaleWidth;
      headline3Size = headline3Size * scaleWidth;
      headline2Size = headline2Size * scaleWidth;
      headline1Size = headline1Size * scaleWidth;
      bigTextSize = bigTextSize * scaleWidth;
      textSize = textSize * scaleWidth;
      smallTextSize = smallTextSize * scaleWidth;

      fontSize15 = fontSize15 * scaleWidth;
      fontSize24 = fontSize24 * scaleWidth;
      fontSize8 = fontSize8 * scaleWidth;

      inputSize = inputSize * scaleWidth;
      inputLabelSize = inputLabelSize * scaleWidth;
      buttonTextSize = buttonTextSize * scaleWidth;

      bigTextSize = bigTextSize * scaleWidth;
      textSize = textSize * scaleWidth;
      smallTextSize = smallTextSize * scaleWidth;

      bodyPadding = bodyPadding * scaleWidth;
      dimen_1 = 1 * scaleWidth;
      dimen_2 = 2 * scaleWidth;
      dimen_3 = 3 * scaleWidth;
      dimen_4 = 4 * scaleWidth;
      dimen_5 = 5 * scaleWidth;
      dimen_6 = 6 * scaleWidth;
      dimen_7 = 7 * scaleWidth;
      dimen_8 = 8 * scaleWidth;
      dimen_9 = 9 * scaleWidth;
      dimen_10 = 10 * scaleWidth;
      dimen_11 = 11 * scaleWidth;
      dimen_12 = 12 * scaleWidth;
      dimen_13 = 13 * scaleWidth;
      dimen_14 = 14 * scaleWidth;
      dimen_15 = 15 * scaleWidth;
      dimen_16 = 16 * scaleWidth;
      dimen_17 = 17 * scaleWidth;
      dimen_18 = 18 * scaleWidth;
      dimen_19 = 19 * scaleWidth;
      dimen_20 = 20 * scaleWidth;
      dimen_24 = 24 * scaleWidth;
      dimen_25 = 25 * scaleWidth;
      dimen_30 = 30 * scaleWidth;
      dimen_32 = 32 * scaleWidth;
      dimen_35 = 35 * scaleWidth;
      dimen_40 = 40 * scaleWidth;
      dimen_45 = 45 * scaleWidth;
      dimen_48 = 48 * scaleWidth;
      dimen_50 = 50 * scaleWidth;
      dimen_60 = 60 * scaleWidth;
      dimen_70 = 70 * scaleWidth;
      dimen_80 = 80 * scaleWidth;
      dimen_90 = 90 * scaleWidth;
      dimen_100 = 100 * scaleWidth;
      dimen_110 = 110 * scaleWidth;
      dimen_120 = 120 * scaleWidth;
      dimen_130 = 130 * scaleWidth;
      dimen_140 = 140 * scaleWidth;
      dimen_150 = 150 * scaleWidth;
      dimen_200 = 200 * scaleWidth;
      dimen_250 = 250 * scaleWidth;
      smallLoaderWidgetSize = smallLoaderWidgetSize * scaleWidth;
    }
  }

  static double getSize(double size) {
    return size * scaleWidth;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return (screenSize(context).height - safeAreaSpace) / dividedBy;
  }

  static double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  static double fullWidth(BuildContext context) {
    return screenWidth(context, dividedBy: 1);
  }

  static double halfWidth(BuildContext context) {
    return screenWidth(context, dividedBy: 2);
  }

  static double fullHeight(BuildContext context) {
    return screenHeight(context, dividedBy: 1);
  }

  static double halfHeight(BuildContext context) {
    return screenHeight(context, dividedBy: 2);
  }

  static double quaterHeight(BuildContext context) {
    return screenHeight(context, dividedBy: 3);
  }

  static double getSizeforverySmallScreen() {
    return 320.0;
  }

  static double getSizeforSmallScreen() {
    return 360.0;
  }

  static double getSizeforlargeScreen() {
    return 375.0;
  }

  static double getSizeforverylargeScreen() {
    return 414.0;
  }

  //sample devices iPhone SE,iPhone 5s,iPhone 5, iPhone 5c,nexus one,nexus S
  static bool verysmallScreen(BuildContext context) {
    return screenWidth(context) == getSizeforverySmallScreen();
  }

  //sample device motto E5,nexus 5
  static bool smallScreen(BuildContext context) {
    return screenWidth(context) == getSizeforSmallScreen();
  }

  //sample device iPhone 6s,iPhone 7,nexus 6P,pixel,pixel 2,iPhone 11 pro
  static bool largeScreen(BuildContext context) {
    return screenWidth(context) == getSizeforlargeScreen();
  }

  //sample device iPhone 11 pro max nexus 2
  static bool verylargeScreen(BuildContext context) {
    return screenWidth(context) == getSizeforverylargeScreen();
  }

  static bool extralargeScreen(BuildContext context) {
    return screenWidth(context) > 600;
  }

  static void setSafeAreaSpace(BuildContext context) {}
}
