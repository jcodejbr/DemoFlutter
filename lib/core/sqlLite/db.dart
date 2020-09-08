import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servicio/features/home/data/models/producto_model.dart';
import 'package:servicio/features/home/domain/Entities/producto.dart';
import 'package:sqflite/sqflite.dart';

class ClientDatabaseProvider {
  ClientDatabaseProvider._();

  static final ClientDatabaseProvider db = ClientDatabaseProvider._();
  Database _database;

  //para evitar que abra varias conexciones una y otra vez podemos usar algo como esto..
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstanace();
    return _database;
  }

  Future<Database> getDatabaseInstanace() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "client.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE producto ("
          "id integer primary key,"
          "nombre TEXT,"
          "descripcion TEXT,"
          "urlimg TEXT"
          ")");
    });
  }

  //Query
  Future<List<ProductoModel>> getAllProducts() async {
    final db = await database;
    var response = await db.query("producto");
    List<ProductoModel> list = response.map((c) => ProductoModel.fromMap(c)).toList();
    return list;
  }

  //Insert
  Future<Producto> addClientToDatabase(Producto client) async {
    try {
      final db = await database;
      var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM producto");
      int id = table.first["id"];
      client.id = id;
      var raw = await db.insert(
        "producto",
        client.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return client;
    } catch (ex) {
      print(ex);
    }
  }
}

class Client {
  int id;
  String name;
  String phone;

  Client({this.id, this.name, this.phone});

  //To insert the data in the bd, we need to convert it into a Map
  //Para insertar los datos en la bd, necesitamos convertirlo en un Map
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
      };

  //to receive the data we need to pass it from Map to json
  //para recibir los datos necesitamos pasarlo de Map a json
  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
      );
}
