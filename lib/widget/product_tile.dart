import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/product_model.dart';
import '../controller/whislist_controller.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final WishlistController wishlistController = Get.find<WishlistController>();

  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(product.image ?? '', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$${product.price}'),
          ),
          IconButton(
            icon: Obx(() {
              return Icon(
                wishlistController.isInWishlist(product)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: wishlistController.isInWishlist(product)
                    ? Colors.red
                    : null,
              );
            }),
            onPressed: () {
              if (wishlistController.isInWishlist(product)) {
                wishlistController.removeFromWishlist(product);
              } else {
                wishlistController.addToWishlist(product);
              }
            },
          ),
        ],
      ),
    );
  }
}
