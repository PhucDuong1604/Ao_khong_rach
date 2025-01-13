<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/giamgia.php");
    $db = new Database();
    $conn = $db->connect();

    $gg = new GiamGia($conn);
    $result = $gg->layDanhSachMaGiamGia();
    if (mysqli_num_rows($result) > 0) {
        $dsgg = [];
        $dsgg["dsgiamgia"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $giamgia = array(
                "MaGiamGia " => $row["MaGiamGia"],
                "MaGiamGiaCode " => $row["MaGiamGiaCode"],
                "MoTa " => $row["MoTa"],
                "SoTienGiam " => $row["SoTienGiam"],
                "NgayBatDau " => $row["NgayBatDau"],
                "NgayKetThuc " => $row["NgayKetThuc"],
                "TrangThai " => $row["TrangThai"],
            );
            array_push( $dsgg["dsgiamgia"] , $giamgia);
        }
        echo json_encode($dsgg);
    }
