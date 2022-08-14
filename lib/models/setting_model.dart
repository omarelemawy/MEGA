class SettingsModel {
  String? status;
  String? message;
  Setting? data;

  SettingsModel({this.status, this.message, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Setting.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Setting {
  SiteStatus? siteStatus;
  SEO? sEO;
  Social? social;
  Images? images;
  ContactData? contactData;
  HomeBanner? homeBanner;
  List<OrderShippinfStatusList>? orderShippinfStatusList;
  int? notificationsNumber;
  int? cartNumber;
  List<MySlider>? slider;
  String? homeBg;

  Setting(
      {this.siteStatus,
        this.sEO,
        this.social,
        this.images,
        this.contactData,
        this.orderShippinfStatusList,
        this.notificationsNumber,
        this.cartNumber,
        this.slider,
        this.homeBg});

  Setting.fromJson(Map<String, dynamic> json) {
    siteStatus = json['site_status'] != null
        ? new SiteStatus.fromJson(json['site_status'])
        : null;
    sEO = json['SEO'] != null ? new SEO.fromJson(json['SEO']) : null;
    social =
    json['social'] != null ? new Social.fromJson(json['social']) : null;
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    contactData = json['contact_data'] != null ? new ContactData.fromJson(json['contact_data']) : null;
    homeBanner = json['homeBanner'] != null ? new HomeBanner.fromJson(json['homeBanner']) : null;

    if (json['orderShippinfStatusList'] != null) {
      orderShippinfStatusList = <OrderShippinfStatusList>[];
      json['orderShippinfStatusList'].forEach((v) {
        orderShippinfStatusList!.add(new OrderShippinfStatusList.fromJson(v));
      });
    }
    notificationsNumber = json['notificationsNumber'];
    cartNumber = json['cartNumber'];
    if (json['slider'] != null) {
      slider = <MySlider>[];
      json['slider'].forEach((v) {
        slider!.add(new MySlider.fromJson(v));
      });
    }
    homeBg = json['homeBg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.siteStatus != null) {
      data['site_status'] = this.siteStatus!.toJson();
    }
    if (this.sEO != null) {
      data['SEO'] = this.sEO!.toJson();
    }
    if (this.social != null) {
      data['social'] = this.social!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.contactData != null) {
      data['contact_data'] = this.contactData!.toJson();
    }
    if (this.homeBanner != null) {
      data['homeBanner'] = this.homeBanner!.toJson();
    }
    if (this.orderShippinfStatusList != null) {
      data['orderShippinfStatusList'] =
          this.orderShippinfStatusList!.map((v) => v.toJson()).toList();
    }
    data['notificationsNumber'] = this.notificationsNumber;
    data['cartNumber'] = this.cartNumber;
    if (this.slider != null) {
      data['slider'] = this.slider!.map((v) => v.toJson()).toList();
    }
    data['homeBg'] = this.homeBg;
    return data;
  }
}

class SiteStatus {
  String? status;
  String? text;

  SiteStatus({this.status, this.text});

  SiteStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['text'] = this.text;
    return data;
  }
}

class SEO {
  String? title;
  String? description;
  String? keywords;

  SEO({this.title, this.description, this.keywords});

  SEO.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    keywords = json['keywords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['keywords'] = this.keywords;
    return data;
  }
}

class Social {
  String? facebook;
  String? twitter;
  String? instagram;
  String? youtube;

  Social({this.facebook, this.twitter, this.instagram, this.youtube});

  Social.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    return data;
  }
}

class Images {
  String? logo;
  String? fav;

  Images({this.logo, this.fav});

  Images.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    fav = json['fav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['fav'] = this.fav;
    return data;
  }
}

class ContactData {
  String? phone;
  String? mobile;
  String? email;
  String? map;

  ContactData({this.phone, this.mobile, this.email, this.map});

  ContactData.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    mobile = json['mobile'];
    email = json['email'];
    map = json['map'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['map'] = this.map;
    return data;
  }
}

class OrderShippinfStatusList {
  String? id;
  String? name;

  OrderShippinfStatusList({this.id, this.name});

  OrderShippinfStatusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MySlider {
  String? image;
  String? link;

  MySlider({this.image, this.link});

  MySlider.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
class HomeBanner {
  int? status;
  String? type;
  String? image;
  String? link;

  HomeBanner({this.status, this.type, this.image, this.link});

  HomeBanner.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}

