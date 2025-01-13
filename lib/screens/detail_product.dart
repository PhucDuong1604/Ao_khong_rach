import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/tools/Desgin_Drawer.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailProduct extends StatefulWidget {
  Product product;
  User user;
  DetailProduct({super.key, required this.product, required this.user});
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
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
                // Xử lý khi người dùng nhấn vào nút tìm kiếm
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
                // Xử lý khi người dùng nhấn vào nút thông báo
              },
            ),
          ],
        ),
        drawer: DesignDrawer(
          user: widget.user,
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
                    BuildContent("Color: ", widget.product.mauSac),
                    const SizedBox(height: 10),
                    BuildContent("Price: ", widget.product.gia ),
                    const SizedBox(height: 10),
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
                          widget.user.addProduct(widget.product);
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
