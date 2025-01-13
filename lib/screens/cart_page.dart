import 'dart:convert';

import 'package:cua_hang_ao_khong_rach/tools/Build_card_in_cart.dart';
import 'package:cua_hang_ao_khong_rach/tools/Desgin_Drawer.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  User user;
  
  CartPage({super.key, required this.user});
  
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

   late Future<List<Map<String, dynamic>>> _cartItems;
   
     get http => null;

  // Lấy giỏ hàng từ API
  Future<List<Map<String, dynamic>>> _fetchCartItems() async {
    final response = await http.get(
      Uri.parse('https://yourapi.com/giohang/${widget.user.MaTaiKhoan}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Không thể tải giỏ hàng');
    }
  }

  @override
  void initState() {
    super.initState();
    _cartItems = _fetchCartItems();
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
              onPressed: () {},
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
        ),
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView.builder(
                itemCount: widget.user.getList().length,
                itemBuilder: (context, index) {
                  return BuildCardInCart(
                    product: widget.user.getList()[index],
                    user: widget.user,
                  );
                }))
                );
  }
}
/*iimport 'dart:convert';
import 'package:cua_hang_ao_khong_rach/tools/Build_card_in_cart.dart';
import 'package:cua_hang_ao_khong_rach/tools/Desgin_Drawer.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // Import thư viện http

class CartPage extends StatefulWidget {
  User user;
  
  CartPage({super.key, required this.user});
  
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Map<String, dynamic>>> _cartItems;

  // Lấy giỏ hàng từ API
  Future<List<Map<String, dynamic>>> _fetchCartItems() async {
    final response = await http.get(  // Sử dụng http.get từ thư viện http
      Uri.parse('http://localhost:8888/restful_api_php/api/giohang/dsgiohang.php?MaKhachHang=${widget.user.MaTaiKhoan}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Không thể tải giỏ hàng');
    }
  }

  @override
  void initState() {
    super.initState();
    _cartItems = _fetchCartItems();
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
            onPressed: () {},
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
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Giỏ hàng trống'));
          } else {
            // Hiển thị giỏ hàng
            var cartItems = snapshot.data!;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var item = cartItems[index];
                return ListTile(
                  title: Text('Sản phẩm: ${item['MaChiTietSanPham']}'),
                  subtitle: Text('Số lượng: ${item['SoLuong']} | Giá: ${item['Gia']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

*/
//Hiện thực danh sách giỏ h
