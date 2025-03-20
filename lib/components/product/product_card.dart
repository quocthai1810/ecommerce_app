import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/route_constants.dart';

import '../../constants.dart';
import '../network_image_with_loader.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfterDiscount,
    this.discountPercent,

    this.purchaseCount,
    // required this.press,

    required this.categories
  });

  final String image, brandName, title, id, categories;
  final double price;
  final double? priceAfterDiscount;
  final int? discountPercent, purchaseCount;

  // final VoidCallback press;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return OutlinedButton(
      onPressed: () {
        if (Get.currentRoute == productDetailsScreenRoute){
          Get.offAndToNamed(productDetailsScreenRoute);
        } else {
          Get.toNamed(productDetailsScreenRoute);
        }
      },
      style: OutlinedButton.styleFrom(
          minimumSize: const Size(140, 220),
          maximumSize: const Size(140, 220),
          padding: const EdgeInsets.all(8)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(widget.image,
                    radius: defaultBorderRadious),

                if (widget.discountPercent != null)
                  Positioned(
                    right: defaultPadding / 2,
                    top: defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      height: 16,
                      decoration: const BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious)),
                      ),
                      child: Text(
                        "${widget.discountPercent}% off",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.brandName.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  widget.priceAfterDiscount != null
                      ? Row(
                          children: [
                            Text(
                              "\$${widget.priceAfterDiscount}",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: defaultPadding / 4),
                            Text(
                              "\$${widget.price}",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "\$${widget.price}",
                          style: const TextStyle(
                            color: Color(0xFF31B0D8),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
