import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/provider/application_binding.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/theme/theme_config.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/home/home.page.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/home/home_router.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/product_detail/product_detail_page.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/product_detail/product_detail_router.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/splash/splash_page.dart';

class VakinhaDeliveryApp extends StatelessWidget {
  const VakinhaDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Delivery App',
        theme: ThemeConfig.theme,
        initialRoute: SplashPage.route,
        routes: {
         SplashPage.route : (context) => const SplashPage(),
         HomePage.route : (context) => HomeRouter.page,
         ProductDetailPage.route : (context) => ProductDetailRouter.page,
        },
      ),
    );
  }
}
