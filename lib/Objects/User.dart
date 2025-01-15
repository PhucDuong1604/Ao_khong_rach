import 'package:cua_hang_ao_khong_rach/Objects/product.dart';

class User {
  String? MaTaiKhoan;
  String? HoTen;
  String? Email;
  String? SoDienThoai;
  String? TrangThai;
  String? MatKhau;
  String? DiaChi;
  List<Product>? list = [];
  User({
    this.MaTaiKhoan,
    this.HoTen,
    this.Email,
    this.SoDienThoai,
    this.TrangThai,
    this.MatKhau,
    this.DiaChi
  });

  
}
