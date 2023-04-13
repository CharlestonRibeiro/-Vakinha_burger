import 'package:flutter/material.dart';

class DeliveryButton extends StatelessWidget {
  final VoidCallback? customOnPressed;
  final String customLabel;
  final double? customWidth;
  final double? customHeight;


  const DeliveryButton({
    Key? key,
    required this.customOnPressed,
    required this.customLabel,
    this.customWidth,
    this.customHeight = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: customHeight,
      width: customWidth,
      child: ElevatedButton(
        onPressed: customOnPressed, 
        child: Text(customLabel)
        ),
    );
  }
}
