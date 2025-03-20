import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop/route/apppages.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/route/router.dart' as router;
import 'package:shop/theme/app_theme.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Builder(
        builder: (BuildContext context) =>GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop Template by The Flutter Way',
          theme: AppTheme.lightTheme(context),

          themeMode: ThemeMode.light,
          initialRoute: onbordingScreenRoute,
          getPages: AppPages.routes,

        ),
      ),
    ));
  }
}
