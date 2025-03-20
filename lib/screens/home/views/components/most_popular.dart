import 'package:flutter/material.dart';
import 'package:shop/components/product/secondary_product_card.dart';
import 'package:shop/components/skleton/product/secondery_produts_skelton.dart';
import 'package:shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../../route/route_constants.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "On Sale",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // SeconderyProductsSkelton(),

        Obx(()=>homeController.isLoading.value==true?
            const SeconderyProductsSkelton():
           SizedBox(
            height: 114,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // Find demoPopularProducts on models/ProductModel.dart
              itemCount: demoOnSaleProducts.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: index == demoOnSaleProducts.length - 1
                      ? defaultPadding
                      : 0,
                ),
                child: SecondaryProductCard(
                  image: demoOnSaleProducts[index].image,
                  brandName: demoOnSaleProducts[index].brandName,
                  title: demoOnSaleProducts[index].title,
                  price: demoOnSaleProducts[index].price,
                  priceAfterDiscount: demoOnSaleProducts[index].priceAfterDiscount,
                  discountPercent: demoOnSaleProducts[index].discountPercent,

                  purchaseCount: demoOnSaleProducts[index].purchaseCount,
                  categories: demoOnSaleProducts[index].categories,

                  // press: () {
                  //   // Navigator.pushNamed(context, productDetailsScreenRoute,
                  //   //     arguments: index.isEven);
                  // },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
