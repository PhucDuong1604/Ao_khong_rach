import 'dart:ffi';

class Product {
  final String maSanPham;
  final String tenSanPham;
  final String moTa;
  final String gia;
  final String danhMuc;
  final String hinhAnh;
  final String soLuongTon;
  int soluongtronggiohang;
  String mauSac;
  String kichThuoc;
  int SoLuong;
  Product(
      {required this.maSanPham,
      required this.tenSanPham,
      required this.moTa,
      required this.gia,
      required this.danhMuc,
      required this.hinhAnh,
      required this.soLuongTon,
      required this.mauSac,
      required this.kichThuoc,
      required this.SoLuong,
      this.soluongtronggiohang = 1});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      maSanPham: json['MaSanPham'],
      tenSanPham: json['TenSanPham'],
      moTa: json['MoTa'],
      gia: json['Gia'],
      danhMuc: json['DanhMuc'],
      hinhAnh: json['HinhAnh'],
      soLuongTon: json['SoLuongTon'],
      mauSac: json['MauSac'],
      kichThuoc: json['KichThuoc'],
      SoLuong: json['SoLuong'],
    );
  }
  void setColorAndSize(String color, String size) {
    mauSac = color;
    kichThuoc = size;
  }

  double totalPrice() {
    return soluongtronggiohang * double.parse(gia);
  }

  void increaseQuantity({int amount = 1}) {
    soluongtronggiohang += amount;
    print(soluongtronggiohang);
  }

  void decreaseQuantity({int amount = 1}) {
    if (soluongtronggiohang > amount) {
      soluongtronggiohang -= amount;
    } else {
      soluongtronggiohang = 1;
    }
    print(soluongtronggiohang);
  }

  int getQuantity() {
    return soluongtronggiohang;
  }

  Product getProduct() {
    return this;
  }
}
