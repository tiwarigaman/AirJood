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

  static tostMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.black54, fontSize: 18);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          duration: const Duration(seconds: 2),
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(7),
          backgroundGradient: LinearGradient(colors: [
            Colors.blueGrey.shade900,
            Colors.blueGrey.shade700,
            Colors.blueGrey.shade500,
            Colors.blueGrey.shade200,
          ]),
          //backgroundColor: Colors.black54,
        )..show(context));
  }
}
