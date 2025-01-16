import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/Objects/order.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product_incart.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_Content.dart';
import 'package:flutter/material.dart';

class OrderForClient extends StatefulWidget {
  final Order order;
  User user;

  OrderForClient({
    super.key,
    required this.order,
    required this.user,
  });

  @override
  State<OrderForClient> createState() => _CartPageState();
}

class _CartPageState extends State<OrderForClient> {
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
    print(widget.order.getProducts());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(253, 158, 158, 158),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
              itemCount: widget.order.getProducts().length,
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
                            widget.order.getProducts()[index].hinhAnh,
                            width: 130,
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
                                content: widget.order
                                    .getProducts()[index]
                                    .tenSanPham,
                              ),
                              const SizedBox(height: 10),
                              BuildContent(
                                title: "Color: ",
                                content:
                                    widget.order.getProducts()[index].mauSac,
                              ),
                              const SizedBox(height: 10),
                              BuildContent(
                                title: "Price: ",
                                content: widget.order.getProducts()[index].gia,
                              ),
                              const SizedBox(height: 10),
                              BuildContent(
                                title: "Quantity: ",
                                content: widget.order
                                    .getProducts()[index]
                                    .soLuong
                                    .toString(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BuildContent(
                                title: "Total Price: ",
                                content:
                                    '${widget.order.getProducts()[index].totalPrice()} VND',
                              ),
                            ],
                          ),
                        ),
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
                            "Total bill:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.order.getTotalPrice()}",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Total product:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.order.getQuantity()}",
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, fixedSize: Size(180, 100)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Pay now",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
