import 'package:flutter/material.dart';

import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/main_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bottom nav bar
  int currentPage = 0;

  List<Widget> pages = const [
    MainScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            // as we dont want any label it is left empty
            label: '',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
        ],
      ),
      // indexed stack is used for maintaining the scroll 
      // position even if we move to another page.
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
    );
  }
}
