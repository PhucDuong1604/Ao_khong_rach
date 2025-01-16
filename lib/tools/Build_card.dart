import 'dart:convert';

import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product_incart.dart';
import 'package:cua_hang_ao_khong_rach/screens/List_products_page.dart';
import 'package:cua_hang_ao_khong_rach/screens/detail_product.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_Content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuildCard extends StatefulWidget {
  final Product product;
  final User user;
  final Cart cart;
  const BuildCard(
      {required this.product,
      super.key,
      required this.user,
      required this.cart});
  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  List<String> sizeProducts = [];
  List<String> colorsProduct = [];
  String selectedcolor = "";
  String selectedsize = "";

  Future<void> fetchColorsAndSize() async {
    final response = await http.get(Uri.parse(
        'http://localhost:8888/restful_api_php/api/chitietsanpham/dschitietsanpham.php?MaSanPham=${widget.product.maSanPham}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> sizeProductsFromApi = [];
      List<String> colorsProductFromApi = [];
      for (var item in data) {
        colorsProductFromApi.add(item['TenMauSac'].toString());
        sizeProductsFromApi.add(item['TenKichThuoc'].toString());
      }
      Set<String> uniqueColors = Set.from(colorsProductFromApi);
      Set<String> uniqueSize = Set.from(sizeProductsFromApi);
      colorsProduct = uniqueColors.toList();
      sizeProducts = uniqueSize.toList();
    } else {
      throw Exception('Failed to load colors');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchColorsAndSize();
  }

  Color getColorByName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  Checkbox BuildCheckbox(bool CheckedColor, Color nameColor) {
    return Checkbox(
      value: CheckedColor,
      onChanged: (bool? value) {
        setState(() {
          CheckedColor = value!;
        });
      },
      activeColor: nameColor,
    );
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Image.network(
                    widget.product.hinhAnh,
                    width: 250,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildContent(
                        title: "Name: ",
                        content: widget.product.tenSanPham,
                      ),
                      BuildContent(
                          title: "Price: ", content: widget.product.gia),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(160, 45),
                          backgroundColor: const Color.fromARGB(255, 3, 3, 3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailProduct(
                                      product: widget.product,
                                      user: widget.user,
                                      cart: widget.cart,
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
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        ],
                      )),
                )
              ])),
    );
  }
}
