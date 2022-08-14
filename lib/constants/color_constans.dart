
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color customColor = Color.fromRGBO(237, 28, 36, 1);
const Color customButtonColor = Color.fromRGBO(237, 28, 36, 1);
const Color customTextColor = Color.fromRGBO(34, 50, 99, 1);
const primarySwatch = Color(0xfff8e0048);

const sliderTextColor = Color(0xfff21496C);
const sliderTextColorcontaint = Color(0xfff21496C);
const customColorIcon = Color(0xfff7D7D7D);
const customColorDivider = Color(0xfffe1e1e1);
const customColorGray = Color(0xfff7d7d7d);
const customColorbottomBar = Color(0xfffDBD8D2);

class Palette {
  static const MaterialColor kToDark =  MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
     <int, Color>{
      50:  Color.fromRGBO(64,191,255,1),//10%
      100: Color.fromRGBO(64,191,255,.9),//20%
      200: Color.fromRGBO(64,191,255,.8),//30%
      300: Color.fromRGBO(64,191,255,.7),//40%
      400: Color.fromRGBO(64,191,255,.6),//50%
      500: Color.fromRGBO(64,191,255,.5),//60%
      600: Color.fromRGBO(64,191,255,.4),//70%
      700: Color.fromRGBO(64,191,255,.3),//80%
      800: Color.fromRGBO(64,191,255,.2),//90%
      900: Color.fromRGBO(64,191,255,.1),//100%
    },
  );
}