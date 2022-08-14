class productsModel {
  String? status;
  String? message;
  List<products>? data;

  productsModel({this.status, this.message, this.data});

  productsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <products>[];
      json['data'].forEach((v) { data!.add(new products.fromJson(v)); });
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

class products {
  int? id;
  String? name;
  String? thumbnail;
  List<Photos>? photos;
  String? price;
  String? offer;

  products({this.id, this.name, this.thumbnail, this.photos, this.price, this.offer});

  products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) { photos!.add(new Photos.fromJson(v)); });
    }
    price = json['price'];
    offer = json['offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['offer'] = this.offer;
    return data;
  }
}

class Photos {
  String? name;
  int? isDefault;
  String? url;

  Photos({this.name, this.isDefault, this.url});

Photos.fromJson(Map<String, dynamic> json) {
name = json['name'];
isDefault = json['default'];
url = json['url'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = this.name;
  data['default'] = this.isDefault;
  data['url'] = this.url;
  return data;
}
}
