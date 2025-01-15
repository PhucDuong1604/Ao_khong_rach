import 'package:cua_hang_ao_khong_rach/Objects/product_incart.dart';

class Order {
  List<ProductInCart> products = [];

  void addProduct(ProductInCart product) {
    products.add(product);
    if (products.isNotEmpty) {
      print("Them thanh cong");
    }
  }

  void removeProduct(ProductInCart product) {
    products.remove(product);
    if (products.isEmpty) {
      print("xoa thanh cong");
    }
  }

  List<ProductInCart> getProducts() {
    return products;
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < products.length; i++) {
      totalPrice += products[i].totalPrice();
    }
    return totalPrice;
  }

  int getQuantity() {
    int totalQuan = 0;
    for (int i = 0; i < products.length; i++) {
      totalQuan += products[i].soLuong;
    }
    return totalQuan;
  }
}
