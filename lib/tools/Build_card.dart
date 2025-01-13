import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/screens/detail_product.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_Content.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatefulWidget {
  final Product product;
  final User user;
  const BuildCard({required this.product, super.key, required this.user});
  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  @override
  Widget build(BuildContext context) {
    List<Product> checkCart = widget.user.getList();
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 232, 232).withOpacity(1.0),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color.fromARGB(255, 12, 12, 12)),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                   widget.product.hinhAnh,
                  width: 200,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    children: [
                      BuildContent(
                        title: "Name: ",
                        content: widget.product.tenSanPham,
                      ),
                      const SizedBox(height: 10),
                    /*  BuildContent(
                          title: "Color: ", content: widget.product.mauSac),
                      const SizedBox(height: 10),*/
                      BuildContent(
                          title: "Price: ", content: widget.product.gia),
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
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            //----------
                            widget.user.addProduct(widget.product);
                            print(widget.product.tenSanPham);
                            print(checkCart[0].tenSanPham);
                            //----------
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            ],
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(160, 45),
                              backgroundColor:
                                  const Color.fromARGB(255, 3, 3, 3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailProduct(
                                          product: widget.product,
                                          user: widget.user,
                                        )));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Details",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            ],
                          )),
                    ],
                  ),
                )
              ])),
    );
  }
}
