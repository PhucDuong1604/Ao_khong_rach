import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/tools/Desgin_Drawer.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailProduct extends StatefulWidget {
  Product product;
  User user;
  Cart cart;
  DetailProduct(
      {super.key,
      required this.product,
      required this.user,
      required this.cart});
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  String selectedColor = '';
  String selectedSize = '';

  void _increase() {
    setState(() {
      widget.product.increaseQuantity();
    });
  }

  void _decrease() {
    setState(() {
      widget.product.decreaseQuantity();
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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                widget.product.soluongtronggiohang = 1;
                print(widget.product.soluongtronggiohang);
              },
              icon: const Icon(Icons.arrow_back)),
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
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                widget.product.hinhAnh,
                width: 350,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  children: [
                    BuildContent("Name: ", widget.product.tenSanPham),
                    BuildContent(
                        "Price: ", "${widget.product.gia as String} VND"),
                    Row(
                      children: [
                        const Text(
                          "Color:",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: selectedColor == 'Red',
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedColor = 'Red';
                                });
                              },
                            ),
                            const Text('Red',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Checkbox(
                              value: selectedColor == 'Black',
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedColor = 'Black';
                                });
                              },
                            ),
                            const Text('Black',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Checkbox(
                              value: selectedColor == 'White',
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedColor = 'White';
                                });
                              },
                            ),
                            const Text('White',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Size:",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: selectedSize == 'S',
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedSize = 'S';
                                });
                              },
                            ),
                            const Text('S',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            const SizedBox(
                              width: 24,
                            ),
                            Checkbox(
                              value: selectedSize == 'M',
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedSize = 'M';
                                });
                              },
                            ),
                            const Text('M',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            const SizedBox(
                              width: 29,
                            ),
                            Checkbox(
                              value: selectedSize == 'L',
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedSize = 'L';
                                });
                              },
                            ),
                            const Text('L',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Quantity:",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            _decrease();
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text("${widget.product.soluongtronggiohang}",
                            style: TextStyle(fontSize: 20)),
                        IconButton(
                          onPressed: () {
                            _increase();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    BuildContent(
                        "Total Price: ", "${widget.product.totalPrice()} VND"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(160, 45),
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Product temp = widget.product.getProduct();
                          temp.setColorAndSize(selectedColor, selectedSize);
                          print(temp.getProduct());
                          if (selectedColor == "" || selectedSize == "") {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Warning"),
                                content:
                                    const Text("Please chose a color and size"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Xác nhận thêm sản phẩm"),
                                content: Text(
                                    "Your product is \nName: ${temp.tenSanPham}\nColor: ${temp.mauSac}\nSize: ${temp.kichThuoc}\nQuantity: ${temp.soluongtronggiohang}"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      widget.cart.addProduct(temp);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Add to cart"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Add to cart",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )
                          ],
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(160, 45),
                            backgroundColor: const Color.fromARGB(255, 3, 3, 3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.payment,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Buy now",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )
                          ],
                        )),
                  ],
                ),
              )
            ]));
  }

  Widget BuildContent(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Text(
          content,
          style: const TextStyle(fontSize: 25, color: Colors.black),
        ),
      ],
    );
  }
}
