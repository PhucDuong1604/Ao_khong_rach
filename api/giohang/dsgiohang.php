<?php
header("Content-Type: application/json");

require_once("../../config/db.php");
require_once("../../model/giohang.php");

$db = new Database();
$conn = $db->connect();
if (isset($_GET['MaKhachHang']) && !empty($_GET['MaKhachHang'])) {
    $maTaiKhoan = $_GET['MaKhachHang'];
    $sql = "
      SELECT 
        giohang.MaChiTietSanPham, 
        chitietsanpham.MaMauSac, 
        giohang.Gia, 
        giohang.SoLuong, 
        hinhanhsanpham.LinkHinhAnh, 
        sanpham.TenSanPham,
        chitietsanpham.MaKichThuoc,
        (giohang.Gia * giohang.SoLuong) AS TotalPrice
      
      FROM giohang
      JOIN chitietsanpham ON giohang.MaChiTietSanPham = chitietsanpham.MaChiTietSanPham
      JOIN sanpham ON chitietsanpham.MaSanPham = sanpham.MaSanPham
      JOIN hinhanhsanpham ON sanpham.MaSanPham = hinhanhsanpham.MaSanPham
      WHERE giohang.MaKhachHang = ?
    ";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $maTaiKhoan);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $cartItems = [];
        while ($row = $result->fetch_assoc()) {
            $cartItems[] = [
                'MaChiTietSanPham' => $row['MaChiTietSanPham'],
                'MaMauSac' => $row['MaMauSac'],
                'Gia' => $row['Gia'],
                'SoLuong' => $row['SoLuong'],
                'HinhAnh' => $row['LinkHinhAnh'],
                'TenSanPham' => $row['TenSanPham'],
                'MaKichThuoc' => $row['MaKichThuoc'],
                'TotalPrice' => $row['TotalPrice']
            ];
        }
        echo json_encode($cartItems);
    } else {
        echo json_encode([]);
    }
    $stmt->close();
} else {
    echo json_encode([
        'error' => 'MaTaiKhoan parameter is required.'
    ]);
}
$conn->close();
?>
