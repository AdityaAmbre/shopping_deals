import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:shopping_deals/core/api.dart';
import 'package:shopping_deals/util/util.dart';
import 'package:shopping_deals/util/logger.dart';
import 'package:shopping_deals/res/res_colors.dart';
import 'package:shopping_deals/widgets/dialog.dart';
import 'package:shopping_deals/constant/constant.dart';
import 'package:shopping_deals/model/deals_model.dart';

class DashboardViewModel extends BaseViewModel {
  final BuildContext context;
  bool isLoading = false;
  int perPage = 10;
  int pageNumber = 1;
  int currentTabIndex = 0;
  double previousOffset = 0;
  List<String>? tabList = [];
  List<String>? drawerTitleList = [];
  List<IconData>? drawerIconList = [];
  List<Deals>? dealsList = [];
  DealsModel? dealsModel;

  Api api = Api();
  TabController? tabController;
  ScrollController scrollController = ScrollController();

  DashboardViewModel(this.context);

  /// INIT
  void init(TickerProvider vsync) async {
    Logger.logTitle("DashboardViewModel INIT", "init ${Constant.appName}");
    initPreferences();
    initTabController(vsync);
    addScrollControllerListener();
    await onApiCall(
      hostUrl: Constant.baseTopURL,
      perPage: perPage,
      pageNumber: pageNumber,
      fields: Constant.fields
    );
  }

  /// Init Preferences
  void initPreferences() {
    tabList = ["TOP", "POPULAR", "FEATURED"];
    drawerTitleList = ['Dashboard', 'Top', 'Popular', 'Featured', 'About'];
    drawerIconList = [Icons.dashboard_sharp, Icons.trending_up_sharp, Icons.star_sharp, Icons.verified, Icons.info_sharp];
    notifyListeners();
  }

  /// Tab Controller
  void initTabController(TickerProvider vsync) {
    tabController = TabController(length: tabList?.length ?? 0, vsync: vsync);
  }

