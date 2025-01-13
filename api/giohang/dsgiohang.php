<?php
header("Content-Type: application/json");

require_once("../../config/db.php");
require_once("../../model/giohang.php");



$db = new Database();
$conn = $db->connect();

$gioHang = new GioHang($conn);

// Giả sử mã khách hàng là 'KH001'
$maKhachHang = 'KH001';
$gioHangData = $gioHang->layGioHangCuaKhachHang($maKhachHang);

if ($gioHangData) {
    echo json_encode($gioHangData); // Hiển thị giỏ hàng dưới dạng JSON
} else {
    echo json_encode(["message" => "Giỏ hàng trống"]);
}
?>
