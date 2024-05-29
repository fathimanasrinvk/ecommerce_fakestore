import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/product_model.dart';
import '../../controller/whislist_controller.dart';
import '../productdetails/product_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  final WishlistController wishlistController = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Color(0xff436850),),),
        centerTitle: true,
        backgroundColor: Color(0xffADBC9F),
      ),
      body: Obx(() {
        if (wishlistController.wishlist.isEmpty) {
          return Center(child: Text('No items in the wishlist',style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xff213555))));
        } else {
          return ListView.builder(
            itemCount: wishlistController.wishlist.length,
            itemBuilder: (context, index) {
              final product = wishlistController.wishlist[index];
              return ListTile(
                leading: Container(
                  width: 100,height: 160,
                  child: Image.network(
                    product.image ?? '',
                    fit: BoxFit. fill,
                  ),
                ),
                title: Text(product.title ?? ''),
                subtitle: Text(product.description ?? ''),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    wishlistController.removeFromWishlist(product);
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetails(product)));
                },
              );
            },
          );
        }
      }),
    );
  }
}
