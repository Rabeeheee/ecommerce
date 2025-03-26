import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CustomToast {
  void showCustomToast(String message, Color backgroundColor) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER, // Shows in center for better visibility
    backgroundColor: backgroundColor, // Dark semi-transparent
    textColor: Colors.white,
    fontSize: 16.0,
    webPosition: "center", // Ensures correct position on web
    webBgColor: "linear-gradient(to right, #ff5f6d, #ffc371)", // Gradient for web
  );
}

}

