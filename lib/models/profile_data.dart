class ProfileData {
  String? status;
  String? message;
  Data? data;

  ProfileData({this.status, this.message, this.data});

  ProfileData.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  Null? userName;
  String? email;
  String? language;
  String? gender;
  String? phone;
  String? photo;
  String? birthDate;
  Country? country;
  Governorate? governorate;
  Governorate? city;

  Data(
      {this.id,
        this.name,
        this.userName,
        this.email,
        this.birthDate,
        this.language,
        this.gender,
        this.phone,
        this.photo,
        this.country,
        this.governorate,
        this.city});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthDate = json['birth_date'];
    userName = json['userName'];
    email = json['email'];
    language = json['language'];
    gender = json['gender'];
    phone = json['phone'];
    photo = json['photo'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    governorate = json['governorate'] != null
        ? new Governorate.fromJson(json['governorate'])
        : null;
    city = json['city'] != null ? new Governorate.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['birth_date'] = this.birthDate;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['language'] = this.language;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  String? name;
  String? phoneCode;

  Country({this.id, this.name, this.phoneCode});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneCode = json['phone_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_code'] = this.phoneCode;
    return data;
  }
}

class Governorate {
  String? id;
  String? name;

  Governorate({this.id, this.name});

  Governorate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
