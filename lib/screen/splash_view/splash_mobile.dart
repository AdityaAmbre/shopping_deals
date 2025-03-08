part of 'splash_view.dart';

class SplashMobile extends StatelessWidget {
  final SplashViewModel viewModel;

  const SplashMobile(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, viewModel),
      body: _body(context, viewModel),
    );
  }

  AppBar _appBar(BuildContext context, SplashViewModel viewModel) {
    return AppBar(
      title: const Text(Constant.appName),
    );
  }

  Widget _body(BuildContext context, SplashViewModel viewModel) {
    return Container(
      color: Colors.blue,
      child: const Center(child: Text(Constant.appName, style: TextStyle(color: Colors.white))),
    );
  }
}