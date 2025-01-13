
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
  int quantity = 1; 

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

    String getTotalPrice() {
    // Chuyển giá từ String sang double và tính tổng tiền
    double price = double.tryParse(widget.product.gia.toString()) ?? 0.0; // Chuyển đổi từ String sang double
    double total = price * quantity; // Tính tổng giá
    return total.toStringAsFixed(2); // Chuyển thành chuỗi và làm tròn đến 2 chữ số thập phân
  }
  // Hàm xóa sản phẩm khỏi giỏ hàng
  void removeProduct() {
    // Xử lý xóa sản phẩm khỏi giỏ hàng ở đây (có thể gọi API hoặc cập nhật trạng thái)
    print('Sản phẩm đã được xóa khỏi giỏ hàng');
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
            // Hình ảnh sản phẩm
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

                  // Hiển thị số lượng sản phẩm và các nút tăng giảm
                  Row(
                    children: [
                      IconButton(
                        onPressed: decrementQuantity,
                        icon: Icon(Icons.remove),
                      ),
                      Text(quantity.toString(), style: TextStyle(fontSize: 18)),
                      IconButton(
                        onPressed: incrementQuantity,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),

                  // Hiển thị tổng tiền (Số lượng * Giá)
                  BuildContent(
                    title: "Total Price: ",
                    content: '${getTotalPrice()} VND',
                  ),

                  // Nút xóa sản phẩm
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
