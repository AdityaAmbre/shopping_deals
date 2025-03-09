import 'package:url_launcher/url_launcher.dart';
import 'package:shopping_deals/util/logger.dart';

class Util {
  Util();

  static Future<void> openUrl(String link) async {
    Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Logger.log("Error launching URL:", "$url");
    }
  }
}