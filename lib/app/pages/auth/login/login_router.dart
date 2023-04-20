import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/login/login_controller.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/login/login_page.dart';
import 'package:vakinha_burger_provider_com_bloc/app/repositories/auth/auth_repository.dart';
import 'package:vakinha_burger_provider_com_bloc/app/repositories/auth/auth_repository_impl.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(providers: [
        Provider<AuthRepository>(
            create: (context) => AuthRepositoryImpl(dio: context.read())),
        Provider(
          create: (context) => LoginController(context.read()),
        )
      ],
      child: const LoginPage(),
      );
}
