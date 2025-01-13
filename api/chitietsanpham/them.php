<?php
header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/chitietsanpham.php");  
$db = new Database();
$conn = $db->connect();

$ctsp = new ChiTietSanPham($conn);  
$data = json_decode(file_get_contents("php://input"));

$chitietsanpham = new ChiTietSanPham($conn);
$chitietsanpham->MaChiTietSanPham = isset($data->MaChiTietSanPham) ? $data->MaChiTietSanPham : null;
$chitietsanpham->MaSanPham = isset($data->MaSanPham) ? $data->MaSanPham : null;
$chitietsanpham->MaMauSac = isset($data->MaMauSac) ? $data->MaMauSac : null;
$chitietsanpham->MaKichThuoc = isset($data->MaKichThuoc) ? $data->MaKichThuoc : null;
$chitietsanpham->SoLuongTon = isset($data->SoLuongTon) ? $data->SoLuongTon : null;
$chitietsanpham->Gia = isset($data->Gia) ? $data->Gia : null;
$chitietsanpham->TrangThai = isset($data->TrangThai) ? $data->TrangThai : null;

$result = $chitietsanpham->themChiTietSanPham();  
if ($result === true) {
    echo "Thêm chi tiết sản phẩm thành công!";
} else {
    echo "Lỗi: " . $result;
}
