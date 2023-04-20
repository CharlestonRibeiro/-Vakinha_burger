import 'package:vakinha_burger_provider_com_bloc/app/dto/order_dto.dart';
import 'package:vakinha_burger_provider_com_bloc/app/models/payment_types_model.dart';

abstract class OrderRepository {
  Future<List<PaymentTypesModel>> getAllPaymentTypes();
  Future<void> saveOrder(OrderDto order);
}