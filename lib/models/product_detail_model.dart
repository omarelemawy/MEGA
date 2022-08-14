import 'package:gnon/models/product_model.dart';
import 'package:gnon/models/user_data.dart';

class ProductDetailsModel {
  String? status;
  String? message;
  ProductDetails? data;

  ProductDetailsModel({this.status, this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ProductDetails.fromJson(json['data']) : null;
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

class ProductDetails {
  Product? product;
  List<ProductsModel>? related;
  List<Reviews>? reviews;
  double? reviewTotal;

  ProductDetails({this.product, this.related, this.reviews, this.reviewTotal});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['related'] != null) {
      related = <ProductsModel>[];
      json['related'].forEach((v) { related!.add( ProductsModel.fromJson(v)); });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) { reviews!.add(new Reviews.fromJson(v)); });
    }
    reviewTotal = json['reviewTotal'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.related != null) {
      data['related'] = this.related!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['reviewTotal'] = this.reviewTotal;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  Thumbnail? thumbnail;
  List<Photos>? photos;
  String? price;
  String? description;
  String? offer;
  String? isLiked;


  Product({this.id, this.name, this.thumbnail, this.photos, this.price,
    this.offer,this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'] ?? "";
    thumbnail = json['thumbnail'] != null ?  Thumbnail.fromJson(json['thumbnail']) : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) { photos!.add( Photos.fromJson(v)); });
    }
    price = json['price'];
    offer = json['offer'];
    isLiked = json['isLiked'];
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

class Related {
  int? id;
  String? name;
  Thumbnail? thumbnail;
  List<Photos>? photos;
  String? price;
  String? offer;

  Related({this.id, this.name, this.thumbnail, this.photos, this.price, this.offer});

  Related.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'] != null ? new Thumbnail.fromJson(json['thumbnail']) : null;
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
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
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
  int? defaultItem;
  String? url;

  Photos({this.name, this.defaultItem, this.url});

  Photos.fromJson(Map<String, dynamic> json) {
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



class Reviews {
  int? id;
  String? productId;
  String? rate;
  String? userId;
  UserDateModel? user;
  String? comment;
  String? status;
  String? createdAt;
  String? updatedAt;

  Reviews({this.id, this.productId, this.rate, this.userId, this.comment,
    this.status, this.createdAt, this.updatedAt,this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    rate = json['rate'];
    userId = json['user_id'];
    user = json['user']!= null ?  UserDateModel.fromJson(json['user']) : null;
    comment = json['comment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['rate'] = this.rate;
    data['user_id'] = this.userId;
    data['user'] = this.user;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
