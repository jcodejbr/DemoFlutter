// import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:meta/meta.dart';

class Producto{
  int id;
  final String nombre;
  final String descripcion;
  final String urlImg;

  Producto({
    this.id,
    @required this.nombre,
    @required this.descripcion,
    @required this.urlImg
  });

//To insert the data in the bd, we need to convert it into a Map
  //Para insertar los datos en la bd, necesitamos convertirlo en un Map
  Map<String, dynamic> toMap() => {
    "id": id,
    "nombre": nombre,
    "descripcion": descripcion,
    "urlimg": urlImg,
  };

   String toJsonEncode() {
    return jsonEncode(<String, String>{
      'nombre': nombre,
      'descripcion': descripcion,
      'urlImg': urlImg,
    });
  }

  factory Producto.fromMap(Map<String, dynamic> json) => new Producto(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        urlImg: json["urlimg"]
      );
}