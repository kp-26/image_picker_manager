import 'package:flutter/material.dart';

/*
w100 Thin, the least thick
w200 Extra-light
w300 Light
w400 Normal / regular / plain
w500 Medium
w600 Semi-bold
w700 Bold
w800 Extra-bold
w900 Black, the most thick
* */


enum MyFont { light, regular, medium, semiBold, bold }

extension ExtMyFont on MyFont {
  String get family {
    return "WorkSans";
  }

  FontWeight get weight {
    switch (this) {
      case MyFont.light:
        return FontWeight.w300;
      case MyFont.regular:
        return FontWeight.normal;
      case MyFont.medium:
        return FontWeight.w500;
      case MyFont.semiBold:
        return FontWeight.w600;
      case MyFont.bold:
        return FontWeight.w700;
    }
  }
}