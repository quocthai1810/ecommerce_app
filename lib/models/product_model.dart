import 'package:shop/screens/home/controller/home_controller.dart';
import 'package:get/get.dart';

class ProductModel {
  final String image, brandName, title, categories, id;
  final double price;
  final double? priceAfterDiscount;
  final int? discountPercent,purchaseCount;
  final bool? newIn;

  ProductModel({
    required this.id,
    required this.categories,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfterDiscount,
    this.discountPercent,
    this.purchaseCount,
    this.newIn
  });
}

HomeController homeController = Get.find<HomeController>();

List<ProductModel> demoPopularProducts = homeController.products;
List<ProductModel> demoFlashSaleProducts = homeController.flashSaleProducts;
List<ProductModel> demoBestSellersProducts = homeController.bestSellersProducts;
List<ProductModel> demoOnSaleProducts = homeController.onSaleProducts;

