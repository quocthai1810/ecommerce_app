import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class ConstFunc {
//Hàm hiện vòng loading
  static circularProgress(String text) {
    return Stack(alignment: Alignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: primaryColor,
          ),
          Text(text)
        ],
      )
    ]);
  }
}
