import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/bottomnavigation/bottom_nav.dart';
import 'controller/product_controller.dart';
import 'controller/whislist_controller.dart';


void main() {
  Get.put(ProductController());
  Get.put(WishlistController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
