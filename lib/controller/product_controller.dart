import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductController extends GetxController {
  RxBool isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    readProducts();
    super.onInit();
  }

  void readProducts() async {
    try {
      isLoading(true);
      var products = await HttpService.fetchProduct();
      if (products != null) {
        productList.value = products;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void fetchProductsByCategory(String categoryEndpoint) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse("https://fakestoreapi.com/products/category/$categoryEndpoint"));
      if (response.statusCode == 200) {
        var data = response.body;
        productList.value = productModelFromJson(data);
      } else {
        throw Exception('Failed to load products for category $categoryEndpoint');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
