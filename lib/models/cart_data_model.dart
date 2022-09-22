class CartDataModel {
  List<Coupons>? coupons;
  List<ShippingRates>? shippingRates;
  ShippingAddress? shippingAddress;
  BillingAddress? billingAddress;
  List<ItemsOfCart>? items;
  int? itemsCount;
  int? itemsWeight;
  bool? needsPayment;
  bool? needsShipping;
  bool? hasCalculatedShipping;
  List<String>? fees;
  Total? totals;
  List<String>? errors;
  List<String>? paymentRequirements;
  Extensions? extensions;

  CartDataModel({this.coupons, this.shippingRates, this.shippingAddress, this.billingAddress, this.items, this.itemsCount, this.itemsWeight, this.needsPayment, this.needsShipping, this.hasCalculatedShipping, this.fees, this.totals, this.errors, this.paymentRequirements, this.extensions});

  CartDataModel.fromJson(Map<String, dynamic> json) {
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) { coupons!.add(new Coupons.fromJson(v)); });
    }
    if (json['shipping_rates'] != null) {
      shippingRates = <ShippingRates>[];
      json['shipping_rates'].forEach((v) { shippingRates!.add(new ShippingRates.fromJson(v)); });
    }
    shippingAddress = json['shipping_address'] != null ? new ShippingAddress.fromJson(json['shipping_address']) : null;
    billingAddress = json['billing_address'] != null ? new BillingAddress.fromJson(json['billing_address']) : null;
    if (json['items'] != null) {
      items = <ItemsOfCart>[];
      json['items'].forEach((v) { items!.add(new ItemsOfCart.fromJson(v)); });
    }
    itemsCount = json['items_count'];
    itemsWeight = json['items_weight'];
    needsPayment = json['needs_payment'];
    needsShipping = json['needs_shipping'];
    hasCalculatedShipping = json['has_calculated_shipping'];
    if (json['fees'] != null) {
      fees = [];
      json['fees'].forEach((v) { fees!.add(v); });
    }
    totals = json['totals'] != null ? new Total.fromJson(json['totals']) : null;
    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) { errors!.add(v); });
    }
    paymentRequirements = json['payment_requirements'].cast<String>();
    extensions = json['extensions'] != null ? new Extensions.fromJson(json['extensions']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    }
    if (this.shippingRates != null) {
      data['shipping_rates'] = this.shippingRates!.map((v) => v.toJson()).toList();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['items_count'] = this.itemsCount;
    data['items_weight'] = this.itemsWeight;
    data['needs_payment'] = this.needsPayment;
    data['needs_shipping'] = this.needsShipping;
    data['has_calculated_shipping'] = this.hasCalculatedShipping;
    if (this.fees != null) {
      data['fees'] = this.fees!.map((v) => v).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v).toList();
    }
    data['payment_requirements'] = this.paymentRequirements;
    if (this.extensions != null) {
      data['extensions'] = this.extensions!.toJson();
    }
    return data;
  }
}

class Coupons {
  String? code;
  String? discountType;
  Totals? totals;

  Coupons({this.code, this.discountType, this.totals});

  Coupons.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    discountType = json['discount_type'];
    totals = json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['discount_type'] = this.discountType;
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    return data;
  }
}

class Totals {
  String? totalDiscount;
  String? totalDiscountTax;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  Totals({this.totalDiscount, this.totalDiscountTax, this.currencyCode, this.currencySymbol, this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix});

  Totals.fromJson(Map<String, dynamic> json) {
    totalDiscount = json['total_discount'];
    totalDiscountTax = json['total_discount_tax'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_discount'] = this.totalDiscount;
    data['total_discount_tax'] = this.totalDiscount;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    return data;
  }
}

class ShippingRates {
  int? packageId;
  String? name;
  Destination? destination;
  List<ItemsShippingRates>? items;
  List<ShippingRate>? shippingRates;

  ShippingRates({this.packageId, this.name, this.destination, this.items, this.shippingRates});

