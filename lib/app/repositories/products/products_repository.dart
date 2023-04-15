import 'package:vakinha_burger_provider_com_bloc/app/models/product_model.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> findAllProducts();
}
