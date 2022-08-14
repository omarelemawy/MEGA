
class ProductsCategoryModel {
  String? status;
  String? message;
  List<ProductsModel>? data;

  ProductsCategoryModel({this.status, this.message, this.data});

  ProductsCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductsModel>[];
      json['data'].forEach((v) { data!.add(new ProductsModel.fromJson(v)); });
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

class ProductsModel {
  int? id;
  String? name;
  Thumbnail? thumbnail;
  List<Photo>? photos;
  String? price;
  String? offer;
  String? isLiked;


  ProductsModel({this.id, this.name, this.thumbnail, this.photos, this.price, this.offer,this.isLiked});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'] != null ?  Thumbnail.fromJson(json['thumbnail']) : null;
    if (json['photos'] != null) {
      photos = <Photo>[];
      json['photos'].forEach((v) { photos!.add( Photo.fromJson(v)); });
    }
    price = json['price'];
    offer = json['offer'];
    isLiked = json['isLiked'];
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
class Photo {
  String? name;
  int? defaultItem;
  String? url;

  Photo({this.name, this.defaultItem, this.url});

  Photo.fromJson(Map<String, dynamic> json) {
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
