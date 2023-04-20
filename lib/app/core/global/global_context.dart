import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/home/home.page.dart';

class GlobalContext {
  //! Atenção! Nunca deixar o _navigatorKey como público!!!
  late final GlobalKey<NavigatorState> _navigatorKey;

  static GlobalContext? _instance;

  GlobalContext._();

  static GlobalContext get i => _instance ??= GlobalContext._();

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  Future<void> loginExpire() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
    showTopSnackBar(
      _navigatorKey.currentState!.overlay!,
      const CustomSnackBar.error(
        message: 'Login expirado. Clique no carrinho novamente',
        backgroundColor: Colors.black,
      ),
    );
    _navigatorKey.currentState!.popUntil(ModalRoute.withName(HomePage.route));
  }
}