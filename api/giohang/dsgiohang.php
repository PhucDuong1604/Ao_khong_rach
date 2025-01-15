<?php
header("Content-Type: application/json");

require_once("../../config/db.php");
require_once("../../model/giohang.php");

$db = new Database();
$conn = $db->connect();

// Kiểm tra sự tồn tại của tham số MaTaiKhoan
if (isset($_GET['MaKhachHang']) && !empty($_GET['MaKhachHang'])) {
    $maTaiKhoan = $_GET['MaKhachHang'];

    // Chuẩn bị câu truy vấn với placeholder
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
      WHERE giohang.MaKhachHang = ?
    ";

    // Chuẩn bị statement
    $stmt = $conn->prepare($sql);

    // Gắn tham số vào câu truy vấn
    $stmt->bind_param("s", $maTaiKhoan); // "s" là kiểu dữ liệu cho chuỗi (string)

    // Thực thi câu truy vấn
    $stmt->execute();

    // Lấy kết quả
    $result = $stmt->get_result();

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

    // Đóng statement
    $stmt->close();
} else {
    // Trả về lỗi nếu MaTaiKhoan không được cung cấp
    echo json_encode([
        'error' => 'MaTaiKhoan parameter is required.'
    ]);
}

// Đóng kết nối
$conn->close();
?>
