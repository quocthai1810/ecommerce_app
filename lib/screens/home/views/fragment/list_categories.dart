import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Make sure to import GetX
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/constants.dart';

class ListCategories extends StatelessWidget {
  const ListCategories(
      {super.key, required this.products, required this.nameCategories});

  final List<ProductModel> products;
  final String nameCategories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameCategories), // Customize the title as needed
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Use GetX to go back to the previous screen
          },
        ),
      ),
      body: products.isEmpty
          ? Center(
              child: Text(
                'Chưa có sản phẩm $nameCategories',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                      childAspectRatio: 0.66,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ProductCard(
                          image: products[index].image,
                          brandName: products[index].brandName,
                          title: products[index].title,
                          price: products[index].price,
                          priceAfterDiscount:
                              products[index].priceAfterDiscount,
                          discountPercent: products[index].discountPercent,

                          id: products[index].id,
                          categories: products[index].categories,
                          // press: () {
                          //   // Navigate to product details screen if needed
                          // },
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
