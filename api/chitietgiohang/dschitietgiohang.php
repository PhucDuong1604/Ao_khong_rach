<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/chitietgiohang.php");
    $db = new Database();
    $conn = $db->connect();

    $ctgh = new ChiTietGioHang($conn);
    $result = $ctgh->layDanhSachChiTietGioHang();
    if (mysqli_num_rows($result) > 0) {
        $dsctgh = [];
        $dsctgh["dschitietgiohang"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $chitietgiohang = array(
                "MaChiTietGioHang " => $row["MaChiTietGioHang"],
                "MaGioHang " => $row["MaGioHang"],
                "MaSanPham " => $row["MaSanPham"],
                "SoLuong " => $row["SoLuong"],
                "Gia " => $row["Gia"],
                "TrangThai " => $row["TrangThai"],
              
            );
            array_push(  $dsctgh["dschitietgiohang"], $chitietgiohang);
        }
        echo json_encode($dsctgh);
    }
