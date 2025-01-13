<?php
 header("Content-Type: application/json");
 require_once("../../config/db.php");
 require_once("../../model/nhanvien.php");
 require_once("../../model/khachhang.php");

 $db = new Database();
 $conn = $db->connect();

 $sp = new KhachHang($conn);


$sql = "
    SELECT 
        'KhachHang' AS LoaiTaiKhoan,
        MaKhachHang AS MaTaiKhoan,
        HoTen,
        Email,
        SoDienThoai,
        MatKhau,
        TrangThai
    FROM KhachHang
    UNION ALL
    SELECT 
        'NhanVien' AS LoaiTaiKhoan,
        MaNhanVien AS MaTaiKhoan,
        HoTen,
        Email,
        SoDienThoai,
        Matkhau,
        TrangThai
    FROM NhanVien
";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $accounts = array();
    while ($row = $result->fetch_assoc()) {
        $accounts[] = $row;
    }

   
    header('Content-Type: application/json');
    echo json_encode(array("success" => true, "data" => $accounts));
} else {
    echo json_encode(array("success" => false, "message" => "Không tìm thấy tài khoản nào."));
}

// Đóng kết nối
$conn->close();
?>
