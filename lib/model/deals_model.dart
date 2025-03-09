class DealsModel {
  final SeoSettings? seoSettings;
  final List<Deals>? deals;
  final Event? event;

  DealsModel({
    this.seoSettings,
    this.deals,
    this.event
  });

  factory DealsModel.fromJson(Map<String, dynamic> json) {
    return DealsModel(
        seoSettings: json["seo_settings"] == null ? null : SeoSettings.fromJson(json["seo_settings"]),
        deals: json["deals"] == null ? [] : List<Deals>.from(json["deals"]!.map((e) => Deals.fromJson(e))),
        event: json["event"] == null ? null : Event.fromJson(json["event"])
    );
  }

  Map<String, dynamic> toJson() => {
    "seo_settings": seoSettings?.toJson(),
    "deals": deals?.map((e) => e.toJson()).toList() ?? [],
    "event": event?.toJson()
  };
}

class SeoSettings {
  final String? seoTitle;
  final String? seoDescription;
  final String? webUrl;

  SeoSettings({
    this.seoTitle,
    this.seoDescription,
    this.webUrl
  });

  factory SeoSettings.fromJson(Map<String, dynamic> json) {
    return SeoSettings(
      seoTitle: json["seo_title"],
      seoDescription: json["seo_description"],
      webUrl: json["web_url"]
    );
  }

  Map<String, dynamic> toJson() => {
    "seo_title": seoTitle,
    "seo_description": seoDescription,
    "web_url": webUrl
  };
}

class Deals {
  final int? id;
  final int? commentsCount;
  final String? createdAt;
  final int? createdAtInMillis;
  final String? imageMedium;

  Deals({
    this.id,
    this.commentsCount,
    this.createdAt,
    this.createdAtInMillis,
    this.imageMedium
  });

  factory Deals.fromJson(Map<String, dynamic> json) {
    return Deals(
      id: json["id"],
      commentsCount: json["comments_count"],
      createdAt: json["created_at"],
      createdAtInMillis: json["created_at_in_millis"],
      imageMedium: json["image_medium"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "comments_count": commentsCount,
    "created_at": createdAt,
    "created_at_in_millis": createdAtInMillis,
    "image_medium": imageMedium
  };
}

class Event {
  final int? id;
  final String? imageUrl;
  final String? pageUrl;

  Event({
    this.id,
    this.imageUrl,
    this.pageUrl
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["id"],
      imageUrl: json["image_url"],
      pageUrl: json["page_url"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "page_url": pageUrl
  };
}