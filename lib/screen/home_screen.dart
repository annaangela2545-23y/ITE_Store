import 'package:flutter/material.dart';
import 'package:flutter_ite_app/api/model/product.dart';
import 'cart_screen.dart';
import '../app/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  Map<int, int> cartItems = {}; // ✅ tracks product id → quantity

  @override
  void initState() {
    super.initState();
    fetchProducts().then((result) {
      setState(() {
        products = result;
        filteredProducts = result;
      });
    });
  }

  int get _cartItemCount => cartItems.values.fold(0, (sum, qty) => sum + qty);

  void _addToCart(Product product) {
    setState(() {
      cartItems[product.id] = (cartItems[product.id] ?? 0) + 1;
    });
  }

  void _filterProducts(String query) {
    final q = query.trim().toLowerCase();
    setState(() {
      filteredProducts = products.where((p) {
        final cleaned = q.replaceAll(RegExp(r'[^a-z0-9]'), '');
        final name = p.name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
        return name.contains(cleaned);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _body,
    );
  }

  Widget get _body {
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.name),
                    ),
                    Text('\$${product.price}'),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                      onPressed: () => _addToCart(product),
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      ),
                      ),
                      child: const Text('Add to Cart'),

                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    final isDemo = Config().env == 'DEMO';
    return AppBar(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      title: Row(
        children: [
          IconButton(
            onPressed: isDemo ? null : () {},
            icon: const Icon(Icons.menu),
          ),
          const Text(
            'ITE Store',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Badge(
            isLabelVisible: _cartItemCount > 0,
            label: Text(_cartItemCount.toString()),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: isDemo
                  ? null
                  : () async {
                final updatedCart =
                await Navigator.push<Map<int, int>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      allProducts: products,
                      initialCart: Map.from(cartItems),
                    ),
                  ),
                );

                if (updatedCart != null) {
                  setState(() {
                    cartItems = updatedCart;
                  });
                }
              },
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBar(
            hintText: 'Search products...',
            leading: const Icon(Icons.search),
            onChanged: (value) => _filterProducts(value),
          ),
        ),
      ),
    );
  }
}