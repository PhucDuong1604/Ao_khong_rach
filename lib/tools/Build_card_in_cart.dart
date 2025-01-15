
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product_incart.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_Content.dart';
import 'package:flutter/material.dart';

class BuildCardInCart extends StatefulWidget {
  final ProductInCart product;
  final User user;
  final Cart cart;
  const BuildCardInCart({required this.product, super.key, required this.user, required this.cart});

  @override
  State<BuildCardInCart> createState() => _BuildCardInCartState();
}

class _BuildCardInCartState extends State<BuildCardInCart> {

  ProductInCart getpro(ProductInCart product){
    ProductInCart productInCart = new ProductInCart(maSanPham: product.maSanPham, tenSanPham: product.tenSanPham, gia: product.gia, hinhAnh: product.hinhAnh, mauSac: product.mauSac, kichThuoc: product.kichThuoc);
    return productInCart;
  }

  void removeProduct() {
    print('Sản phẩm đã được xóa khỏi giỏ hàng');
  }
  int _number = 0;
  int count = 0;

  void _increase() {
    setState(() {
      widget.product.increaseQuantity();
      _number = widget.product.soLuong;
    });
  }

  void _decrease() {
    setState(() {
      widget.product.decreaseQuantity();
      _number = widget.product.soLuong;
    });
  }

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
              widget.product.hinhAnh,
              width: 100,
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
                    title: "Color: ",
                    content: widget.product.mauSac,
                  ),
                  const SizedBox(height: 10),
                  BuildContent(
                    title: "Price: ",
                    content: widget.product.gia.toString(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          _decrease();
                          if(count == 0) count == 1;
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text((count == 0 ) ? widget.product.soLuong.toString() : '$_number', style: TextStyle(fontSize: 18)),
                      IconButton(
                        onPressed: (){
                          _increase();
                          if(count == 0) count == 1;
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  BuildContent(
                    title: "Total Price: ",
                    content: '${widget.product.totalPrice()} VND',
                  ),
                  IconButton(
                    onPressed: removeProduct,
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
