import 'package:flutter/material.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/extensions/formatter_extension.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/images/images.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/colors_app.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burger_provider_com_bloc/app/models/product_model.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel product;

  const DeliveryProductTile({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    product.name,
                    style: context.textStyles.textExtraBold.copyWith(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    product.description,
                    style: context.textStyles.textMedium.copyWith(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    product.price.currencyPTBR,
                    style: context.textStyles.textMedium
                        .copyWith(fontSize: 15, color: context.colors.secondary),
                  ),
                ),
              ],
            ),
          ),
          FadeInImage.assetNetwork(
            placeholder: Images.loading, 
            image: product.image,
            width: 120,
            height: 120,
            fit: BoxFit.contain,
            ),
        ],
      ),
    );
  }
}
