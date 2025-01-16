import 'package:cua_hang_ao_khong_rach/Objects/product.dart';

class Order {
  final String MaDonHang;
  final String MaKhachHang;
  final String NgayDatHang;
  final double TongTien;
  final String TrangThai;
  final List<Product> items;

  Order({
    required this.MaDonHang,
    required this.MaKhachHang,
    required this.NgayDatHang,
    required this.TongTien,
    required this.TrangThai,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      MaDonHang: json['MaDonHang'],
      MaKhachHang: json['MaKhachHang'],
      NgayDatHang: json['NgayDatHang'],
      TongTien: double.parse(json['TongTien'].toString()),
      TrangThai: json['TrangThai'],
      items: (json['items'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }
}
