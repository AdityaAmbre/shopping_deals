import 'package:flutter/material.dart';

class CustomAlertDialog {
  CustomAlertDialog();

  static void showAlertDialog({
    required BuildContext context,
    String? title,
    Widget? child,
    void Function()? onPressed,
    String? buttonText
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? "", style: const TextStyle(fontSize: 22),),
          content: SingleChildScrollView(
            child: child,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: Text(buttonText ?? "EXIT"),
            ),
          ],
        );
      },
    );
  }
}