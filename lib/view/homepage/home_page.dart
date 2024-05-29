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

  void filterProducts(String category) {
    setState(() {
      selectedCategory = category;
    });
    if (selectedCategory == 'All') {
      productController.readProducts();
    } else {
      productController.fetchProductsByCategory(selectedCategory.toLowerCase());
    }
    Navigator.pop(context);
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Select Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var category in ['All', 'Electronics', 'Jewelery', 'Men\'s Clothing', 'Women\'s Clothing'])
                ListTile(
                  title: Text(category),
                  onTap: () => filterProducts(category),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Color(0xffB8C1D9FF),
          title: Text(
            'Shop Your Favourites 🛒🛍️',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: Color(0xff213555)),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.favorite, color: Color(0xff213555)),
              onPressed: () {
                Get.to(WishlistScreen());
              },
            ),
            IconButton(
              icon: Icon(Icons.filter_list, color: Color(0xff213555)),
              onPressed: () => showFilterDialog(context),
            ),
          ],
        ),
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
