import 'dart:convert';

ProductModel poductModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.idProducto,
    this.nombreProducto,
    this.precio,
    this.image,
    this.nameImage,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String idProducto;
  String nombreProducto;
  int precio;
  String image;
  String nameImage;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        idProducto: json["id_producto"],
        nombreProducto: json["nombre_producto"],
        precio: json["precio"],
        image: json["image"],
        nameImage: json["name_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_producto": idProducto,
        "nombre_producto": nombreProducto,
        "precio": precio,
        "image": image,
        "name_image": nameImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
