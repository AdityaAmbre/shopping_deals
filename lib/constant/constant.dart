class Constant {
  Constant();

  /// App
  static const String appName = "Shopping Deals";
  static const String deals = "Deals";
  static const String appVersion = "1.0.0";

  /// Pages
  static const String homePage = "Deals";

  /// Host URLs
  static const String topFirstURL = "http://stagingauth.desidime.com/v4/home/new?per_page=10&page=1&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store%7Bname";
  static const String popularSecondURL = "http://stagingauth.desidime.com/v4/home/discussed?per_page=10&page=1&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store%7Bname";
  static const String featuredThirdURL = "http://stagingauth.desidime.com/v4/home/discussed?per_page=10&page=1&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store%7Bname";

  /// Headers
  static const String headerKey = "X-Desidime-Client";
  static const String headerValue = "08b4260e5585f282d1bd9d085e743fd9";

  /// About URLs
  static const String githubProfile = "https://github.com/AdityaAmbre";
  static const String githubProject = "https://github.com/AdityaAmbre/shopping_deals";
  static const String githubLicense = "https://github.com/AdityaAmbre/shopping_deals/blob/main/LICENSE";
}