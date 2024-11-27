import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle HeadlineTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle lightTextFieldStyle() {
    return TextStyle(
        color: Colors.black54,
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle SemiBoldTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle LightSemiBoldTextFieldStyle() {
    return TextStyle(
        color: Colors.black54,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }
}
