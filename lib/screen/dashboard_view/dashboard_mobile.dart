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
      backgroundColor: ResColors.primary,
      leading: TextButton(
        onPressed: () => viewModel.onMenuClick(scaffoldKey),
        child: Icon(Icons.menu_sharp, color: ResColors.white),
      ),
      title: Text(
          Constant.deals,
          style: TextStyle(
            color: ResColors.white,
            fontWeight: FontWeight.w600,
          ),
      ),
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
      child: _tabBarLayout(context, viewModel),
    );
  }

  Widget _tabBarLayout(BuildContext context, DashboardViewModel viewModel) {
    return DefaultTabController(
      length: viewModel.tabList?.length ?? 0,
      initialIndex: 0,
      child: Column(
        children: [
          Container(
            color: ResColors.primary,
            child: TabBar(
              onTap: viewModel.onTabAction,
              controller: viewModel.tabController,
              indicatorColor: ResColors.deepOrange,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: ResColors.white,
              labelColor: ResColors.white,
              tabs: viewModel.tabList?.map((tab) => Tab(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),).toList() ?? [],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: viewModel.tabController,
              children: List.generate(
                viewModel.tabList?.length ?? 0,
                  (index) {
                    return (viewModel.isLoading && viewModel.dealsList!.isEmpty)
                        ? const Center(child: CircularProgressIndicator())
                        : viewModel.dealsModel == null
                          ? const Center(child: Text("No data found"))
                          : _displayDataWidget(context, viewModel);
                },
              ),
            ),
          ),
          SizedBox(
            child: viewModel.showPaginationLoader()
                ? const Center(child: CircularProgressIndicator())
                : viewModel.showPaginationEndedText()
                  ? const Center(child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text("No data found."),
                  ))
                  : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _displayDataWidget(BuildContext context, DashboardViewModel viewModel) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshApiAction(),
      child: ListView.builder(
        controller: viewModel.scrollController,
        itemCount: viewModel.dealsList?.length ?? 0,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              color: ResColors.white,
              child: viewModel.showNewTabTapLoader()
                ? const Center(child: CircularProgressIndicator())
                : Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    child: Container(
                      color: ResColors.white,
                      child: ListTile(
                        title: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                    child: Image.network(
                                      viewModel.dealsList?[index].imageMedium ?? "",
                                      fit: BoxFit.contain,
                                    ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("ID: ${viewModel.dealsList?[index].id ?? ""}",
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text("Milliseconds: ${viewModel.dealsList?[index].createdAtInMillis ?? ""}",
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.comment_sharp, color: ResColors.iconColor),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text("${viewModel.dealsList?[index].commentsCount ?? ""}",
                                            style: TextStyle(
                                                color: ResColors.iconColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                    child: Row(
                                      children: [
                                        Icon(Icons.watch_later_outlined, color: ResColors.iconColor),
                                        const SizedBox(width: 10),
                                        Expanded(
                                            child: Text(viewModel.dealsList?[index].createdAt ?? "",
                                              style: TextStyle(
                                                  color: ResColors.iconColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                        ),
                                      ],
                                    ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        dense: false,
                      ),
                    ),
                  ),
            ),
          ),
      ),
    );
  }

  Widget _drawer(BuildContext context, DashboardViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Drawer(
          elevation: 10.0,
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            children: [
              Material(
                elevation: 4.0,
                color: ResColors.primary,
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
                            fontWeight: FontWeight.w400
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