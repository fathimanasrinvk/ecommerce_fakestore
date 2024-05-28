import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controller/product_controller.dart';
import '../../controller/whislist_controller.dart';
import '../productdetails/product_detail_screen.dart';
import '../../widget/product_tile.dart';
import '../wishlist/whishlist_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());
  final WishlistController wishlistController = Get.put(WishlistController());
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xCC168A7D),
        title: Text(
          'Shop Your Favourites 🛒🛍️',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Get.to(WishlistScreen());
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                selectedCategory = result;
              });
              if (selectedCategory == 'All') {
                productController.readProducts();
              } else {
                productController.fetchProductsByCategory(selectedCategory.toLowerCase());
              }
            },
            itemBuilder: (BuildContext context) => <String>[
              'All',
              'Electronics',
              'Jewelery',
              'Men\'s Clothing',
              'Women\'s Clothing'
            ].map((String category) {
              return PopupMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(
                  child: Lottie.asset("assets/animation/loading.json"),
                );
              } else {
                return GridView.builder(
                  itemCount: productController.productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .5,
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails(productController.productList[index]),
                      ));
                    },
                    child: ProductTile(productController.productList[index]),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
