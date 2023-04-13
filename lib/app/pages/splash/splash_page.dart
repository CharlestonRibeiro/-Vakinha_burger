import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DeliveryButton(
              customLabel: 'Teste label',
              customOnPressed: (){},
              customHeight: 200,
              customWidth: 200,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Text')
              ),
            ],
        ),
      ),
    );
  }
}
