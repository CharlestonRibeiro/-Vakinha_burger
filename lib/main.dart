import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/config/env/env.dart';
import 'package:vakinha_burger_provider_com_bloc/app/vakinha_delivery_app.dart';

Future<void> main() async {
  await Env.instance.load();
  runApp( VakinhaDeliveryApp());
}
