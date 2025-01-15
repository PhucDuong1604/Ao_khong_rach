import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_card.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';

Future<List<Product>> fetchProducts(String name) async {
  final response = await http.get(
    Uri.parse('http://localhost:8888/restful_api_php/api/sp/timkiem.php?name=$name')
  );

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
        moTa: item['MoTa'] ?? '',
        soLuongTon: item['SoLuongTon'] ?? '',
        maSanPham: '',
        danhMuc: '',
        SoLuong: 0
      ));
    }
    return productList;
  } else {
    throw Exception('Failed to load products');
  }
}

class ProductSearchScreen extends StatefulWidget {
  final User user;
  ProductSearchScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  TextEditingController searchController = TextEditingController();
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts("");
  }

  void searchProducts(String query) {
    setState(() {
      futureProducts = fetchProducts(query);
    });
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Nhập tên sản phẩm...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                searchProducts(query); 
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Không có sản phẩm nào phù hợp.'));
                  } else {
                    return GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) => BuildCard(
                          product: snapshot.data![index],
                          user: widget.user,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
