import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/product_model.dart';

class HttpService {
  static Future<List<ProductModel>> fetchProduct() async {
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      var data = response.body;
      return productModelFromJson(data);
    } else {
      throw Exception();
    }
  }

  static Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products/category/$category"));
    if (response.statusCode == 200) {
      var data = response.body;
      return productModelFromJson(data);
    } else {
      throw Exception();
    }
  }
}
