import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.black54, fontSize: 18);
  }

  static void flushBarErrorMessage(String message, BuildContext context,Color backgroundColor) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          messageColor: Colors.white,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(7),
          backgroundColor: backgroundColor,
        )..show(context));
  }
}
