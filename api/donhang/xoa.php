<?php
header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/nhanvien.php");
$db = new Database();
$conn = $db->connect();

$nv = new NhanVien($conn);
$data = json_decode(file_get_contents("php://input"));
$nv->MaNhanVien = $data->MaNhanVien;
$nv->MaNhanVien = $data->MaNhanVien;
$result = $nv->xoaNhanVien();
if ($result == true) {
    echo json_encode(array("message", "Xóa NV thành công"));
} else {
    echo json_encode(array("message", "Xóa NV thất bại"));
}
