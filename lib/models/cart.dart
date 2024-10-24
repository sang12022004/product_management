import 'package:product_management/models/product.dart';

class Cart {
  final Map<Product, int> items = {};

  void addProduct(Product product, int quantity) {
    if (items.containsKey(product)) {
      items[product] = items[product]! + quantity;
    } else {
      items[product] = quantity;
    }
    if (items[product]! <= 0) {
      items.remove(product);
    }
  }

  void removeProduct(Product product) {
    items.remove(product);
  }

  double getTotalPrice() {
    double total = 0.0;
    items.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }
}
