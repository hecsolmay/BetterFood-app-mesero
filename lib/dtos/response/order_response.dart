// To parse this JSON data, do
//
//     final orderResponseDto = orderResponseDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderResponseDto orderResponseDtoFromJson(String str) =>
    OrderResponseDto.fromJson(json.decode(str));

class OrderResponseDto {
  OrderResponseDto({
    required this.order,
    required this.paid,
    required this.canceled,
    required this.moneyReceived,
    required this.createdAt,
    required this.updatedAt,
    required this.change,
    required this.id,
  });

  Order order;
  bool paid;
  bool canceled;
  int moneyReceived;
  DateTime createdAt;
  DateTime updatedAt;
  int change;
  String id;

  factory OrderResponseDto.fromJson(Map<String, dynamic> json) =>
      OrderResponseDto(
        order: Order.fromJson(json["order"]),
        paid: json["paid"],
        canceled: json["canceled"],
        moneyReceived: json["moneyReceived"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        change: json["change"],
        id: json["id"],
      );
}

class Order {
  Order({
    required this.products,
    required this.waiterId,
    required this.status,
    required this.tableId,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.totalQuantity,
    required this.orderNumber,
    required this.id,
  });

  List<ProductElement> products;
  WaiterId waiterId;
  String status;
  TableId tableId;
  int total;
  DateTime createdAt;
  DateTime updatedAt;
  int totalQuantity;
  String orderNumber;
  String id;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
        waiterId: WaiterId.fromJson(json["waiterId"]),
        status: json["status"],
        tableId: TableId.fromJson(json["tableId"]),
        total: json["total"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        totalQuantity: json["totalQuantity"],
        orderNumber: json["orderNumber"],
        id: json["id"],
      );
}

class ProductElement {
  ProductElement({
    required this.product,
    required this.quantity,
    this.extras,
    this.remove,
  });

  ProductProduct product;
  int quantity;
  List<Extra>? extras = [];
  List<Remove>? remove = [];

  factory ProductElement.fromJson(Map<String, dynamic> json) {
    List<Extra> jsonExtras = [];
    List<Remove> jsonRemove = [];
    if (json['extras'] != null) {
      jsonExtras =
          List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x)));
    }

    if (json['remove'] != null) {
      jsonRemove =
          List<Remove>.from(json["remove"].map((x) => Remove.fromJson(x)));
    }

    return ProductElement(
      product: ProductProduct.fromJson(json["product"]),
      quantity: json["quantity"],
      extras: jsonExtras,
      remove: jsonRemove,
    );
  }
}

class Extra {
  Extra({
    required this.id,
    required this.name,
    required this.extraPrice,
  });

  String id;
  String name;
  int extraPrice;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
        extraPrice: json["extraPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "extraPrice": extraPrice,
      };
}

class ProductProduct {
  ProductProduct({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.description,
    required this.price,
    required this.ofert,
  });

  String id;
  String name;
  String imgUrl;
  String description;
  int price;
  int ofert;

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["id"],
        name: json["name"],
        imgUrl: json["imgURL"],
        description: json["description"],
        price: json["price"],
        ofert: json["ofert"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imgURL": imgUrl,
        "description": description,
        "price": price,
        "ofert": ofert,
      };
}

class Remove {
  Remove({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Remove.fromJson(Map<String, dynamic> json) => Remove(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class TableId {
  TableId({
    required this.numMesa,
    required this.capacity,
    required this.id,
  });

  int numMesa;
  int capacity;
  String id;

  factory TableId.fromJson(Map<String, dynamic> json) => TableId(
        numMesa: json["numMesa"],
        capacity: json["capacity"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "numMesa": numMesa,
        "capacity": capacity,
        "id": id,
      };
}

class WaiterId {
  WaiterId({
    required this.name,
    required this.lastName,
    required this.id,
  });

  String name;
  String lastName;
  String id;

  factory WaiterId.fromJson(Map<String, dynamic> json) => WaiterId(
        name: json["name"],
        lastName: json["lastName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "id": id,
      };
}
