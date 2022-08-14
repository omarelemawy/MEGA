class CartDataModel {
  String? status;
  String? message;
  CartData? data;

  CartDataModel({this.status, this.message, this.data});

  CartDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CartData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CartData {
  int? id;
  String? total;
  String? discount;
  int? itemsCount;
  List<ItemsCartData>? items;

  CartData({this.id, this.total, this.items,this.itemsCount});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    discount = json['discount'];
    itemsCount = json['itemsCount'];
    if (json['items'] != null) {
      items = <ItemsCartData>[];
      json['items'].forEach((v) { items!.add(new ItemsCartData.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['itemsCount'] = this.itemsCount;
    data['discount'] = this.discount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsCartData {
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
  int? itemsCount;

  ItemsCartData({this.id, this.name, this.description,
    this.itemsCount,
    this.thumbnail, this.photos, this.price, this.offer, this.isLiked,
    this.quantity,this.totalItem
  });

  ItemsCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    itemsCount = json['itemsCount'];
    thumbnail = json['thumbnail'] != null ?  Thumbnail.fromJson(json['thumbnail']) : null;
    if (json['photos'] != null) {
      photos = <Thumbnail>[];
      json['photos'].forEach((v) { photos!.add( Thumbnail.fromJson(v)); });
    }
    price = json['price'];
    offer = json['offer'];
    isLiked = json['isLiked'];
    totalItem = json['totalItem'];
    quantity = json['quantity'];
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
    data['itemsCount'] = this.itemsCount;
    data['isLiked'] = this.isLiked;
    data['totalItem'] = this.totalItem;
    data['quantity'] = this.quantity;
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
