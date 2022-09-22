class SettingsModel {
  String? status;
  String? message;
  Data? data;

  SettingsModel({this.status, this.message, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  ContactData? contactData;
  List<MySlider>? slider;
  MySlider? homeAd;

  Data({this.contactData, this.slider, this.homeAd});

  Data.fromJson(Map<String, dynamic> json) {
    contactData = json['contact_data'] != null
        ? new ContactData.fromJson(json['contact_data'])
        : null;
    if (json['slider'] != null) {
      slider = <MySlider>[];
      json['slider'].forEach((v) {
        slider!.add(new MySlider.fromJson(v));
      });
    }
    homeAd = json['home_ad'] != null
        ? new MySlider.fromJson(json['home_ad'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contactData != null) {
      data['contact_data'] = this.contactData!.toJson();
    }
    if (this.slider != null) {
      data['slider'] = this.slider!.map((v) => v.toJson()).toList();
    }
    if (this.homeAd != null) {
      data['home_ad'] = this.homeAd!.toJson();
    }
    return data;
  }
}

class ContactData {
  String? whatsapp;
  String? mobile;
  String? email;

  ContactData({this.whatsapp, this.mobile, this.email});

  ContactData.fromJson(Map<String, dynamic> json) {
    whatsapp = json['whatsapp'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whatsapp'] = this.whatsapp;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}

class MySlider {
  String? image;
  String? type;
  String? details;

  MySlider({this.image, this.type, this.details});

  MySlider.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    type = json['type'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['type'] = this.type;
    data['details'] = this.details;
    return data;
  }
}