  ShippingRates.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    name = json['name'];
    destination = json['destination'] != null ? new Destination.fromJson(json['destination']) : null;
    if (json['items'] != null) {
      items = <ItemsShippingRates>[];
      json['items'].forEach((v) { items!.add(new ItemsShippingRates.fromJson(v)); });
    }
    if (json['shipping_rates'] != null) {
      shippingRates = <ShippingRate>[];
      json['shipping_rates'].forEach((v) { shippingRates!.add(new ShippingRate.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['package_id'] = packageId;
    data['name'] = this.name;
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (shippingRates != null) {
      data['shipping_rates'] = shippingRates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Destination {
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  Destination({this.address1, this.address2, this.city, this.state, this.postcode, this.country});

  Destination.fromJson(Map<String, dynamic> json) {
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    return data;
  }
}

class ItemsShippingRates {
  String? key;
  String? name;
  int? quantity;

  ItemsShippingRates({this.key, this.name, this.quantity});

  ItemsShippingRates.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}

class ShippingRate {
  String? rateId;
  String? name;
  String? description;
  String? deliveryTime;
  String? price;
  String? taxes;
  int? instanceId;
  String? methodId;
  List<MetaData>? metaData;
  bool? selected;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  ShippingRate({this.rateId, this.name, this.description, this.deliveryTime, this.price, this.taxes, this.instanceId, this.methodId, this.metaData, this.selected, this.currencyCode, this.currencySymbol, this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix});

  ShippingRate.fromJson(Map<String, dynamic> json) {
    rateId = json['rate_id'];
    name = json['name'];
    description = json['description'];
    deliveryTime = json['delivery_time'];
    price = json['price'];
    taxes = json['taxes'];
    instanceId = json['instance_id'];
    methodId = json['method_id'];
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) { metaData!.add(new MetaData.fromJson(v)); });
    }
    selected = json['selected'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate_id'] = this.rateId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['delivery_time'] = this.deliveryTime;
    data['price'] = this.price;
    data['taxes'] = this.taxes;
    data['instance_id'] = this.instanceId;
    data['method_id'] = this.methodId;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    }
    data['selected'] = this.selected;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    return data;
  }
}

class MetaData {
  String? key;
  String? value;

  MetaData({this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class ShippingAddress {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? phone;

  ShippingAddress({this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.state, this.postcode, this.country, this.phone});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    return data;
  }
}

class BillingAddress {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  BillingAddress({this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.state, this.postcode, this.country, this.email, this.phone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class ItemsOfCart {
  String? key;
  int? id;
  int? quantity;
  QuantityLimits? quantityLimits;
  String? name;
  String? shortDescription;
  String? description;
  String? sku;
  String? lowStockRemaining;
  bool? backordersAllowed;
  bool? showBackorderBadge;
  bool? soldIndividually;
  String? permalink;
  List<Images>? images;
  List<String>? variation;
  List<String>? itemData;
  Prices? prices;
  TotalsItem? totals;
  String? catalogVisibility;
  Extensions? extensions;

  ItemsOfCart({this.key, this.id, this.quantity, this.quantityLimits, this.name, this.shortDescription, this.description, this.sku, this.lowStockRemaining, this.backordersAllowed, this.showBackorderBadge, this.soldIndividually, this.permalink, this.images, this.variation, this.itemData, this.prices, this.totals, this.catalogVisibility, this.extensions});

  ItemsOfCart.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    quantityLimits = json['quantity_limits'] != null ? new QuantityLimits.fromJson(json['quantity_limits']) : null;
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    sku = json['sku'];
    lowStockRemaining = json['low_stock_remaining'];
    backordersAllowed = json['backorders_allowed'];
    showBackorderBadge = json['show_backorder_badge'];
    soldIndividually = json['sold_individually'];
    permalink = json['permalink'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) { images!.add(new Images.fromJson(v)); });
    }
    if (json['variation'] != null) {
      variation = [];
      json['variation'].forEach((v) { variation!.add(v); });
    }
    if (json['item_data'] != null) {
      itemData =[];
      json['item_data'].forEach((v) { itemData!.add(v); });
    }
    prices = json['prices'] != null ? new Prices.fromJson(json['prices']) : null;
    totals = json['totals'] != null ? new TotalsItem.fromJson(json['totals']) : null;
    catalogVisibility = json['catalog_visibility'];
    extensions = json['extensions'] != null ? new Extensions.fromJson(json['extensions']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    if (this.quantityLimits != null) {
      data['quantity_limits'] = this.quantityLimits!.toJson();
    }
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['sku'] = this.sku;
    data['low_stock_remaining'] = this.lowStockRemaining;
    data['backorders_allowed'] = this.backordersAllowed;
    data['show_backorder_badge'] = this.showBackorderBadge;
    data['sold_individually'] = this.soldIndividually;
    data['permalink'] = this.permalink;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.variation != null) {
      data['variation'] = this.variation!.map((v) => v).toList();
    }
    if (this.itemData != null) {
      data['item_data'] = this.itemData!.map((v) => v).toList();
    }
    if (this.prices != null) {
      data['prices'] = this.prices!.toJson();
    }
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    data['catalog_visibility'] = this.catalogVisibility;
    if (this.extensions != null) {
      data['extensions'] = this.extensions!.toJson();
    }
    return data;
  }
}

class QuantityLimits {
  int? minimum;
  int? maximum;
  int? multipleOf;
  bool? editable;

  QuantityLimits({this.minimum, this.maximum, this.multipleOf, this.editable});

  QuantityLimits.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
    multipleOf = json['multiple_of'];
    editable = json['editable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    data['multiple_of'] = this.multipleOf;
    data['editable'] = this.editable;
    return data;
  }
}

class Images {
  int? id;
  String? src;
  String? thumbnail;
  String? srcset;
  String? sizes;
  String? name;
  String? alt;

  Images({this.id, this.src, this.thumbnail, this.srcset, this.sizes, this.name, this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    src = json['src'];
    thumbnail = json['thumbnail'];
    srcset = json['srcset'];
    sizes = json['sizes'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['thumbnail'] = this.thumbnail;
    data['srcset'] = this.srcset;
    data['sizes'] = this.sizes;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class Prices {
  String? price;
  String? regularPrice;
  String? salePrice;
  Null? priceRange;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;
  RawPrices? rawPrices;

  Prices({this.price, this.regularPrice, this.salePrice, this.priceRange, this.currencyCode, this.currencySymbol, this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix, this.rawPrices});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    priceRange = json['price_range'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
    rawPrices = json['raw_prices'] != null ? new RawPrices.fromJson(json['raw_prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['price_range'] = this.priceRange;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    if (this.rawPrices != null) {
      data['raw_prices'] = this.rawPrices!.toJson();
    }
    return data;
  }
}

class RawPrices {
  int? precision;
  String? price;
  String? regularPrice;
  String? salePrice;

  RawPrices({this.precision, this.price, this.regularPrice, this.salePrice});

  RawPrices.fromJson(Map<String, dynamic> json) {
    precision = json['precision'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precision'] = this.precision;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    return data;
  }
}

class TotalsItem {
  String? lineSubtotal;
  String? lineSubtotalTax;
  String? lineTotal;
  String? lineTotalTax;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  TotalsItem({this.lineSubtotal, this.lineSubtotalTax, this.lineTotal, this.lineTotalTax, this.currencyCode, this.currencySymbol, this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix});

  TotalsItem.fromJson(Map<String, dynamic> json) {
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'];
    lineTotalTax = json['line_total_tax'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line_subtotal'] = this.lineSubtotal;
    data['line_subtotal_tax'] = this.lineSubtotalTax;
    data['line_total'] = this.lineTotal;
    data['line_total_tax'] = this.lineTotalTax;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    return data;
  }
}

class Extensions {


  Extensions();

Extensions.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}


class Total {
  String? totalItems;
  String? totalItemsTax;
  String? totalFees;
  String? totalFeesTax;
  String? totalDiscount;
  String? totalDiscountTax;
  String? totalShipping;
  String? totalShippingTax;
  String? totalPrice;
  String? totalTax;
  List<String>? taxLines;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  Total({this.totalItems, this.totalItemsTax, this.totalFees, this.totalFeesTax, this.totalDiscount, this.totalDiscountTax, this.totalShipping, this.totalShippingTax, this.totalPrice, this.totalTax, this.taxLines, this.currencyCode, this.currencySymbol, this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix});

  Total.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalItemsTax = json['total_items_tax'];
    totalFees = json['total_fees'];
    totalFeesTax = json['total_fees_tax'];
    totalDiscount = json['total_discount'];
    totalDiscountTax = json['total_discount_tax'];
    totalShipping = json['total_shipping'];
    totalShippingTax = json['total_shipping_tax'];
    totalPrice = json['total_price'];
    totalTax = json['total_tax'];
    if (json['tax_lines'] != null) {
      taxLines = <String>[];
      json['tax_lines'].forEach((v) { taxLines!.add(v); });
    }
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    data['total_items_tax'] = this.totalItemsTax;
    data['total_fees'] = this.totalFees;
    data['total_fees_tax'] = this.totalFeesTax;
    data['total_discount'] = this.totalDiscount;
    data['total_discount_tax'] = this.totalDiscountTax;
    data['total_shipping'] = this.totalShipping;
    data['total_shipping_tax'] = this.totalShippingTax;
    data['total_price'] = this.totalPrice;
    data['total_tax'] = this.totalTax;
    if (this.taxLines != null) {
      data['tax_lines'] = this.taxLines!.map((v) => v).toList();
    }
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    return data;
  }
}
