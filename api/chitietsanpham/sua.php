<?php
header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/khachhang.php");
$db = new Database();
$conn = $db->connect();

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->MaKhachHang)) {
    echo json_encode(["message" => "Mã khách hàng không được để trống."]);
    exit();
}
$khachHang = new KhachHang($conn);
$khachHang->MaKhachHang = $data->MaKhachHang;
$khachHang->HoTen = isset($data->HoTen) ? $data->HoTen : null;
$khachHang->Email = isset($data->Email) ? $data->Email : null;
$khachHang->MatKhau = isset($data->MatKhau) ? $data->MatKhau : null;
$khachHang->SoDienThoai = isset($data->SoDienThoai) ? $data->SoDienThoai : null;
$khachHang->TrangThai = isset($data->TrangThai) ? $data->TrangThai : null;

$result = $khachHang->suaKhachHang();
if ($result === true) {
    echo json_encode(["message" => "Cập nhật thông tin khách hàng thành công."]);
} else {
    echo json_encode(["message" => "Lỗi: " . $result]);
}
?>
