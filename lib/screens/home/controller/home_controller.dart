import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/product_model.dart';

class HomeController extends GetxController {
  var products = <ProductModel>[].obs;
  var flashSaleProducts = <ProductModel>[].obs;
  var bestSellersProducts = <ProductModel>[].obs;
  var onSaleProducts = <ProductModel>[].obs;
  var newInProducts = <ProductModel>[].obs;
  var manProducts = <ProductModel>[].obs;
  var womanProducts = <ProductModel>[].obs;
  var kidProducts = <ProductModel>[].obs;
  var isLoading = false.obs;
  StreamSubscription<QuerySnapshot>? _subscription;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _subscription?.cancel();
  }

  void fetchProducts() async {
    isLoading.value = true;
    try {
      _subscription = FirebaseFirestore.instance
          .collection('products')
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isEmpty) {
          throw Exception('Không có dữ liệu sản phẩm.');
        }
        products.value = snapshot.docs.map((doc) {
          var data = doc.data();

          return ProductModel(
              id: doc.id,
              categories: data['categories'],
              image: data['image'],
              brandName: data['brandName'],
              title: data['title'],
              price: data['price'].toDouble(),
              priceAfterDiscount: data['priceAfterDiscount']?.toDouble(),
              discountPercent: data['discountPercent'],
              newIn: data['newIn'],
              purchaseCount: data['purchaseCount'],);
        }).toList();

        // fetchFlashSaleProducts();
        fetchNewInProducts();
        fetchBestSellersProducts();
        fetchOnSaleProducts();
        fetchManProducts();
        fetchWomanProducts();
        fetchKidProducts();
      });
    } catch (e) {
      Get.snackbar('Thông báo', 'Lỗi: $e');
    } finally {
      isLoading.value = false;
    }
  }
  //
  // void fetchFlashSaleProducts() {
  //
  // }

  void fetchBestSellersProducts() {
    bestSellersProducts.clear();

    var sortedProducts = List<ProductModel>.from(products);
    sortedProducts
        .sort((a, b) => b.purchaseCount!.compareTo(a.purchaseCount as num));

    // Lấy 3 sản phẩm có lượt mua cao nhất
    bestSellersProducts.addAll(sortedProducts.take(3));
  }

  void fetchOnSaleProducts() {
    onSaleProducts.clear();

    onSaleProducts.addAll(products.where((e) {
      return e.discountPercent != null;
    }));
  }

  void fetchNewInProducts() {
    newInProducts.clear();

    newInProducts.addAll(products.where((product) {
      return product.newIn == true;
    }));

  }

  void fetchManProducts() {
    manProducts.clear();

    manProducts.addAll(products.where((e) {
      return e.categories=='Men';
    }));
  }

  void fetchWomanProducts() {
    womanProducts.clear();

    womanProducts.addAll(products.where((e) {
      return e.categories=='Women';
    }));
  }

  void fetchKidProducts() {
    kidProducts.clear();

    kidProducts.addAll(products.where((e) {
      return e.categories=='Kids';
    }));
  }
}
