import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/route_constants.dart';

import '../../../constants.dart';
import 'package:get/get.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // While loading use 👇
          //  BookMarksSlelton(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: Obx(()=>
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: defaultPadding,
                  crossAxisSpacing: defaultPadding,
                  childAspectRatio: 0.66,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ProductCard(
                      image: demoPopularProducts[index].image,
                      brandName: demoPopularProducts[index].brandName,
                      title: demoPopularProducts[index].title,
                      price: demoPopularProducts[index].price,
                      priceAfterDiscount:
                          demoPopularProducts[index].priceAfterDiscount,
                      discountPercent: demoPopularProducts[index].discountPercent,
                      id: demoPopularProducts[index].id,
                      categories: demoPopularProducts[index].categories,
                      // press: () {
                      //   // Navigator.pushNamed(context, productDetailsScreenRoute);
                      // },
                    );
                  },
                  childCount: demoPopularProducts.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
