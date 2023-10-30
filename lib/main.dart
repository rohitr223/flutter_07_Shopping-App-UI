import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // provider package for state managament

import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/provider/cart_provider.dart'; // cart provider


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shopping App",
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 246, 215, 1),
            primary: const Color.fromARGB(255, 246, 215, 1),
          ),
          // default decoration for textfield
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            // set prefix icon color
            prefixIconColor: Color.fromARGB(119, 119, 119, 1),
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            titleLarge: TextStyle(
              fontSize: 27,
            ),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
