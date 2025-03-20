import 'package:flutter/material.dart';
import 'package:shop/components/skleton/product/products_skelton.dart';
import 'package:shop/route/route_constants.dart';

import '/components/Banner/M/banner_m_with_counter.dart';
import '../../../../components/product/product_card.dart';
import '../../../../constants.dart';
import '../../../../models/product_model.dart';
import 'package:get/get.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading show 👇
        // const BannerMWithCounterSkelton(),
        BannerMWithCounter(
          duration: const Duration(hours: 8),
          text: "Super Flash Sale \n50% Off",
          press: () {
            Get.toNamed(listCategoriesScreenRoute, arguments: {'products': homeController.onSaleProducts, 'categoryName': 'On Sale'});
          },
        ),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Flash sale",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading show 👇
        // const ProductsSkelton(),
        Obx(()=> homeController.isLoading.value == true?
            const ProductsSkelton():
            SizedBox(
            height: 220,
            child: demoFlashSaleProducts.isNotEmpty?
            ListView.builder(
              scrollDirection: Axis.horizontal,
              // Find demoFlashSaleProducts on models/ProductModel.dart
              itemCount: demoFlashSaleProducts.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: index == demoFlashSaleProducts.length - 1
                      ? defaultPadding
                      : 0,
                ),
                child: ProductCard(
                  image: demoFlashSaleProducts[index].image,
                  brandName: demoFlashSaleProducts[index].brandName,
                  title: demoFlashSaleProducts[index].title,
                  price: demoFlashSaleProducts[index].price,
                  priceAfterDiscount:
                      demoFlashSaleProducts[index].priceAfterDiscount,
                  discountPercent: demoFlashSaleProducts[index].discountPercent,

                  purchaseCount: demoFlashSaleProducts[index].purchaseCount,

                  id: demoFlashSaleProducts[index].id,
                  categories: demoFlashSaleProducts[index].categories,
                  // press: () {
                  //   // Navigator.pushNamed(context, productDetailsScreenRoute,
                  //   //     arguments: index.isEven);
                  // },
                ),
              ),
            ):const Center(child: Text('Không có sản phẩm nào đang Flash sale')),
          ),
  ),
      ],
    );
  }
}
