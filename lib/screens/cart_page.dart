import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product_incart.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_card_in_cart.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  List<ProductInCart> list;
  User user;
  CartPage({super.key, required this.list, required this.user});
  
  get product => null;
  
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
   late Future<List<Map<String, dynamic>>> _cartItems;
   
     get http => null;

  // Lấy giỏ hàng từ API
  /*Future<List<Map<String, dynamic>>> _fetchCartItems() async {
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
*/
  @override
  void initState() {
    super.initState();
    //_cartItems = _fetchCartItems();
  }
  
  
  @override
  Widget build(BuildContext context) {
    print(widget.list.length);
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
        bottomNavigationBar: BottomAppBar(
            color: Color.fromARGB(253, 158, 158, 158),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Tổng hoá đơn:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                      Text(
                          "100.000",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        fixedSize: Size(180, 100)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.receipt_long_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Đơn hàng (4)",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ))
              ],
            )),
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView.builder(
                itemCount: widget.list.length,
                itemBuilder: (context, index) {
                  return BuildCardInCart(
                    product: widget.list[index],
                    user: widget.user,
                    cart: Cart(user: widget.user),
                  );
                }))
                );
  }
}