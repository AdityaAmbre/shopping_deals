import 'package:flutter/material.dart';

class Logger {
  Logger();

  static logTitle(String tag, String msg) {
    debugPrint("------------------------------Start $tag------------------------------");
    debugPrint(msg);
    debugPrint("------------------------------End $tag------------------------------");
  }

  static log(String tag, String msg) {
    debugPrint("---------------Start $tag---------------");
    debugPrint(msg);
    debugPrint("---------------End $tag---------------");
  }

}