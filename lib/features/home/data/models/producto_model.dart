
class ProductoModel{
  final String productoId;
  final String nombre;
  final String descripcion;
  final String urlImg;

  ProductoModel({
    this.productoId,
    this.nombre,
    this.descripcion,
    this.urlImg,
  });
  // super(productoId: productoId, nombre: nombre, descripcion: descripcion, urlImg: urlImg);

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      productoId: json['productoId'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      urlImg: json['urlImg'],
    );
  }

  factory ProductoModel.fromMap(Map<String, dynamic> json) => new ProductoModel(
        productoId: json["id"].toString(),
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        urlImg: json["urlimg"]
      );

  Map<String, dynamic> toJson() {
    return {
      'productoId': productoId,
      'nombre': nombre,
      'descripcion': descripcion,
      'urlImg': urlImg,
    };
  }
}