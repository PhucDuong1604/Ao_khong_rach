import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/screens/search_product_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/screens/cart_page.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_card.dart';
import 'package:cua_hang_ao_khong_rach/tools/Desgin_Drawer.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';

Future<List<Product>> fetchProducts() async {
  final response = await http
      .get(Uri.parse('http://localhost:8888/restful_api_php/api/sp/ao.php'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<Product> productList = [];
    for (var item in data['dssanpham']) {
      productList.add(Product(
          hinhAnh: item['HinhAnh'] ?? '',
          tenSanPham: item['TenSanPham'] ?? '',
          gia: item['Gia'] ?? '',
          kichThuoc: item['KichThuoc'] ?? '',
          mauSac: item['MauSac'] ?? '',
          soLuongTon: item['SoLuongTon'],
          maSanPham: '',
          moTa: '',
          danhMuc: '',
          SoLuong: 0));
    }
    return productList;
  } else {
    throw Exception('Failed to load products');
  }
}

// ignore: must_be_immutable
class CategoryAoPage extends StatefulWidget {
  final User user;
  final Cart cart;
  CategoryAoPage({super.key, required this.user, required this.cart});

  @override
  State<CategoryAoPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<CategoryAoPage> {
  late Future<List<Product>> futureProducts = fetchProducts();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(253, 158, 158, 158),
        centerTitle: true,
        title: Image.asset(
          "images/logo.png",
          height: 100,
          width: 100,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductSearchScreen(
                          user: widget.user,
                          cart: widget.cart,
                        )),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(
                          user: widget.user,
                          cart: widget.cart, list: [],
                        )),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: DesignDrawer(
        user: widget.user,
        cart: widget.cart,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Product>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products available.'));
            } else {
              // Nếu API trả về dữ liệu sản phẩm
              return GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                  snapshot.data!.length,
                  (index) => BuildCard(
                    product: snapshot.data![index],
                    user: widget.user,
                    cart: widget.cart,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
