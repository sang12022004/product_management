import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';
import '../theme/colors.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final Cart cart;

  ProductDetailScreen({required this.product, required this.cart});

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController = TextEditingController(text: '1');

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: getColor(AppColors.primaryAccent),
        // actions: [
        //   Row(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(right: 16.0),
        //         child: Stack(
        //           clipBehavior: Clip.none,
        //           children: [
        //             IconButton(
        //               icon: Icon(Icons.shopping_cart),
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => CartScreen(cart: cart),
        //                   ),
        //                 );
        //               },
        //             ),
        //             Positioned(
        //               right: -6,
        //               top: 10,
        //               child: Container(
        //                 padding: EdgeInsets.all(4),
        //                 decoration: BoxDecoration(
        //                   color: Colors.red,
        //                   borderRadius: BorderRadius.circular(12),
        //                 ),
        //                 constraints: BoxConstraints(
        //                   minWidth: 10,
        //                   minHeight: 10,
        //                 ),
        //                 child: Text(
        //                   '${cart.items.length}',
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 12,
        //                   ),
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product.imagePath, width: 200, height: 200),
            SizedBox(height: 10),
            Text(product.name, style: TextStyle(fontSize: 24, color: getColor(AppColors.lightAccent))),
            Text('${product.price} VND', style: TextStyle(fontSize: 20, color: getColor(AppColors.lightAccent))),
            SizedBox(height: 10),
            Text(product.description, style: TextStyle(color: getColor(AppColors.lightAccent))),
            SizedBox(height: 20),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'Số lượng',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                int quantity = int.parse(quantityController.text);
                cart.addProduct(product, quantity);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Thêm vào giỏ hàng"),
                  ),
                );
                Navigator.pop(context);
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(getColor(AppColors.primaryAccent))),
              child: Text('Thêm giỏ hàng'),
            ),
          ],
        ),
      ),
    );
  }
}
