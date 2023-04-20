import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:vakinha_burger_provider_com_bloc/app/dto/order_product_dto.dart';
import 'package:vakinha_burger_provider_com_bloc/app/models/payment_types_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  ready,
  loading,
  error,
  updateOrder,
  confirmRemoveProduct,
  emptyCart,
  success,
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final List<PaymentTypesModel> paymentTypes;
  final String? errorMessage;

  const OrderState({
    required this.status,
    required this.orderProducts,
    required this.paymentTypes,
    this.errorMessage,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        orderProducts = const [],
        paymentTypes = const [],
        errorMessage = null;

  @override
  List<Object?> get props =>
      [status, orderProducts, paymentTypes, errorMessage];

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProductDto>? orderProducts,
    List<PaymentTypesModel>? paymentTypes,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderProducts: orderProducts ?? this.orderProducts,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  double get totalOrder =>
      orderProducts.fold(0, (total, product) => total + product.totalPrice);
}

class OrderConfirmDeleteProductState extends OrderState {
  final OrderProductDto orderProduct;
  final int index;

  const OrderConfirmDeleteProductState({
    required super.status,
    required super.orderProducts,
    required super.paymentTypes,
    required this.orderProduct,
    required this.index,
    super.errorMessage,
  });
}