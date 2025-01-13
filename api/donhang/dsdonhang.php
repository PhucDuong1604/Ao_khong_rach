<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/donhang.php");
    $db = new Database();
    $conn = $db->connect();

    $dh = new DonHang($conn);
    $result = $dh->layDanhSachDonHang();
    if (mysqli_num_rows($result) > 0) {
        $dsdh = [];
        $dsdh["dsdonhang"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $donhang = array(
                "MaDonHang" => $row["MaDonHang"],
                "MaKhachHang" => $row["MaKhachHang"],
                "NgayDatHang" => $row["NgayDatHang"],
                "TrangThai" => $row["TrangThai"],
                "TongTien" => $row["TongTien"],
                "MaPhuongThuc" => $row["MaPhuongThuc"],
                "NgayGiaoHang" => $row["NgayGiaoHang"],
                "MaGiamGia" => $row["MaGiamGia"],
                "MaNhanVien" => $row["MaNhanVien"],
                "TrangThaiThanhToan" => $row["TrangThaiThanhToan"],
                "TenNguoiNhan" => $row["TenNguoiNhan"],
                "DiaChi" => $row["DiaChi"],
                "SoDienThoaiNguoiNhan" => $row["SoDienThoaiNguoiNhan"],
   
            );
            array_push(  $dsdh["dsdonhang"] , $donhang);
        }
        echo json_encode($dsdh);
    }
