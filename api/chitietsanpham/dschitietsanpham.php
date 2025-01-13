<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/chitietsanpham.php");
    $db = new Database();
    $conn = $db->connect();

    $ctsp = new ChiTietSanPham($conn);
    $result = $ctsp->layDanhSachChiTietSanPham();
    if (mysqli_num_rows($result) > 0) {
        $dsctsp = [];
        $dsctsp["dschitietsanpham"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $chitietsanpham = array(
                "MaChiTietSanPham " => $row["MaChiTietSanPham"],
                "MaSanPham " => $row["MaSanPham"],
                "MaMauSac " => $row["MaMauSac"],
                "MaKichThuoc " => $row["MaKichThuoc"],
                "SoLuongTon " => $row["SoLuongTon"],
                "Gia " => $row["Gia"],
                "TrangThai " => $row["TrangThai"],
              
            );
            array_push($dsctsp["dschitietsanpham"], $chitietsanpham);
        }
        echo json_encode($dsctsp);
    }
