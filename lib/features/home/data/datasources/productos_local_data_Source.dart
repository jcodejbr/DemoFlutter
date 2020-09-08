import 'package:servicio/core/sqlLite/db.dart';
import 'package:servicio/features/home/data/models/producto_model.dart';
import 'package:servicio/features/home/domain/Entities/producto.dart';

abstract class ProductoLocalDataSource {
  Future<List<ProductoModel>> recuperarProductos();
  Future<ProductoModel> crearProducto(Producto producto);
}

class ProductoLocalDataSourceImple implements ProductoLocalDataSource {
  ProductoLocalDataSourceImple();

  @override
  Future<ProductoModel> crearProducto(Producto producto) async {
    final data = await ClientDatabaseProvider.db.addClientToDatabase(producto);
    return ProductoModel(
        nombre: data.nombre,
        descripcion: data.descripcion,
        productoId: data.id.toString(),
        urlImg: data.urlImg);
  }

  @override
  Future<List<ProductoModel>> recuperarProductos() async {
    return await ClientDatabaseProvider.db.getAllProducts();
  }
}
