import 'package:cua_hang_ao_khong_rach/Objects/product.dart';

class User {
  String? MaTaiKhoan;
  String? HoTen;
  String? Email;
  String? SoDienThoai;
  String? TrangThai;
  String? MatKhau;
  List<Product>? list = [];
  User({
    this.MaTaiKhoan,
    this.HoTen,
    this.Email,
    this.SoDienThoai,
    this.TrangThai,
    this.MatKhau,
  });

  void addProduct(Product product) {
    list ??= List.empty();
    /*for (int i = 0; i < list!.length; i++) {
      if(list[i] == product.name) {

      }
    }*/
    list?.add(product);
  }

  List<Product> getList() {
    return list!;
  }
}
