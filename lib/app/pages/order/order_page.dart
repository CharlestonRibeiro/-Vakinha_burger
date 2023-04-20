import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/extensions/formatter_extension.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/base_state/base_state.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/images/images.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_burger_provider_com_bloc/app/dto/order_product_dto.dart';
import 'package:vakinha_burger_provider_com_bloc/app/models/payment_types_model.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/order_completed.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/widgets/order_field.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/order_controller.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/order_state.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/widgets/order_product_tile.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/widgets/payment_types_field.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatefulWidget {

  const OrderPage({ super.key });

  static const route = 'OrderPage';
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final _formKey = GlobalKey<FormState>();
  final _addressEC = TextEditingController();
  final _documentEC = TextEditingController();
  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    super.onReady();
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  void _showConfirmProductDialog(OrderConfirmDeleteProductState state) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            'Deseja excluir o produto ${state.orderProduct.product.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.cancelDeleteProcess();
            },
            child: Text(
              'Cancelar',
              style: context.textStyles.textBold.copyWith(
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.decrementProduct(state.index);
            },
            child: Text(
              'Confirmar',
              style: context.textStyles.textBold,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: hideLoader,
          loading: showLoader,
          error: () {
            hideLoader();
            showError(state.errorMessage ?? 'Erro não informado');
          },
          confirmRemoveProduct: () {
            hideLoader();
            if (state is OrderConfirmDeleteProductState) {
              _showConfirmProductDialog(state);
            }
          },
          emptyCart: () {
            showInfo(
                'Seu carrinho está vazio. Por favor selecione um produto para realizar seu pedido');
            Navigator.pop(context, <OrderProductDto>[]);
          },
          success: () {
            hideLoader();
            Navigator.of(context).popAndPushNamed( OrderCompleted.route, result: <OrderProductDto>[]);
          },
        );
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProducts);
          return false;
        },
        child: Scaffold(
          appBar: DeliveryAppbar(),
          body: Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Carrinho',
                          style: context.textStyles.textTitle,
                        ),
                        IconButton(
                          onPressed: controller.emptyCart,
                          icon: Image.asset(Images.trashRegular),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocSelector<OrderController, OrderState,
                    List<OrderProductDto>>(
                  selector: (state) => state.orderProducts,
                  builder: (context, orderProducts) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: orderProducts.length,
                        (context, index) {
                          final orderProduct = orderProducts[index];
                          return Column(
                            children: [
                              OrderProductTile(
                                index: index,
                                orderProduct: orderProduct,
                              ),
                              const Divider(color: Colors.grey),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total do pedido',
                              style: context.textStyles.textExtraBold
                                  .copyWith(fontSize: 16),
                            ),
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (context, total) {
                                return Text(
                                  total.currencyPTBR,
                                  style: context.textStyles.textExtraBold
                                      .copyWith(fontSize: 20),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OrderField(
                        title: 'Endereço de entrega',
                        controller: _addressEC,
                        validator:
                            Validatorless.required('Endereço obrigatório'),
                        hintText: 'Digite o endereço',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OrderField(
                        cpf: true,
                        title: 'CPF',
                        controller: _documentEC,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('CPF obrigatório'),
                            Validatorless.cpf('CPF inválido'),
                          ],
                        ),
                        hintText: 'Digite o CPF',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypesModel>>(
                        selector: (state) => state.paymentTypes,
                        builder: (context, paymentTypes) {
                          return ValueListenableBuilder(
                            valueListenable: paymentTypeValid,
                            builder: (BuildContext context,
                                    paymentTypeValidValue, Widget? child) =>
                                PaymentTypesField(
                              valid: paymentTypeValidValue,
                              valueSelected: paymentTypeId.toString(),
                              valueChanged: (value) => paymentTypeId = value,
                              paymentTypes: paymentTypes,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DeliveryButton(
                          customWidth: double.infinity,
                          customHeight: 48,
                          customLabel: 'FINALIZAR',
                          customOnPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;
                            final paymentTypeSelected = paymentTypeId != null;
                            paymentTypeValid.value = paymentTypeSelected;

                            if (valid && paymentTypeSelected) {
                              controller.saveOrder(
                                address: _addressEC.text,
                                document: _documentEC.text,
                                paymentMethodId: paymentTypeId!,
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}