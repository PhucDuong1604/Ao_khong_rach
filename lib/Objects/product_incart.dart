class ProductInCart {
  final String maSanPham;
  final String tenSanPham;
  final String gia;
  final String hinhAnh;
  int soLuong;
  final String mauSac;
  final String kichThuoc;
  bool checked = false;

  ProductInCart({
    required this.maSanPham,
    required this.tenSanPham,
    required this.gia,
    required this.hinhAnh,
    required this.soLuong,
    required this.mauSac,
    required this.kichThuoc,
  });
  @override
  String toString() {
    return 'ProductInCart(maSanPham: $maSanPham, tenSanPham: $tenSanPham, gia: $gia, '
        'hinhAnh: $hinhAnh, soLuong: $soLuong, mauSac: $mauSac, kichThuoc: $kichThuoc)';
  }

  double totalPrice() {
    return soLuong * double.parse(gia);
  }

  void increaseQuantity({int amount = 1}) {
    soLuong += amount;
    print(soLuong);
  }

  void decreaseQuantity({int amount = 1}) {
    if (soLuong > amount) {
      soLuong -= amount;
    } else {
      soLuong = 1;
    }
    print(soLuong);
  }

  Map<String, dynamic> toJson() {
    return {
      'maSanPham': maSanPham,
      'tenSanPham': tenSanPham,
      'gia': gia,
      'hinhAnh': hinhAnh,
      'soLuong': soLuong,
      'mauSac': mauSac,
      'kichThuoc': kichThuoc,
    };
  }

  factory ProductInCart.fromJson(Map<String, dynamic> json) {
    return ProductInCart(
      maSanPham: json['maSanPham'],
      tenSanPham: json['tenSanPham'],
      gia: json['gia'],
      hinhAnh: json['hinhAnh'],
      soLuong: json['soLuong'] ?? 1,
      mauSac: json['mauSac'],
      kichThuoc: json['kichThuoc'],
    );
  }
}
