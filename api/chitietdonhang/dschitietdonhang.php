<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/chitietdonhang.php");
    $db = new Database();
    $conn = $db->connect();

    $ctsp = new ChiTietDonHang($conn);
    $result = $ctsp->layDanhSachChiTietDonHang();
    if (mysqli_num_rows($result) > 0) {
        $dsctdh = [];
        $dsctdh["dschitietdonhang"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $chitietdonhang = array(
                "MaChiTietDonHang " => $row["MaChiTietDonHang"],
                "MaDonHang " => $row["MaDonHang"],
                "MaSanPham " => $row["MaSanPham"],
                "SoLuong " => $row["SoLuong"],
                "Gia " => $row["Gia"],
              
            );
            array_push( $dsctdh["dschitietdonhang"], $chitietdonhang);
        }
        echo json_encode($dsctdh);
    }
