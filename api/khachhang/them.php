<?php
header("Content-Type: application/json");

require_once("../../config/db.php");
require_once("../../model/khachhang.php");
require_once("../../model/taikhoan.php");

$db = new Database();
$conn = $db->connect();

$khachHang = new KhachHang($conn);
$taiKhoan = new TaiKhoan($conn);

$data = json_decode(file_get_contents("php://input"));

$khachHang->MaKhachHang = $data->MaKhachHang;
$khachHang->HoTen = $data->HoTen;
$khachHang->Email = $data->Email;
$khachHang->MatKhau = $data->MatKhau;
$khachHang->SoDienThoai = $data->SoDienThoai;
$khachHang->TrangThai = $data->TrangThai;

$resultKhachHang = $khachHang->themKhachHang(); 

if ($resultKhachHang === true) {
    $taiKhoan->LoaiTaiKhoan = 'KhachHang';
    $taiKhoan->MaTaiKhoan = $khachHang->MaKhachHang;
    $taiKhoan->HoTen = $khachHang->HoTen;
    $taiKhoan->Email = $khachHang->Email;
    $taiKhoan->MatKhau = $khachHang->MatKhau;
    $taiKhoan->SoDienThoai = $khachHang->SoDienThoai;
    $taiKhoan->TrangThai = $khachHang->TrangThai;

    $resultTaiKhoan = $taiKhoan->themTaiKhoan(); 

    if ($resultTaiKhoan === true) {
        echo json_encode(["message" => "Thêm khách hàng và tài khoản thành công!"]);
    } else {
        echo json_encode(["message" => "Thêm tài khoản thất bại: " . $resultTaiKhoan]);
    }
} else {
    echo json_encode(["message" => "Thêm khách hàng thất bại: " . $resultKhachHang]);
}
?>
