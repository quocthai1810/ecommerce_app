import 'package:flutter/material.dart';
import 'package:shop/components/Banner/S/banner_s_style_1.dart';
import 'package:shop/components/Banner/S/banner_s_style_5.dart';
import 'package:shop/constants.dart';
import 'package:get/get.dart';

import '../../../models/product_model.dart';
import '../../../route/route_constants.dart';
import 'components/best_sellers.dart';
import 'components/flash_sale.dart';
import 'components/most_popular.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
            const SliverToBoxAdapter(child: PopularProducts()),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
              sliver: SliverToBoxAdapter(
                  child:
                      // FlashSale()
                      SizedBox.shrink()),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // While loading use 👇
                  // const BannerMSkelton(),‚
                  BannerSStyle1(
                    title: "New \narrival",
                    subtitle: "SPECIAL OFFER",
                    discountParcent: null,
                    press: () {
                      Get.toNamed(listCategoriesScreenRoute, arguments: {
                        'products': homeController.newInProducts,
                        'categoryName': 'New Arrival'
                      });
                      // Navigator.pushNamed(context, onSaleScreenRoute);
                    },
                  ),
                  const SizedBox(height: defaultPadding / 4),
                  // We have 4 banner styles, all in the pro version
                ],
              ),
            ),
            const SliverToBoxAdapter(child: BestSellers()),
            const SliverToBoxAdapter(child: MostPopular()),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: defaultPadding * 1.5),

                  SizedBox(height: defaultPadding / 4),
                  // While loading use 👇
                  // const BannerSSkelton(),
                  // BannerSStyle5(
                  //   title: "Black \nfriday",
                  //   subtitle: "50% Off",
                  //   bottomText: "Collection".toUpperCase(),
                  //   press: () {
                  //     Get.toNamed(listCategoriesScreenRoute, arguments: {
                  //       'products': homeController.onSaleProducts,
                  //       'categoryName': 'On Sale'
                  //     });
                  //     // Navigator.pushNamed(context, onSaleScreenRoute);
                  //   },
                  // ),
                  SizedBox(height: defaultPadding / 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
