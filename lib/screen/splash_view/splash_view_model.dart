import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:shopping_deals/util/logger.dart';
import 'package:shopping_deals/constant/constant.dart';

class SplashViewModel extends BaseViewModel {
  BuildContext context;

  SplashViewModel(this.context);

  void init() async {
    Logger.logTitle("SplashViewModel INIT", "init ${Constant.appName}");
  }
}