import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:shopping_deals/util/logger.dart';
import 'package:shopping_deals/constant/constant.dart';
import 'package:shopping_deals/screen/dashboard_view/dashboard_view.dart';

class SplashViewModel extends BaseViewModel {
  BuildContext context;
  bool isLoading = false;

  SplashViewModel(this.context);

  void init() async {
    Logger.logTitle("SplashViewModel INIT", "init ${Constant.appName}");
    redirectToNextPage();
  }

  /// Loader
  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  /// Re-direct to Dashboard Page
  Future<void> redirectToNextPage() async {
    Logger.log("SplashViewModel INIT", "redirectToNextPage");
    toggleLoading();
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        toggleLoading();
        Get.offAll(const DashboardView());
      },
    );
  }
}