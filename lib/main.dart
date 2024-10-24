import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:product_management/screens/cart_screen.dart' as cartScreen;
import 'screens/product_list_screen.dart';
import 'models/cart.dart';

void main() {
  runApp(EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/products': (context) => ProductListScreen(),
        '/cart': (context) => cartScreen.CartScreen(cart: Cart()),
      },
    );
  }
}
