part of 'splash_view.dart';

class SplashMobile extends StatelessWidget {
  final SplashViewModel viewModel;

  const SplashMobile(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context, viewModel),
    );
  }

  Widget _body(BuildContext context, SplashViewModel viewModel) {
    return Container(
      color: ResColors.primary,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_sharp,
            color: ResColors.white,
            size: 120,
            shadows: const [Shadow(color: Colors.black26, offset: Offset(-4, 4))],
          ),
          const SizedBox(height: 25),
          Text(
            Constant.appName,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: ResColors.white,
              fontStyle: FontStyle.italic,
              fontSize: 27,
              shadows: const [Shadow(color: Colors.black26, offset: Offset(2, -2))],
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            Constant.appVersion,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: ResColors.white,
              fontStyle: FontStyle.italic,
              fontSize: 20,
              shadows: const [Shadow(color: Colors.black26, offset: Offset(2, -2))],
            ),
          ),
          const SizedBox(height: 50),
          viewModel.isLoading
              ? CircularProgressIndicator(color: ResColors.white)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}