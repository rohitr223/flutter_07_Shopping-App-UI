import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  // fetch the product
  final Map<String, Object> product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    // Tapped on 'Add To Cart' Button
    void onTap() {
      /*
        here product cannot be accessed directly as we are 
        using a stateful widget, so we use widget.product to
        access the product list.
      */
      /*
        IMP -: since we are using Provider outside of the build function
        that is Widget build(BuildContext context){
          return (...);
        },
        we set listen: false,
      */

      // check if the user selected the size
      if (selectedSize != 0) {
        Provider.of<CartProvider>(context, listen: false).addProduct(
          {
            'id': widget.product['id'],
            'title': widget.product['title'],
            'price': widget.product['price'],
            'imageUrl': widget.product['imageUrl'],
            'compny': widget.product['compny'],
            'size': selectedSize,
          },
        );
        // show message when items added to the cart
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added successfully!'),
          ),
        );
      } else {
        // show message when items are not added to the cart
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an appropriate size!'),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.product['imageUrl'] as String,
              height: 250,
            ),
          ),
          const Spacer(flex: 2),
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 196, 226, 250),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$ ${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // we can't access the length directly
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product['sizes']! as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(
                            label: Text(size.toString()),
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: const Size(350, 50),
                    ),
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
