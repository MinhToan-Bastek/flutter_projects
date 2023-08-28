import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String image;
  String id;
  String name;
  double price;
  String description;
  String status;
  bool isFavourite;

  int? qty;
  ProductModel({
    required this.image,
    required this.id,
    required this.isFavourite,
    required this.name,
    required this.price,
    required this.description,
    required this.status,
    this.qty,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    name: json['name'],
    // name: (json['name'] ?? '').toString(),
    description: json['description'] ,
    image: json['image'],
    isFavourite:false ,
    qty: json['qty'],
    price: double.parse(json['price'].toString()),
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    //     // "name": name,
    //     // "image": image,
    //     // "description": description,
    //     // "isFavourite": isFavourite,
    //     // "price": price,
    //     // "status": status,
    'id': id,
    'name': name,
    'description': description,
    'image': image,
    'isFavorite': isFavourite,
    'price': price,
    'qty': qty,
  };
  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        image: image,
        id: id,
        name: name,
        price: price,
        description: description,
        isFavourite: isFavourite,
        qty: qty??this.qty,
        status: status
      );
}