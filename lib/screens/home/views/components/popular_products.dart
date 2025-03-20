import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/screen_export.dart';

import '../../../../components/skleton/product/products_skelton.dart';
import '../../../../constants.dart';
import '../../controller/home_controller.dart';
import 'package:get/get.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "All products",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇

        Obx(() {
          return homeController.isLoading.value == true
              ? const ProductsSkelton()
              : SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Find demoPopularProducts on models/ProductModel.dart
                    itemCount: demoPopularProducts.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == demoPopularProducts.length - 1
                            ? defaultPadding
                            : 0,
                      ),
                      child: ProductCard(
                        image: demoPopularProducts[index].image,
                        brandName: demoPopularProducts[index].brandName,
                        title: demoPopularProducts[index].title,
                        price: demoPopularProducts[index].price,
                        priceAfterDiscount:
                            demoPopularProducts[index].priceAfterDiscount,
                        discountPercent:
                            demoPopularProducts[index].discountPercent,


                        purchaseCount: demoPopularProducts[index].purchaseCount,
                        id: demoPopularProducts[index].id,
                        categories: demoPopularProducts[index].categories,
                        // press: () {
                        //   Get.toNamed(productDetailsScreenRoute);
                          // Navigator.pushNamed(context, productDetailsScreenRoute,
                          //     arguments: index.isEven);
                        // },
                      ),
                    ),
                  ),
                );
        })
      ],
    );
  }
}
