import 'package:flutter/material.dart';
import 'package:flutter_ite_app/api/model/product.dart';
import 'cart_screen.dart';
import 'view_product.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  int _cartItemCount = 0;       
  @override
  void initState() {
    super.initState();
    fetchProducts().then((result) {
      setState(() {
        products = result;
      });
    });
  }                               

  void incrementCartItemCount() { 
    setState(() {
      _cartItemCount++;          
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
          shrinkWrap: true,                        // ← sizes to content
          physics: const NeverScrollableScrollPhysics(), // ← outer scroll handles it
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(                          // ← wrap with GestureDetector
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(), // ← pass product
                          ),
                        );
                      },
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
                  Row(
                    children: [
                      Expanded(                                    // ← takes half the width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(),
                              ),
                            );
                          },
                          child: const Text('View Details',
                          textAlign: TextAlign.center,),
                        ),
                      ),
                      const SizedBox(width: 8),                   // ← spacing between buttons
                      Expanded(                                    // ← takes other half
                        child: ElevatedButton(
                          onPressed: () {
                            incrementCartItemCount();
                          },
                          child: const Text(
                            'Add to Cart',
                            textAlign: TextAlign.center,   // ← camelCase, proper named parameter
                          ),
                        ),
                      ),
                    ],
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
    return AppBar(
      title: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          const Text('ITE Store'),
          const Spacer(),
          Badge(
            isLabelVisible: _cartItemCount > 0,       // ← underscore prefix
            label: Text(_cartItemCount.toString()),   // ← underscore prefix
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottom: PreferredSize(preferredSize: const Size.fromHeight(70), 
     child: Row(
          children: [
            const Expanded(
              child: SearchBar(
                hintText: 'Search products...',
                leading: Icon(Icons.search),
              ),
            ),
            // const SizedBox(width: 8),
            // IconButton.filled(
            //   onPressed: () {},
            //   icon: const Icon(Icons.filter_list),
            // ),
          ],),
      )
    );
  }
}