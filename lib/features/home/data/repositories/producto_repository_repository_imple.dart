import 'package:flutter/cupertino.dart';
import 'package:servicio/core/network/network_info.dart';
import 'package:servicio/features/home/data/datasources/productos_local_data_Source.dart';
import 'package:servicio/features/home/data/models/producto_model.dart';
import 'package:servicio/features/home/data/datasources/productos_remote_data_Source.dart';
import 'package:servicio/features/home/domain/Entities/producto.dart';
import 'package:servicio/features/home/domain/repositories/producto_repository.dart';

class ProductoRepositoryImple implements ProductoRepository {
  final ProductoRemoteDataSource remoteDataSource;
  final ProductoLocalDataSource localDataSource;

  final NetworkInfo networkInfo;

  ProductoRepositoryImple(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<List<ProductoModel>> getProductos() async {
    // if (await networkInfo.isConnected) {
      return remoteDataSource.recuperarProductos();
    // } else {
      // return localDataSource.recuperarProductos();
    // }
  }

  @override
  Future<ProductoModel> crearProducto(Producto producto) async {
    // if (await networkInfo.isConnected) {
      return remoteDataSource.crearProducto(producto);
    // } else {
      // return localDataSource.crearProducto(producto);
    // }
  }

  @override
  Future<ProductoModel> desactivarProducto(String productoId) {
    return remoteDataSource.desactivarProducto(productoId);
  }
}
