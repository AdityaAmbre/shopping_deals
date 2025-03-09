library dashboard_view;

import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:shopping_deals/res/res_colors.dart';
import 'package:shopping_deals/constant/constant.dart';
import 'package:shopping_deals/widgets/list_tiles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shopping_deals/screen/dashboard_view/dashboard_view_model.dart';

part 'dashboard_mobile.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardViewModel(context),
      onViewModelReady: (viewModel) async {
        final ticker = Navigator.of(context);
        viewModel.init(ticker);
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout.builder(
          mobile: (context) => DashboardMobile(viewModel),
        );
      },
    );
  }
}