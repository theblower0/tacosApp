class Detail {
  Detail({
    this.id,
    this.idProducto,
    this.ordersId,
    this.nombreProducto,
    this.cantidad,
    this.precio,
    this.subtotal,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String idProducto;
  int ordersId;
  String nombreProducto;
  int cantidad;
  int precio;
  String subtotal;
  DateTime createdAt;
  DateTime updatedAt;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        idProducto: json["id_producto"],
        ordersId: json["orders_id"],
        nombreProducto: json["nombre_producto"],
        cantidad: json["cantidad"],
        precio: json["precio"],
        subtotal: json["subtotal"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_producto": idProducto,
        "orders_id": ordersId,
        "nombre_producto": nombreProducto,
        "cantidad": cantidad,
        "precio": precio,
        "subtotal": subtotal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
