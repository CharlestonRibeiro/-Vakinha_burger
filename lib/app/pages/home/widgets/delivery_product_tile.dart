import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/extensions/formatter_extension.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/images/images.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/colors_app.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burger_provider_com_bloc/app/dto/order_product_dto.dart';
import 'package:vakinha_burger_provider_com_bloc/app/models/product_model.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/home/home_controller.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/product_detail/product_detail_page.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel product;
  final OrderProductDto? orderProduct;

  const DeliveryProductTile({
    Key? key, 
    required this.product, 
    required this.orderProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProductResult = await Navigator.of(context).pushNamed(
            ProductDetailPage.route,
            arguments: {
              'product': product,
              'order': orderProduct
              });

        if (orderProductResult != null) {
          controller.addOrUpdateBag(orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
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
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.description,
                      style:
                          context.textStyles.textMedium.copyWith(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.price.currencyPTBR,
                      style: context.textStyles.textMedium.copyWith(
                          fontSize: 15, color: context.colors.secondary),
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
      ),
    );
  }
}
