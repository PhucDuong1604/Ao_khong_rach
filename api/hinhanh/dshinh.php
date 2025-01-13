<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/hinhanh.php");
    $db = new Database();
    $conn = $db->connect();

    $h = new HinhAnh($conn);
    $result = $h->layDanhSachHinhAnh();
    if (mysqli_num_rows($result) > 0) {
        $dsh = [];
        $dsh["dshinhanh"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $hinhanh = array(
                "MaHinhAnh " => $row["MaHinhAnh"],
                "MaSanPham " => $row["MaSanPham"],
                "LinkHinhAnh " => $row["LinkHinhAnh"],
                "HinhAnhChinh " => $row["HinhAnhChinh"],
                "MoTaHinhAnh " => $row["MoTaHinhAnh"],
            );
            array_push( $dsh["dshinhanh"], $hinhanh);
        }
        echo json_encode($dsh);
    }
