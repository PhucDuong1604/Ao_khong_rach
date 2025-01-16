import 'dart:convert';

import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product_incart.dart';
import 'package:http/http.dart' as http;

class Cart {
  User user;
  List<ProductInCart> products = [];
  Cart({
    required this.user,
  });

  void addProduct(Product product) {
    print("Vo duoc roi nha");
    ProductInCart pro = new ProductInCart(
        maSanPham: product.maSanPham,
        tenSanPham: product.tenSanPham,
        gia: product.gia,
        hinhAnh: product.hinhAnh,
        mauSac: product.mauSac,
        kichThuoc: product.kichThuoc,
        soLuong: product.soluongtronggiohang);

    print(pro);
    if (products.isEmpty) {
      products.add(pro);
      if (products.isEmpty)
        print("chua them duoc");
      else
        print("them thanh cong");
      return;
    }

    for (int i = 0; i < products.length; i++) {
      if ((products[i].tenSanPham == product.tenSanPham) &&
          (products[i].mauSac == product.mauSac) &&
          (products[i].kichThuoc == product.kichThuoc)) {
        products[i].soLuong += 1;
        print(products[i].soLuong);
        print("tang so luong roi ne");
        return;
      }
    }

    products.add(pro);
    print("them tiep san pham vo nha");
  }

  /*Future<List<dynamic>> layDanhSachSanPham(String maKhachHang) async {
    final response = await http.get(Uri.parse(
        'http://localhost:8888/restful_api_php/api/giohang/dsgiohang.php?MaKhachHang=${user.MaTaiKhoan}'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }*/

  /*Future<void> _layDanhSachSanPham() async {
    try {
      final data = await layDanhSachSanPham(user.MaTaiKhoan.toString());
      for (int i = 0; i < data.length; i++) {
        Product product = Product(
            maSanPham: data[i]['MaSanPham'],
            tenSanPham: data[i]['TenSanPham'],
            gia: data[i]['Gia'],
            hinhAnh: data[i]['HinhAnh'],
            mauSac: data[i]['MauSac'],
            kichThuoc: data[i]['KichThuoc']);
        addProduct(product);
      }
    } catch (e) {
      print(e);
    }
  }*/
  void deleteProduct(ProductInCart product) {
    products.remove(product);
  }

  List<ProductInCart> GetList() {
    return products.isNotEmpty ? products : [];
  }

  int getQuantity() {
    int sum = 0;
    for (int i = 0; i < products.length; i++) {
      sum += products[i].soLuong;
    }
    return sum;
  }

  double getTotalAllProducts() {
    double sum = 0;
    for (int i = 0; i < products.length; i++) {
      sum += products[i].totalPrice();
    }
    return sum;
  }

  void setAllCheckedProducts() {
    for (int i = 0; i < products.length; i++) {
      products[i].checked = false;
    }
  }
}
