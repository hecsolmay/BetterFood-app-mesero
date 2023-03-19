// To parse this JSON data, do
//
//     final orderResponseDto = orderResponseDtoFromJson(jsonString);

import 'dart:convert';

OrderResponseDto orderResponseDtoFromJson(String str) => OrderResponseDto.fromJson(json.decode(str));

String orderResponseDtoToJson(OrderResponseDto data) => json.encode(data.toJson());

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

    final Order order;
    final bool paid;
    final bool canceled;
    final int moneyReceived;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int change;
    final String id;

    factory OrderResponseDto.fromJson(Map<String, dynamic> json) => OrderResponseDto(
        order: Order.fromJson(json["order"]),
        paid: json["paid"],
        canceled: json["canceled"],
        moneyReceived: json["moneyReceived"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        change: json["change"],
        id: json["id"],
    );

    factory OrderResponseDto.fromMap(Map<String, dynamic> json) => OrderResponseDto(
        order: Order.fromMap(json["order"]),
        paid: json["paid"],
        canceled: json["canceled"],
        moneyReceived: json["moneyReceived"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        change: json["change"],
        id: json["id"],
    );

  get lenght => null;


    Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "paid": paid,
        "canceled": canceled,
        "moneyReceived": moneyReceived,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "change": change,
        "id": id,
    };
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

    final List<ProductElement> products;
    final WaiterId waiterId;
    final String status;
    final TableId tableId;
    final int total;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int totalQuantity;
    final String orderNumber;
    final String id;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
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
    factory Order.fromMap(Map<String, dynamic> json) => Order(
        products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
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

    



    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "waiterId": waiterId.toJson(),
        "status": status,
        "tableId": tableId.toJson(),
        "total": total,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "totalQuantity": totalQuantity,
        "orderNumber": orderNumber,
        "id": id,
    };
}

class ProductElement {
    ProductElement({
        required this.product,
        required this.quantity,
        required this.extras,
        required this.remove,
    });

    final ProductProduct product;
    final int quantity;
    final List<Extra> extras;
    final List<dynamic> remove;

    factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductProduct.fromJson(json["product"]),
        quantity: json["quantity"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        remove: List<dynamic>.from(json["remove"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
        "remove": List<dynamic>.from(remove.map((x) => x)),
    };
}

class Extra {
    Extra({
        required this.id,
        required this.extraPrice,
    });

    final String id;
    final int extraPrice;

    factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        extraPrice: json["extraPrice"],
    );
    factory Extra.fromMap(Map<String, dynamic> json) => Extra(
        id: json["id"],
        extraPrice: json["extraPrice"],
    );


    Map<String, dynamic> toJson() => {
        "id": id,
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

    final String id;
    final String name;
    final String imgUrl;
    final String description;
    final int price;
    final int ofert;

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

class TableId {
    TableId({
        required this.numMesa,
        required this.capacity,
        required this.id,
    });

    final int numMesa;
    final int capacity;
    final String id;

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

    final String name;
    final String lastName;
    final String id;

    factory WaiterId.fromJson(Map<String, dynamic> json) => WaiterId(
        name: json["name"],
        lastName: json["lastName"],
        id: json["id"],
    );

    factory WaiterId.fromMap(Map<String, dynamic> json) => WaiterId(
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
