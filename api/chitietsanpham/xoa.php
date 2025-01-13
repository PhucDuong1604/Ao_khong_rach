<?php
header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/khachhang.php");
$db = new Database();
$conn = $db->connect();

$kh = new KhachHang($conn);
$data = json_decode(file_get_contents("php://input"));
$kh->MaKhachHang = $data->MaKhachHang;
$kh->MaKhachHang = $data->MaKhachHang;
$result = $kh->xoaKhachHang();
if ($result == true) {
    echo json_encode(array("message", "Xóa kh thành công"));
} else {
    echo json_encode(array("message", "Xóa kh thất bại"));
}

