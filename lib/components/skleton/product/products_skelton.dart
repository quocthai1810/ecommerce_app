import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'product_card_skelton.dart';

class ProductsSkelton extends StatefulWidget {
  const ProductsSkelton({super.key});

  @override
  _ProductsSkeltonState createState() => _ProductsSkeltonState();
}

class _ProductsSkeltonState extends State<ProductsSkelton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.7, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: defaultPadding,
            right: index == 4 ? defaultPadding : 0,
          ),
          child: FadeTransition(
            opacity: _animation,
            child: const ProductCardSkelton(),
          ),
        ),
      ),
    );
  }
}
