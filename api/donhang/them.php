<?php
header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/donhang.php");
$db = new Database();
$conn = $db->connect();

$dh = new DonHang($conn);
$data = json_decode(file_get_contents("php://input"));
print_r($data);
$dh->MaDonHang = $data->MaDonHang;
$dh->MaKhachHang = $data->MaKhachHang;
$dh->NgayDatHang= $data->NgayDatHang;
$dh->TrangThai= $data->TrangThai;
$dh->TongTien= $data->TongTien;
$dh->MaPhuongThuc= $data->MaPhuongThuc;
$dh->NgayGiaoHang= $data->NgayGiaoHang;
$dh->MaGiamGia = $data->MaGiamGia;
$dh->MaNhanVien= $data->MaNhanVien;
$dh->TrangThaiThanhToan= $data->TrangThaiThanhToan;
$dh->TenNguoiNhan= $data->TenNguoiNhan;
$dh->DiaChi= $data->DiaChi;
$dh->SoDienThoaiNguoiNhan= $data->SoDienThoaiNguoiNhan;

$result = $sp->themDonHang();
if ($result == true) {
    echo json_encode(array("message", "Thêm DH thành công"));
} else {
    echo json_encode(array("message", "Thêm DH thất bại"));
}
