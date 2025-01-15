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
    this.soLuong = 1,
    required this.mauSac,
    required this.kichThuoc,
  });
  @override
  String toString() {
    return 'ProductInCart(maSanPham: $maSanPham, tenSanPham: $tenSanPham, gia: $gia, '
        'hinhAnh: $hinhAnh, soLuong: $soLuong, mauSac: $mauSac, kichThuoc: $kichThuoc)';
  }

  // Tính tổng giá trị sản phẩm trong giỏ hàng
  double totalPrice() {
    return soLuong * double.parse(gia);
  }

  // Tăng số lượng sản phẩm
  void increaseQuantity({int amount = 1}) {
    soLuong += amount;
    print(soLuong);
  }

  // Giảm số lượng sản phẩm
  void decreaseQuantity({int amount = 1}) {
    if (soLuong > amount) {
      soLuong -= amount;
    } else {
      soLuong = 1; // Đảm bảo số lượng không âm
    }
    print(soLuong);
  }

  // Chuyển đổi đối tượng sang JSON
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

  // Tạo đối tượng từ JSON
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
