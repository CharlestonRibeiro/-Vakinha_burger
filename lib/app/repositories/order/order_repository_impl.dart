import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/exceptions/repository_exception.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_burger_provider_com_bloc/app/dto/order_dto.dart';
import 'package:vakinha_burger_provider_com_bloc/app/models/payment_types_model.dart';

import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypesModel>> getAllPaymentTypes() async {
    try {
      final result = await dio.auth().get('/payment-types');
      return result.data
          .map<PaymentTypesModel>((e) => PaymentTypesModel.fromMap(e))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar formas de pagamento');
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await dio.auth().post(
        '/orders',
        data: {
          'products': order.products
              .map(
                (e) => {
                  'id': e.product.id,
                  'amount': e.amount,
                  'total_price': e.totalPrice
                },
              )
              .toList(),
          'user_id': '#userAuthRef',
          'address': order.address,
          'CPF': order.document,
          'payment_method_id': order.paymentMethodId
        },
      );
    } on DioError catch (e, s) {
      log('Erro ao registrar pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar pedido');
    }
  }
}