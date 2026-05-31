import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../app/config.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite = false;

  Product(this.id, this.name, this.description, this.imageUrl, this.price);

  Product.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? 0,
      name = json['name'] ?? '',
      description = json['description'] ?? '',
      imageUrl = json['thumbnail'] ?? '',
      price = (json['price'] as num?)?.toDouble() ?? 0.0;
}
Future<List<Product>> fetchProducts() async {
  final apiUrl = Config().apiBaseUrl;
  // final response = await http.get(apiUrl.replace(path: 'products.json'));
  final response = await http.get(Uri.parse('${apiUrl}products.json'));
  if (response.statusCode == 200) {
    // Decode the response body string into a List
    List<dynamic> body = jsonDecode(response.body);

    // Convert each item in the list into a Product object
    List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();

    return products;
  } else {
    throw Exception('Failed to load products');
  }
}

// void main() async {
//   try {
//     List<Product> myProducts = await fetchProducts();
//     debugPrint('Fetched ${myProducts.length} products.');
//     debugPrint('First Product: ${myProducts[0].name}');
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }
