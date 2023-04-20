import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/helpers/size_extensions.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/images/images.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/widgets/delivery_button.dart';

class OrderCompleted extends StatelessWidget {
  const OrderCompleted({super.key});

  static const route = 'OrderCompleted';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentHeight(.2),
              ),
              Image.asset(Images.logoRounded),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pedido realizado com sucesso. Em breve você receberá a confirmação do seu pedido',
                textAlign: TextAlign.center,
                style: context.textStyles.textExtraBold.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              DeliveryButton(
                customWidth: context.percentWidth(.8),
                customLabel: 'FECHAR',
                customOnPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}