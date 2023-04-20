import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/global/global_context.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/provider/application_binding.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/theme/theme_config.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/login/login_page.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/login/login_router.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/register/register_page.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/register/register_router.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/home/home.page.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/home/home_router.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/order_completed.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/order_page.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/order/order_router.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/product_detail/product_detail_page.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/product_detail/product_detail_router.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/splash/splash_page.dart';

class VakinhaDeliveryApp extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();
  VakinhaDeliveryApp({super.key}) {
    GlobalContext.i.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Delivery App',
        theme: ThemeConfig.theme,
        navigatorKey: _navKey,
        initialRoute: SplashPage.route,
        routes: {
          SplashPage.route: (context) => const SplashPage(),
          HomePage.route: (context) => HomeRouter.page,
          ProductDetailPage.route: (context) => ProductDetailRouter.page,
          LoginPage.route: (context) => LoginRouter.page,
          RegisterPage.route: (context) => RegisterRouter.page,
          OrderPage.route: (context) => OrderRouter.page,
          OrderCompleted.route: (context) => const OrderCompleted(),
        },
      ),
    );
  }
}
