import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:shopping_deals/util/logger.dart';
import 'package:shopping_deals/constant/constant.dart';

class DashboardViewModel extends BaseViewModel {
  BuildContext context;
  bool isLoading = false;
  List<String>? drawerTitleList = [];
  List<IconData>? drawerIconList = [];

  DashboardViewModel(this.context);

  void init() async {
    Logger.logTitle("DashboardViewModel INIT", "init ${Constant.appName}");
    initPreferences();
  }

  void initPreferences() {
    drawerTitleList = ['Dashboard', 'Top', 'Popular', 'Featured', 'About'];
    drawerIconList = [Icons.dashboard_sharp, Icons.trending_up_sharp, Icons.group, Icons.verified, Icons.info_sharp];
    notifyListeners();
  }

  /// Loader
  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  /// Menu Click Action
  void onMenuClick(GlobalKey<ScaffoldState> scaffoldKey) {
    Logger.log("DashboardViewModel INIT", "onMenuClick");
    scaffoldKey.currentState?.openDrawer();
  }

  /// Search Click Action
  void onSearchClick() {
    Logger.log("DashboardViewModel INIT", "onSearchClick");
  }

  /// Dashboard Tap Action
  void onDrawerTapAction(int index) {
    switch (index) {
      case 0:
        onDashboardTapAction();
        break;
      case 1:
        onTopTapAction();
        break;
      case 2:
        onPopularTapAction();
        break;
      case 3:
        onFeaturedTapAction();
        break;
      case 4:
        onAboutTapAction();
        break;
      default:
        break;
    }
  }

  void onDashboardTapAction() {
    Logger.log("DashboardViewModel INIT", "onDashboardTapAction");
  }

  void onTopTapAction() {
    Logger.log("DashboardViewModel INIT", "onTopTapAction");
  }

  void onPopularTapAction() {
    Logger.log("DashboardViewModel INIT", "onPopularTapAction");
  }

  void onFeaturedTapAction() {
    Logger.log("DashboardViewModel INIT", "onFeaturedTapAction");
  }

  void onAboutTapAction() {
    Logger.log("DashboardViewModel INIT", "onAboutTapAction");
  }
}