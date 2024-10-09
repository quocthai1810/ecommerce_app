import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class BuyFullKit extends StatefulWidget {
  const BuyFullKit({super.key, required this.images});

  final List<String> images;

  @override
  State<BuyFullKit> createState() => _BuyFullKitState();
}

class _BuyFullKitState extends State<BuyFullKit> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [FloatingActionButton(onPressed: () { Navigator.pop(context); },

              ),
          const Text('Trang chưa tạo',  style: TextStyle(fontSize: 30),)]
        ),
      ));
  }
}