  void addScrollControllerListener() async {
    previousOffset = 0;
    scrollController.addListener(() {
      previousOffset = scrollController.offset;
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        onPaginationApiCall();
      }
    },);
  }

  void onPaginationApiCall () async {
    String baseUrl  = getCurrentTabBaseUrl(currentTabIndex);
    await onApiCall(
        hostUrl: baseUrl,
        perPage: perPage,
        pageNumber: pageNumber,
        fields: Constant.fields
    );
  }

  String getCurrentTabBaseUrl(int currentTabIndex) {
    switch(currentTabIndex) {
      case 0:
        return Constant.baseTopURL;
      case 1:
        return Constant.basePopularURL;
      case 2:
        return Constant.baseFeaturedURL;
      default:
        return Constant.baseTopURL;
    }
  }

  /// Tab Click Action
  void onTabAction(int index) async {
    clearResponseModel();
    tabController?.animateTo(index);
    Logger.log("DashboardViewModel TAB", "$index");
    switch(index) {
      case 0:
        if (currentTabIndex != 0) {
          currentTabIndex = 0;
          dealsList = [];
        }
        // clearResponseModel();
        await onApiCall(
            hostUrl: Constant.baseTopURL,
            perPage: perPage,
            pageNumber: pageNumber,
            fields: Constant.fields
        );
        break;
      case 1:
        if (currentTabIndex != 1) {
          currentTabIndex = 1;
          dealsList = [];
        }
        // clearResponseModel();
        await onApiCall(
            hostUrl: Constant.basePopularURL,
            perPage: perPage,
            pageNumber: pageNumber,
            fields: Constant.fields
        );
        break;
      case 2:
        if (currentTabIndex != 2) {
          currentTabIndex = 2;
          dealsList = [];
        }
        // clearResponseModel();
        await onApiCall(
            hostUrl: Constant.baseFeaturedURL,
            perPage: perPage,
            pageNumber: pageNumber,
            fields: Constant.fields
        );
        break;
      default:
        if (currentTabIndex != 1) {
          currentTabIndex = 1;
          dealsList = [];
        }
        // clearResponseModel();
        await onApiCall(
            hostUrl: Constant.baseTopURL,
            perPage: perPage,
            pageNumber: pageNumber,
            fields: Constant.fields
        );
        break;
    }
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

  /// Tab Bar Click Action
  void onTabTapAction(String tab) {
    Logger.log("DashboardViewModel Tabs", "onTabTapAction");
    Logger.log("TAB: ", tab);
    notifyListeners();
  }

  /// Dashboard Tap Action
  void onDrawerTapAction(int index) {
    switch (index) {
      case 0:
        onDashboardTapAction(index);
        break;
      case 1:
        onTopTapAction(index);
        break;
      case 2:
        onPopularTapAction(index);
        break;
      case 3:
        onFeaturedTapAction(index);
        break;
      case 4:
        onAboutTapAction();
        break;
      default:
        break;
    }
  }

  void onDashboardTapAction(int index) async {
    Logger.log("DashboardViewModel Drawer", "onDashboardTapAction");
    onTabAction(index);
  }

  Future<void> onRefreshApiAction() async {
    int index = currentTabIndex;
    onTabAction(index);
  }

  void onTopTapAction(int index) {
    Logger.log("DashboardViewModel Drawer", "onTopTapAction");
    onTabAction(index-1);
  }

  void onPopularTapAction(int index) {
    Logger.log("DashboardViewModel Drawer", "onPopularTapAction");
    onTabAction(index-1);
  }

  void onFeaturedTapAction(int index) {
    Logger.log("DashboardViewModel Drawer", "onFeaturedTapAction");
    onTabAction(index-1);
  }

  void onAboutTapAction() {
    Logger.log("DashboardViewModel Drawer", "onAboutTapAction");
    onAboutClick(context);
  }

  /// Handle API Call
  Future<void> onApiCall({
    required String hostUrl,
    required int perPage,
    required int pageNumber,
    required String fields
  }) async {
    final Map<String, String> headers = {
      Constant.headerKey: Constant.headerValue
    };

    // API Call
    toggleLoading();
    Map<String, dynamic>? data = await api.apiCallHttpGet(
        baseUrl: hostUrl,
        perPage: perPage,
        pageNumber: pageNumber,
        fields: fields,
        headersList: headers
    );
    toggleLoading();

    if (data != null) {
      dealsModel = DealsModel.fromJson(data);
      if (dealsModel != null) {
        if (dealsModel!.deals != null) {
          if (dealsModel!.deals!.isNotEmpty) {
            if (this.pageNumber > 1) {
              dealsList?.addAll(dealsModel!.deals ?? []);
            } else{
              dealsList = dealsModel!.deals ?? [];
            }
            this.pageNumber++;
          }
        }
      }
      if (dealsList != null) {
        if (dealsList!.isNotEmpty) {
          if (dealsList!.length > 1) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.jumpTo(previousOffset);
              // scrollController.animateTo(
              //   previousOffset,
              //   duration: const Duration(milliseconds: 100),
              //   curve: Curves.linear,
              // );
            });
          }
        }
      }
      notifyListeners();
      Logger.log("==> Deals Length: ", "${dealsList?.length ?? 0}");
    } else {
      Logger.log("DashboardViewModel API", "No data found");
      if (context.mounted) {
        CustomAlertDialog.showAlertDialog(
          context: context,
          title: 'Alert',
          child: const Text("No data found"),
          buttonText: 'Exit',
          onPressed: () => Get.back(),
        );
      } else {
        return;
      }
    }
  }

  void clearResponseModel() {
    perPage = 10;
    pageNumber = 1;
    previousOffset = 0;
    // dispose();
    // addScrollControllerListener();
    if (dealsModel != null) {
      dealsModel = null;
    }
    if (dealsList != null){
      if (dealsList!.isNotEmpty) {
        dealsList = [];
      }
    }
  }

  bool showPaginationLoader() {
    if (dealsList != null) {
      if (dealsList!.isNotEmpty) {
        if (dealsList!.length > 1) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   scrollController.animateTo(
          //       previousOffset,
          //       duration: const Duration(microseconds: 10),
          //       curve: Curves.linear
          //   );
          // });
        }
      }
    }
    if (dealsList != null) {
      if (dealsList!.isNotEmpty) {
        if (isLoading == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool showNewTabTapLoader() {
    if (dealsList == null || dealsList == []) {
      return true;
    } else {
      return false;
    }
  }

  void onAboutClick(BuildContext context) {
    CustomAlertDialog.showAlertDialog(
      context: context,
      title: "About",
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(Constant.appName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(width: 20),
                Icon(
                  Icons.shopping_cart_sharp,
                  size: 30,
                  color: ResColors.primary,
                ),
              ],
            ),
            const SizedBox(width: 5.0),
            const Text("Version - (${Constant.appVersion})",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text("Designed & Developed by, Aditya Ambre.",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ),),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Util.openUrl(Constant.githubProfile),
              child: const Text.rich(
                TextSpan(
                  text: "• GitHub Profile: ",
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "Aditya Ambre",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => Util.openUrl(Constant.githubProject),
              child: const Text.rich(
                TextSpan(
                  text: "• GitHub Project: ",
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "Source Code",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => Util.openUrl(Constant.githubLicense),
              child: const Text.rich(
                TextSpan(
                  text: "• Copyrights: ",
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "Apache License 2.0",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            const Text("Demo APIs",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Util.openUrl(Constant.topFirstURL),
              child: const Text.rich(
                TextSpan(
                  text: "• API - 1: GET Request",
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "\n${Constant.topFirstURL}",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => Util.openUrl(Constant.popularSecondURL),
              child: const Text.rich(
                TextSpan(
                  text: "• API - 2: GET Request",
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "\n${Constant.popularSecondURL}",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => Util.openUrl(Constant.featuredThirdURL),
              child: const Text.rich(
                TextSpan(
                  text: "• API - 3: GET Request",
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "\n${Constant.featuredThirdURL}",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            const Text("API Headers",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: "• Key: ",
                style: const TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                    text: "\n${Constant.headerKey}",
                    style: TextStyle(
                      color: ResColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "• Value: ",
                style: const TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: "\n${Constant.headerValue}",
                    style: TextStyle(
                      color: ResColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onPressed: () => Get.back(),
      buttonText: "EXIT",
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bool showPaginationEndedText() {
    if (dealsList != null) {
      if (dealsList!.isNotEmpty) {
        if (dealsModel == null) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}