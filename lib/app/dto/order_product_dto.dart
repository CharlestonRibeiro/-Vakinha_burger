import 'package:vakinha_burger_provider_com_bloc/app/models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amount;
  OrderProductDto({
    required this.product,
    required this.amount,
  });

  double get totalPrice => amount * product.price;

}
