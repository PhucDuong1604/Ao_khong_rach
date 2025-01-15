import 'dart:ffi';

class Product {
  final String maSanPham;
  final String tenSanPham;
  final String moTa;
  final String gia;
  final String danhMuc;
  final String hinhAnh;
  final String soLuongTon;
  final String mauSac;
  final String kichThuoc;
  int SoLuong;
  Product({
    required this.maSanPham,
    required this.tenSanPham,
    required this.moTa,
    required this.gia,
    required this.danhMuc,
    required this.hinhAnh,
    required this.soLuongTon,
    required this.mauSac,
    required this.kichThuoc,
    required this.SoLuong
  });

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
}
