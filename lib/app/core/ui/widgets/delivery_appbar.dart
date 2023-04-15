import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/images/images.dart';

class DeliveryAppbar extends AppBar {
  
  DeliveryAppbar({
    super.key,
    double elevation = 1,
    }) : super(
      elevation: elevation,
      title: Image.asset(Images.logo, width: 80,)
    ) ;
  
}