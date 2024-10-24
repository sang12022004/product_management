import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import '../theme/colors.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void confirmDelete(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận"),
          content: Text("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?"),
          actions: [
            TextButton(
              child: Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Xóa"),
              onPressed: () {
                setState(() {
                  widget.cart.removeProduct(product);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã xóa sản phẩm")));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        backgroundColor: getColor(AppColors.primaryAccent),
      ),
      body: ListView.builder(
        itemCount: widget.cart.items.length,
        itemBuilder: (context, index) {
          final product = widget.cart.items.keys.elementAt(index);
          final quantity = widget.cart.items[product];
          return ListTile(
            leading: Image.asset(product.imagePath, width: 50, height: 50),
            title: Text(product.name),
            subtitle: Text('Số lượng: $quantity'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity! > 1) {
                        widget.cart.addProduct(product, -1);
                      } else {
                        confirmDelete(product);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      widget.cart.addProduct(product, 1);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    confirmDelete(product);
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product, cart: widget.cart),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền: ${widget.cart.getTotalPrice()} VND',
                  style: TextStyle(
                    color: getColor(AppColors.lightAccent),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã thanh toán ${widget.cart.items.length} sản phẩm. Tổng ${widget.cart.getTotalPrice()} VND")));
                        widget.cart.items.clear();
                      });
                    },
                    child: Text(
                      'Thanh toán',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
