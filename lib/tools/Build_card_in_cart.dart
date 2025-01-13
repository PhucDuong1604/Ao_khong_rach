import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_Content.dart';
import 'package:flutter/material.dart';

class BuildCardInCart extends StatefulWidget {
  final Product product;
  final User user;
  const BuildCardInCart({required this.product, super.key, required this.user});
  @override
  State<BuildCardInCart> createState() => _BuildCardInCartState();
}

class _BuildCardInCartState extends State<BuildCardInCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 176, 176, 176).withOpacity(0.9),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color.fromARGB(255, 12, 12, 12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
               widget.product.hinhAnh ,
                width: 200,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildContent(
                      title: "Name: ",
                      content: widget.product.tenSanPham,
                    ),
                    const SizedBox(height: 10),
                    BuildContent(
                        title: "Color: ", content: widget.product.mauSac),
                    const SizedBox(height: 10),
                    BuildContent(
                        title: "Price: ", content: widget.product.gia),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
