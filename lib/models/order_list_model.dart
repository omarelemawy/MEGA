class OrderListDataModel {
  String? status;
  String? message;
  List<OrderList>? data;

  OrderListDataModel({this.status, this.message, this.data});

  OrderListDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderList>[];
      json['data'].forEach((v) { data!.add( OrderList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
  int? id;
  String? total;
  String? discount;
  int? status;
  String? shippingDate;
  String? shippingNo;
  int? shippingCost;
  int? itemsCount;
  ShippingAddress? shippingAddress;
  List<Items>? items;

  OrderList({this.id, this.total, this.itemsCount,this.discount, this.status, this.shippingDate, this.shippingNo, this.shippingCost, this.shippingAddress, this.items});

  OrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    itemsCount = json['itemsCount'];
    discount = json['discount'];
    status = json['status'];
    shippingDate = json['shippingDate'];
    shippingNo = json['shippingNo'];
    shippingCost = json['shippingCost'];
    shippingAddress = json['shippingAddress'] != null ?  ShippingAddress.fromJson(json['shippingAddress']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) { items!.add( Items.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['itemsCount'] = this.itemsCount;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['shippingDate'] = this.shippingDate;
    data['shippingNo'] = this.shippingNo;
    data['shippingCost'] = this.shippingCost;
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingAddress {
  int? id;
  User? user;
  Country? country;
  Governorate? governorate;
  Governorate? city;
  String? address;
  String? phone;
  String? postalCode;

  ShippingAddress({this.id, this.user, this.country, this.governorate, this.city, this.address, this.phone, this.postalCode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    country = json['country'] != null ? new Country.fromJson(json['country']) : null;
    governorate = json['governorate'] != null ? new Governorate.fromJson(json['governorate']) : null;
    city = json['city'] != null ? new Governorate.fromJson(json['city']) : null;
    address = json['address'];
    phone = json['phone'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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

class User {
  int? id;
  String? name;
  String? userName;
  String? email;
  String? language;
  String? gender;
  String? phone;
  String? photo;
  Country? country;
  Governorate? governorate;
  Governorate? city;

  User({this.id, this.name, this.userName, this.email, this.language, this.gender, this.phone, this.photo, this.country, this.governorate, this.city});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    language = json['language'];
    gender = json['gender'];
    phone = json['phone'];
    photo = json['photo'];
    country = json['country'] != null ? new Country.fromJson(json['country']) : null;
    governorate = json['governorate'] != null ? new Governorate.fromJson(json['governorate']) : null;
    city = json['city'] != null ? new Governorate.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
  int? id;
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

class Items {
  int? id;
  String? name;
  String? description;
  Thumbnail? thumbnail;
  List<Thumbnail>? photos;
  String? price;
  String? offer;
  String? isLiked;
  String? quantity;
  int? totalItem;

  Items({this.id, this.name, this.description, this.thumbnail, this.photos, this.price, this.offer, this.isLiked, this.quantity, this.totalItem});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    thumbnail = json['thumbnail'] != null ? new Thumbnail.fromJson(json['thumbnail']) : null;
    if (json['photos'] != null) {
      photos = <Thumbnail>[];
      json['photos'].forEach((v) { photos!.add(new Thumbnail.fromJson(v)); });
    }
    price = json['price'];
    offer = json['offer'];
    isLiked = json['isLiked'];
    quantity = json['quantity'];
    totalItem = json['totalItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['offer'] = this.offer;
    data['isLiked'] = this.isLiked;
    data['quantity'] = this.quantity;
    data['totalItem'] = this.totalItem;
    return data;
  }
}

class Thumbnail {
  String? name;
  int? defaultItem;
  String? url;

  Thumbnail({this.name, this.defaultItem, this.url});

Thumbnail.fromJson(Map<String, dynamic> json) {
name = json['name'];
defaultItem = json['default'];
url = json['url'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = this.name;
  data['default'] = this.defaultItem;
  data['url'] = this.url;
  return data;
}
}

