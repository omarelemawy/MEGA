import 'category_model.dart';

class ReviewProductModel {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  int? productId;
  String? productName;
  String? productPermalink;
  String? status;
  String? reviewer;
  String? reviewerEmail;
  String? review;
  int? rating;
  bool? verified;
  ReviewerAvatarUrls? reviewerAvatarUrls;
  Links? lLinks;

  ReviewProductModel(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.productId,
        this.productName,
        this.productPermalink,
        this.status,
        this.reviewer,
        this.reviewerEmail,
        this.review,
        this.rating,
        this.verified,
        this.reviewerAvatarUrls,
        this.lLinks});

  ReviewProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    productId = json['product_id'];
    productName = json['product_name'];
    productPermalink = json['product_permalink'];
    status = json['status'];
    reviewer = json['reviewer'];
    reviewerEmail = json['reviewer_email'];
    review = json['review'];
    rating = json['rating'];
    verified = json['verified'];
    reviewerAvatarUrls = json['reviewer_avatar_urls'] != null
        ? new ReviewerAvatarUrls.fromJson(json['reviewer_avatar_urls'])
        : null;
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_permalink'] = this.productPermalink;
    data['status'] = this.status;
    data['reviewer'] = this.reviewer;
    data['reviewer_email'] = this.reviewerEmail;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['verified'] = this.verified;
    if (this.reviewerAvatarUrls != null) {
      data['reviewer_avatar_urls'] = this.reviewerAvatarUrls!.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class ReviewerAvatarUrls {
  String? s24;
  String? s48;
  String? s96;

  ReviewerAvatarUrls({this.s24, this.s48, this.s96});

  ReviewerAvatarUrls.fromJson(Map<String, dynamic> json) {
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

class Links {
  List<Self>? self;
  List<Collection>? collection;
  List<Collection>? up;

  Links({this.self, this.collection, this.up});

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
    if (json['up'] != null) {
      up = <Collection>[];
      json['up'].forEach((v) {
        up!.add(new Collection.fromJson(v));
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
    if (this.up != null) {
      data['up'] = this.up!.map((v) => v.toJson()).toList();
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
