class AddressModel {
  String? status;
  String? message;
  List<Address>? data;

  AddressModel({this.status, this.message, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Address>[];
      json['data'].forEach((v) {
        data!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  Country? country;
  Country? governorate;
  Country? city;
  String? address;
  String? postalCode;
  String? phone;

  Address(
      {this.id,
        this.country,
        this.governorate,
        this.city,
        this.address,
        this.postalCode,
       this.phone});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    governorate = json['governorate'] != null
        ? new Country.fromJson(json['governorate'])
        : null;
    city = json['city'] != null ? new Country.fromJson(json['city']) : null;
    address = json['address'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['postal_code'] = this.postalCode;
    return data;
  }
}

class Country {
  int? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
