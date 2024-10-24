import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';
import '../theme/colors.dart';

class ProductListScreen extends StatefulWidget {
  final Cart cart = Cart();
  final List<Product> products = [
    Product(name: "MacBook Air M1", imagePath: "images/MacBookAirM1.png", description: "Laptop Apple MacBook Air 13\" với chip M1, RAM 8GB, SSD 256GB, màn hình Retina sắc nét.", price: 15000000),
    Product(name: "iPhone 14 Pro", imagePath: "images/iPhone14Pro.png", description: "Điện thoại iPhone 14 Pro với chip A16 Bionic, màn hình 120Hz, hệ thống camera chuyên nghiệp.", price: 12000000),
    Product(name: "Apple Watch Series 7", imagePath: "images/AppleWatchSeries7.png", description: "Đồng hồ thông minh Apple Watch Series 7 với màn hình lớn hơn, chống nước và nhiều tính năng theo dõi sức khỏe.", price: 45000000),
    Product(name: "Samsung Galaxy S22 Ultra", imagePath: "images/SamsungGalaxyS22Ultra.png", description: "Điện thoại Samsung Galaxy S22 Ultra với bút S Pen tích hợp, camera 108MP và màn hình Dynamic AMOLED.", price: 130000000),
    Product(name: "Dell XPS 13", imagePath: "images/DellXPS13.png", description: "Laptop Dell XPS 13 với màn hình InfinityEdge, Intel Core i7, RAM 16GB, SSD 512GB.", price: 160000000),
    Product(name: "GoPro HERO10", imagePath: "images/GoProHERO10.png", description: "Camera hành trình GoPro HERO10 với khả năng quay 5.3K, chống nước và nhiều phụ kiện đi kèm.", price: 50000000),
  ];

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  void filterProducts(String query) {
    List<Product> filteredList = widget.products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredProducts = filteredList;
    });
  }

  Future<void> _navigateAndUpdateCart(BuildContext context, Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product, cart: widget.cart),
      ),
    );
    setState(() {});
  }

  Future<void> _navigateAndUpdateFromCart(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: widget.cart),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm sản phẩm...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            filterProducts(value);
          },
        ),
        backgroundColor: getColor(AppColors.primaryAccent),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        _navigateAndUpdateFromCart(context);
                      },
                    ),
                    Positioned(
                      right: -6,
                      top: 10,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        child: Text(
                          '${widget.cart.items.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          String shortDescription = product.description.length > 50
              ? product.description.substring(0, 50) + '...'
              : product.description;

          return GestureDetector(
            onTap: () => _navigateAndUpdateCart(context, product),
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(product.imagePath, width: 50, height: 50),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(shortDescription),
                              SizedBox(height: 5),
                              Text('${product.price} VND', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.cart.addProduct(product, 1);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Thêm vào giỏ hàng"),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(getColor(AppColors.primaryAccent)),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                        ),
                        child: Text('Thêm giỏ hàng', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
