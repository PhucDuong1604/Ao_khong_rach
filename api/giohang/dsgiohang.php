<?php
header("Content-Type: application/json");

require_once("../../config/db.php");
require_once("../../model/giohang.php");

$db = new Database();
$conn = $db->connect();

// Nhận mã khách hàng từ tham số GET
$maTaiKhoan = $_GET['MaTaiKhoan'];

// Truy vấn lấy dữ liệu từ giỏ hàng 
$sql = "
  SELECT 
    giohang.MaChiTietSanPham, 
    chitietsanpham.MaMauSac, 
    giohang.Gia, 
    giohang.SoLuong, 
    hinhanhsanpham.LinkHinhAnh, 
    (giohang.Gia * giohang.SoLuong) AS TotalPrice
  FROM giohang
  JOIN chitietsanpham ON giohang.MaChiTietSanPham = chitietsanpham.MaChiTietSanPham
  JOIN sanpham ON chitietsanpham.MaSanPham = sanpham.MaSanPham
  JOIN hinhanhsanpham ON sanpham.MaSanPham = hinhanhsanpham.MaSanPham
  WHERE giohang.MaKhachHang = '$maTaiKhoan'
";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // Lưu các sản phẩm vào mảng
  $cartItems = [];
  while ($row = $result->fetch_assoc()) {
    $cartItems[] = [
      'MaChiTietSanPham' => $row['MaChiTietSanPham'],
      'MaMauSac' => $row['MaMauSac'],
      'Gia' => $row['Gia'],
      'SoLuong' => $row['SoLuong'],
      'HinhAnh' => $row['LinkHinhAnh'],
      'TotalPrice' => $row['TotalPrice']
    ];
  }
  
  // Trả về kết quả dưới dạng JSON
  echo json_encode($cartItems);
} else {
  echo json_encode([]);
}

// Đóng kết nối
$conn->close();
?>
