<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/danhgia.php");
    $db = new Database();
    $conn = $db->connect();

    $dg = new DanhGiaSanPham($conn);
    $result = $dg->layDanhSachDanhGia();
    if (mysqli_num_rows($result) > 0) {
        $dsdg = [];
        $dsdg["dsdanhgia"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $danhgia = array(
                "MaDanhGia " => $row["MaDanhGia"],
                "MaSanPham " => $row["MaSanPham"],
                "MaKhachHang " => $row["MaKhachHang"],
                "DiemDanhGia " => $row["DiemDanhGia"],
                "NoiDung " => $row["NoiDung"],
                "NgayDanhGia " => $row["NgayDanhGia"],
            );
            array_push( $dsdg["dsdanhgia"], $danhgia);
        }
        echo json_encode($dsdg);
    }
