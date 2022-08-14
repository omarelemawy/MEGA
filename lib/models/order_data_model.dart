import 'address_model.dart';

class OrderData {
  String? orderId;
  String? orderDescription;
  String? orderAmount;
  String? state;
  String? postalCode;
  String? customColor;
  String? country;
  String? currencyCode;
  String? customerUniqueReference;
  Customer? customer;
  Address? address;

  OrderData(
      {this.orderId,
        this.orderDescription,
        this.orderAmount,
        this.state,
        this.postalCode,
        this.customColor,
        this.country,
        this.currencyCode,
        this.customerUniqueReference,
        this.customer,this.address});


  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderDescription = json['orderDescription'];
    orderAmount = json['orderAmount'];
    state = json['state'];
    postalCode = json['postalCode'];
    customColor = json['customColor'];
    country = json['country'];
    currencyCode = json['currencyCode'];
    customerUniqueReference = json['customerUniqueReference'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderDescription'] = this.orderDescription;
    data['orderAmount'] = this.orderAmount;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['customColor'] = this.customColor;
    data['country'] = this.country;
    data['currencyCode'] = this.currencyCode;
    data['customerUniqueReference'] = this.customerUniqueReference;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? name;
  String? email;
  String? mobile;
  String? code;
  String? address;
  String? city;

  Customer(
      {this.name, this.email, this.mobile, this.code, this.address, this.city});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    code = json['code'];
    address = json['address'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['code'] = this.code;
    data['address'] = this.address;
    data['city'] = this.city;
    return data;
  }
}
