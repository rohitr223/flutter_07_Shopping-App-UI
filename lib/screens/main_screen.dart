import 'package:flutter/material.dart';

import 'package:shopping_app/data/global_variables.dart';
import 'package:shopping_app/screens/product_details_screen.dart';
import 'package:shopping_app/utils/product_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // list of brand's
  final List<String> filters = const [
    "All",
    "Addidas",
    "Nike",
    "Bata",
  ];

  late String selectedFilter = filters[0];

  @override
  void initState() {
    // initially select the first filter button "All"
    // when the app loads for first time
    selectedFilter = filters[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // default border
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 205, 204, 200),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
      ),
    );

    // border when focused
    const focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 205, 204, 200),
        width: 3,
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
      ),
    );

    // // ---- using mediaquery for height/width ----
    // // using it for mobile / web responsivity
    // final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Buy\nShoes",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: focusedBorder,
                  ),
                ),
              ),
            ],
          ),
          // since listview occupies all the height we user SizedBox
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      // switch the background color according to user's selection
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromARGB(255, 240, 240, 238),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 240, 240, 238),
                      ),
                      label: Text(filter),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                print(constraints.maxHeight);
                print(constraints.maxWidth);
                // if width is greater than 1080px show GridView or show ListView.
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          // navigate tp another page when clicled.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsScreen(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromARGB(255, 196, 226, 250)
                              : const Color.fromARGB(255, 233, 230, 230),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          // navigate tp another page when clicled.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsScreen(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromARGB(255, 196, 226, 250)
                              : const Color.fromARGB(255, 233, 230, 230),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
