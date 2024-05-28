import 'package:get/get.dart';
import '../model/product_model.dart';

class WishlistController extends GetxController {
  var wishlist = <ProductModel>[].obs;

  void addToWishlist(ProductModel product) {
    if (!wishlist.contains(product)) {
      wishlist.add(product);
    }
  }

  void removeFromWishlist(ProductModel product) {
    wishlist.remove(product);
  }

  bool isInWishlist(ProductModel product) {
    return wishlist.contains(product);
  }
}
