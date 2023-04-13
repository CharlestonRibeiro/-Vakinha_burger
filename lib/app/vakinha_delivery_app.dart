import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/theme/theme_config.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/splash/splash_page.dart';

class VakinhaDeliveryApp extends StatelessWidget {
  const VakinhaDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeConfig.theme,
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}
