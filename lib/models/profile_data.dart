import 'category_model.dart';

class ProfileData {
  int? id;
  String? name;
  String? userName;
  String? email;
  String? image;
  String? url;
  String? description;
  String? link;
  String? slug;
  AvatarUrls? avatarUrls;
  List<String>? meta;
  bool? isSuperAdmin;
  WoocommerceMeta? woocommerceMeta;
  Links? lLinks;

  ProfileData(
      {this.id,
        this.name,
        this.userName,
        this.email,
        this.image,
        this.url,
        this.description,
        this.link,
        this.slug,
        this.avatarUrls,
        this.meta,
        this.isSuperAdmin,
        this.woocommerceMeta,
        this.lLinks});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    image = json['image'];
    url = json['url'];
    description = json['description'];
    link = json['link'];
    slug = json['slug'];
    avatarUrls = json['avatar_urls'] != null
        ? new AvatarUrls.fromJson(json['avatar_urls'])
        : null;
    if (json['meta'] != null) {
      meta = <String>[];
      json['meta'].forEach((v) {
        meta!.add(v);
      });
    }
    isSuperAdmin = json['is_super_admin'];
    woocommerceMeta = json['woocommerce_meta'] != null
        ? new WoocommerceMeta.fromJson(json['woocommerce_meta'])
        : null;
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['url'] = this.url;
    data['description'] = this.description;
    data['link'] = this.link;
    data['slug'] = this.slug;
    if (this.avatarUrls != null) {
      data['avatar_urls'] = this.avatarUrls!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.map((v) => v).toList();
    }
    data['is_super_admin'] = this.isSuperAdmin;
    if (this.woocommerceMeta != null) {
      data['woocommerce_meta'] = this.woocommerceMeta!.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class AvatarUrls {
  String? s24;
  String? s48;
  String? s96;

  AvatarUrls({this.s24, this.s48, this.s96});

  AvatarUrls.fromJson(Map<String, dynamic> json) {
    s24 = json['24'];
    s48 = json['48'];
    s96 = json['96'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['24'] = this.s24;
    data['48'] = this.s48;
    data['96'] = this.s96;
    return data;
  }
}

class WoocommerceMeta {
  String? activityPanelInboxLastRead;
  String? activityPanelReviewsLastRead;
  String? categoriesReportColumns;
  String? couponsReportColumns;
  String? customersReportColumns;
  String? ordersReportColumns;
  String? productsReportColumns;
  String? revenueReportColumns;
  String? taxesReportColumns;
  String? variationsReportColumns;
  String? dashboardSections;
  String? dashboardChartType;
  String? dashboardChartInterval;
  String? dashboardLeaderboardRows;
  String? homepageLayout;
  String? homepageStats;
  String? taskListTrackedStartedTasks;
  String? helpPanelHighlightShown;
  String? androidAppBannerDismissed;

  WoocommerceMeta(
      {this.activityPanelInboxLastRead,
        this.activityPanelReviewsLastRead,
        this.categoriesReportColumns,
        this.couponsReportColumns,
        this.customersReportColumns,
        this.ordersReportColumns,
        this.productsReportColumns,
        this.revenueReportColumns,
        this.taxesReportColumns,
        this.variationsReportColumns,
        this.dashboardSections,
        this.dashboardChartType,
        this.dashboardChartInterval,
        this.dashboardLeaderboardRows,
        this.homepageLayout,
        this.homepageStats,
        this.taskListTrackedStartedTasks,
        this.helpPanelHighlightShown,
        this.androidAppBannerDismissed});

  WoocommerceMeta.fromJson(Map<String, dynamic> json) {
    activityPanelInboxLastRead = json['activity_panel_inbox_last_read'];
    activityPanelReviewsLastRead = json['activity_panel_reviews_last_read'];
    categoriesReportColumns = json['categories_report_columns'];
    couponsReportColumns = json['coupons_report_columns'];
    customersReportColumns = json['customers_report_columns'];
    ordersReportColumns = json['orders_report_columns'];
    productsReportColumns = json['products_report_columns'];
    revenueReportColumns = json['revenue_report_columns'];
    taxesReportColumns = json['taxes_report_columns'];
    variationsReportColumns = json['variations_report_columns'];
    dashboardSections = json['dashboard_sections'];
    dashboardChartType = json['dashboard_chart_type'];
    dashboardChartInterval = json['dashboard_chart_interval'];
    dashboardLeaderboardRows = json['dashboard_leaderboard_rows'];
    homepageLayout = json['homepage_layout'];
    homepageStats = json['homepage_stats'];
    taskListTrackedStartedTasks = json['task_list_tracked_started_tasks'];
    helpPanelHighlightShown = json['help_panel_highlight_shown'];
    androidAppBannerDismissed = json['android_app_banner_dismissed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_panel_inbox_last_read'] = this.activityPanelInboxLastRead;
    data['activity_panel_reviews_last_read'] =
        this.activityPanelReviewsLastRead;
    data['categories_report_columns'] = this.categoriesReportColumns;
    data['coupons_report_columns'] = this.couponsReportColumns;
    data['customers_report_columns'] = this.customersReportColumns;
    data['orders_report_columns'] = this.ordersReportColumns;
    data['products_report_columns'] = this.productsReportColumns;
    data['revenue_report_columns'] = this.revenueReportColumns;
    data['taxes_report_columns'] = this.taxesReportColumns;
    data['variations_report_columns'] = this.variationsReportColumns;
    data['dashboard_sections'] = this.dashboardSections;
    data['dashboard_chart_type'] = this.dashboardChartType;
    data['dashboard_chart_interval'] = this.dashboardChartInterval;
    data['dashboard_leaderboard_rows'] = this.dashboardLeaderboardRows;
    data['homepage_layout'] = this.homepageLayout;
    data['homepage_stats'] = this.homepageStats;
    data['task_list_tracked_started_tasks'] = this.taskListTrackedStartedTasks;
    data['help_panel_highlight_shown'] = this.helpPanelHighlightShown;
    data['android_app_banner_dismissed'] = this.androidAppBannerDismissed;
    return data;
  }
}

class Links {
  List<Self>? self;
  List<Collection>? collection;

  Links({this.self, this.collection});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(new Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection!.add(new Collection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

