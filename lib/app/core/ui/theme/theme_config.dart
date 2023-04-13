import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/app_styles.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/colors_app.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defaulInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: Colors.grey[400]!));

  static final theme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black)),
      primaryColor: ColorsApp.instance.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsApp.instance.primary,
        primary: ColorsApp.instance.primary,
        secondary: ColorsApp.instance.secondary,
      ),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: AppStyles.instance.primaryButton),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.all(13),
          border: _defaulInputBorder,
          enabledBorder: _defaulInputBorder,
          focusedBorder: _defaulInputBorder,
          labelStyle:
              TextStyles.instance.textRegular.copyWith(color: Colors.black),
          errorStyle: TextStyles.instance.textRegular
              .copyWith(color: Colors.redAccent)));
}
