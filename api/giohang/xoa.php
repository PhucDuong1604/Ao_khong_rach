<?php
header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/giohang.php");
$db = new Database();
$conn = $db->connect();

$gh = new giohang($conn);
$data = json_decode(file_get_contents("php://input"));
$gh->MaNhanVien = $data->MaNhanVien;
$gh->MaNhanVien = $data->MaNhanVien;
$result = $gh->xoaNhanVien();
if ($result == true) {
    echo json_encode(array("message", "Xóa NV thành công"));
} else {
    echo json_encode(array("message", "Xóa NV thất bại"));
}
