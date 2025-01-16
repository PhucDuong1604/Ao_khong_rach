import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/Objects/order.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product_incart.dart';
import 'package:cua_hang_ao_khong_rach/screens/pay_page.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_Content.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final Cart cart;
  User user;

  CartPage({
    super.key,
    required this.cart,
    required this.user, required List<ProductInCart> list,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Order order = Order();
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  void _increase(ProductInCart product) {
    setState(() {
      product.increaseQuantity();
    });
  }

  void _decrease(ProductInCart product) {
    setState(() {
      product.decreaseQuantity();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cart.GetList());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(253, 158, 158, 158),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              widget.cart.setAllCheckedProducts();
            },
            icon: Icon(Icons.arrow_back)),
        title: Image.asset(
          "images/logo.png",
          height: 100,
          width: 100,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
              itemCount: widget.cart.GetList().length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 176, 176, 176)
                          .withOpacity(0.9),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: const Color.fromARGB(255, 12, 12, 12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 10),
                          child: Image.network(
                            widget.cart.GetList()[index].hinhAnh,
                            width: 140,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BuildContent(
                                title: "Name: ",
                                content:
                                    widget.cart.GetList()[index].tenSanPham,
                              ),
                              const SizedBox(height: 10),
                              BuildContent(
                                title: "Color: ",
                                content: widget.cart.GetList()[index].mauSac,
                              ),
                              const SizedBox(height: 10),
                              BuildContent(
                                title: "Price: ",
                                content: widget.cart.GetList()[index].gia,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _decrease(widget.cart.GetList()[index]);
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Text(
                                      '${widget.cart.GetList()[index].soLuong}',
                                      style: TextStyle(fontSize: 18)),
                                  IconButton(
                                    onPressed: () {
                                      _increase(widget.cart.GetList()[index]);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                              BuildContent(
                                title: "Total Price: ",
                                content:
                                    '${widget.cart.GetList()[index].totalPrice()} VND',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                              Checkbox(
                                  value: widget.cart.GetList()[index].checked,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.cart.GetList()[index].checked =
                                          value!;
                                    });
                                    if (widget.cart.GetList()[index].checked) {
                                      order.addProduct(
                                          widget.cart.GetList()[index]);
                                    } else {
                                      order.removeProduct(
                                          widget.cart.GetList()[index]);
                                    }
                                    print(order.getProducts());
                                  }),
                              IconButton(
                                color: Colors.red,
                                onPressed: () => widget.cart.deleteProduct(
                                    widget.cart.GetList()[index]),
                                icon: Icon(Icons.delete),
                              )
                            ]))
                      ],
                    ),
                  ),
                );
              })),
      bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(253, 158, 158, 158),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Tổng hoá đơn:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${order.getTotalPrice()}",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Tổng sản phẩm:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${order.getQuantity()}",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, fixedSize: Size(180, 100)),
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
                        "Đơn hàng",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
