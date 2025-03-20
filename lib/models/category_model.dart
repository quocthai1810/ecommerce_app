import 'package:shop/models/product_model.dart';

class CategoryModel {
  final String title;
  final String? subtitle;
  final String? image, svgSrc;
  final List<CategoryModel>? subCategories;
  final List<ProductModel>? products;

  CategoryModel({
    this.subtitle,
    required this.title,
    this.image,
    this.svgSrc,
    this.subCategories,
    this.products,

  });
}

// final List<CategoryModel> demoCategoriesWithImage = [
//   CategoryModel(title: "Woman’s", image: "https://i.imgur.com/5M89G2P.png"),
//   CategoryModel(title: "Man’s", image: "https://i.imgur.com/UM3GdWg.png"),
//   CategoryModel(title: "Kid’s", image: "https://i.imgur.com/Lp0D6k5.png"),
//   CategoryModel(title: "Accessories", image: "https://i.imgur.com/3mSE5sN.png"),
// ];

final List<CategoryModel> demoCategories = [
  CategoryModel(
    title: "On sale",
    svgSrc: "assets/icons/Sale.svg",
    subCategories: [
      CategoryModel(title: "All Clothing", products: homeController.onSaleProducts,subtitle: 'All Clothing OnSale'),
      CategoryModel(title: "New In",products: homeController.onSaleProducts.where((product){
        return product.newIn == true;
      }).toList(), subtitle: 'NewIn OnSale'),
    ],
  ),
  CategoryModel(
    title: "Man’s",
    svgSrc: "assets/icons/Man&Woman.svg",
    subCategories: [
      CategoryModel(title: "All Clothing", products: homeController.manProducts, subtitle: 'All Clothing Mans'),
      CategoryModel(title: "New In",products: homeController.manProducts.where((product){
        return product.newIn == true;
      }).toList(), subtitle: 'NewIn Mans'),
    ],
  ),
  CategoryModel(
    title: "Kids",
    svgSrc: "assets/icons/Child.svg",
    subCategories: [
      CategoryModel(title: "All Clothing", products: homeController.kidProducts, subtitle: 'All Clothing Kids'),
      CategoryModel(title: "New In",products: homeController.kidProducts.where((product){
        return product.newIn == true;
      }).toList(), subtitle: 'NewIn Kids'),
    ],
  ),
  CategoryModel(
    title: "Women's",
    svgSrc: "assets/icons/Woman.svg",
    subCategories: [
      CategoryModel(title: "All Clothing", products: homeController.womanProducts, subtitle: 'All Clothing Womens'),
      CategoryModel(title: "New In",products: homeController.womanProducts.where((product){
        return product.newIn == true;
      }).toList(), subtitle: 'NewIn Womens'),
    ],
  ),
];
