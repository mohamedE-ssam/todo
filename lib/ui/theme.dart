import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    scaffoldBackgroundColor: white,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: white,
    scaffoldBackgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

class Styles {
  TextStyle get style_1 => GoogleFonts.lato(
          textStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ));
  TextStyle get style_2 => GoogleFonts.lato(
          textStyle: const TextStyle(
        fontSize: 15,
      ));
  TextStyle get style_3 => GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.w500, color: white));
  TextStyle get style_4 => GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 18, color: white, fontWeight: FontWeight.w400));
  TextStyle get style_5 => GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
}
