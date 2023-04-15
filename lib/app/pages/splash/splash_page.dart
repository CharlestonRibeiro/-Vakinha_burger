import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/helpers/size_extensions.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/images/images.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/home/home.page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const route = 'SplashPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColoredBox(
          color: const Color(0XFF140E0E),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: context.screenWidth,
                    child: Image.asset(
                      Images.lanche,
                      fit: BoxFit.cover,
                    )),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: context.percentHeight(.20)),
                    Image.asset(Images.logo),
                    SizedBox(height: context.percentHeight(.20)),
                    DeliveryButton(
                        customWidth: context.percentWidth(.60),
                        customHeight: context.percentHeight(.06),
                        customOnPressed: () {
                          Navigator.of(context).popAndPushNamed(HomePage.route);
                        },
                        customLabel: 'Acessar'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
