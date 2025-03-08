part of 'dashboard_view.dart';

class DashboardMobile extends StatelessWidget {
  final DashboardViewModel viewModel;

  DashboardMobile(this.viewModel, {super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(context, viewModel),
      drawer: _drawer(context, viewModel),
      body: _body(context, viewModel),
    );
  }

  AppBar _appBar(BuildContext context, DashboardViewModel viewModel) {
    return AppBar(
      elevation: 4.0,
      backgroundColor: ResColors.primary,
      leading: TextButton(
        onPressed: () => viewModel.onMenuClick(scaffoldKey),
        child: Icon(Icons.menu_sharp, color: ResColors.white),
      ),
      title: Text(Constant.deals, style: TextStyle(color: ResColors.white)),
      actions: [
        TextButton(
          onPressed: () => viewModel.onSearchClick(),
          child: Icon(Icons.search_sharp, color: ResColors.white),
        ),
      ],
    );
  }

  Widget _body(BuildContext context, DashboardViewModel viewModel) {
    return Container(
      color: ResColors.white,
      width: double.infinity,
      child: const Center(child: Text("Dashboard")),
    );
  }

  Widget _drawer(BuildContext context, DashboardViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Drawer(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            children: [
              Material(
                elevation: 4.0,
                color: ResColors.primary,
                shadowColor: ResColors.black,
                child: SizedBox(
                  height: MediaQuery.of(context).size.width / 2.0,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 60, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  Constant.appName,
                                  style: TextStyle(
                                    color: ResColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Icon(
                                Icons.shopping_cart_sharp,
                                color: ResColors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 0.25),
                        Text(
                          'Version - ${Constant.appVersion}',
                          style: TextStyle(
                            color: ResColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7.5),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: viewModel.drawerTitleList?.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTiles.listTiesIconBefore(
                        icon: Icon(viewModel.drawerIconList?[index],
                          color: ResColors.primary
                        ),
                        name: viewModel.drawerTitleList?[index] ?? '',
                        onTapCallback: () {
                          Get.back();
                          viewModel.onDrawerTapAction(index);
                        },
                      ),
                      Divider(color: ResColors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}