
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
  DetailProduct({super.key, required this.product, required this.user, required this.cart});
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  String selectedColor = ''; 
  String selectedSize = '';
  void updateProduct() {
    print('Cập nhật sản phẩm với màu: $selectedColor và kích thước: $selectedSize');
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
              onPressed: () {
              },
            ),
          ],
        ),
       
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    const SizedBox(width: 10),
                    Image.network(
                      widget.product.hinhAnh,
                      width: 400,
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  children: [
                    BuildContent("Name: ", widget.product.tenSanPham),
                    const SizedBox(height: 10),
                   
                    BuildContent("Price: ", widget.product.gia as String ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("Color:"),
                    SizedBox(width: 20,),
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
                        Text('Red'),
                        Checkbox(
                          value: selectedColor == 'Black',
                          onChanged: (bool? value) {
                            setState(() {
                              selectedColor = 'Black';
                            });
                          },
                        ),
                        Text('Black'),
                        Checkbox(
                          value: selectedColor == 'White',
                          onChanged: (bool? value) {
                            setState(() {
                              selectedColor = 'White';
                            });
                          },
                        ),
                        Text('White'),
                      ],
                    ),
                  ],
                ),
              ),
              // Checkbox cho kích thước
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(" Size:"),
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
                        Text('S'),
                        Checkbox(
                          value: selectedSize == 'M',
                          onChanged: (bool? value) {
                            setState(() {
                              selectedSize = 'M';
                            });
                          },
                        ),
                        Text('M'),
                        Checkbox(
                          value: selectedSize == 'L',
                          onChanged: (bool? value) {
                            setState(() {
                              selectedSize = 'L';
                            });
                          },
                        ),
                        Text('L'),
                      ],
                    ),
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
                          widget.cart.addProduct(widget.product);
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
                        onPressed: () {
                          updateProduct();
                        },
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
