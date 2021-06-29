// To parse this JSON data, do
//
//     final orderList = orderListFromJson(jsonString);

import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
  OrderList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.products,
    this.email,
    this.contactNumber,
    this.paymentType,
    this.shippingAddress,
    this.billingAddress,
    this.address,
    this.city,
  });

  int id;
  List<Product> products;
  String email;
  String contactNumber;
  String paymentType;
  String shippingAddress;
  String billingAddress;
  String address;
  String city;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        email: json["email"],
        contactNumber: json["contact_number"],
        paymentType: json["payment_type"],
        shippingAddress: json["shipping_address"],
        billingAddress: json["billing_address"],
        address: json["address"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "email": email,
        "contact_number": contactNumber,
        "payment_type": paymentType,
        "shipping_address": shippingAddress,
        "billing_address": billingAddress,
        "address": address,
        "city": city,
      };
}

class Product {
  Product({
    this.id,
    this.product,
    this.variant,
    this.quantity,
    this.productName,
  });

  int id;
  int product;
  int variant;
  int quantity;
  String productName;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      product: json["product"],
      variant: json["variant"],
      quantity: json["quantity"],
      productName: json["product_name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "variant": variant,
        "quantity": quantity,
        "product_name": productName,
      };
}
