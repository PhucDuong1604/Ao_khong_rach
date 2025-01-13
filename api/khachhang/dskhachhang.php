<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/khachhang.php");
    $db = new Database();
    $conn = $db->connect();

    $kh = new KhachHang($conn);
    $result = $kh->layDanhSachKhachHang();
    if (mysqli_num_rows($result) > 0) {
        $dskh = [];
        $dskh["dskhachhang"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $khachhang = array(
                "MaKhachHang" => $row["MaKhachHang"],
                "HoTen" => $row["HoTen"],
                "Email" => $row["Email"],
                "MatKhau" => $row["MatKhau"],
                "SoDienThoai" => $row["SoDienThoai"],
                "TrangThai" => $row["TrangThai"],
            );
            array_push($dskh["dskhachhang"], $khachhang);
        }
        echo json_encode($dskh);
    }
