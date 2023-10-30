import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopping_app/provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    //print(Provider.of<CartProvider>(context).cart);
    final cart = Provider.of<CartProvider>(context).cart; // cart products

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  // barrierDismissible: you can't close the dialod box by clicking outside.
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Remove',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: Text(
                        'Are you sure you want to remove this product from the cart?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .removeProduct(cartItem);
                                // close the dialogbox
                                Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            title: Text(
              cartItem['title'].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('Size ${cartItem['size']}'),
          );
        },
      ),
    );
  }
}
