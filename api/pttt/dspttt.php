<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/pttt.php");
    $db = new Database();
    $conn = $db->connect();

    $pttt = new PhuongThucThanhToan($conn);
    $result = $pttt->layDanhSachPhuongThucThanhToan();
    if (mysqli_num_rows($result) > 0) {
        $dspttt = [];
        $dspttt["dsphuongthucthanhtoan"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $pttt = array(
                "MaPhuongThuc " => $row["MaPhuongThuc"],
                "TenPhuongThuc " => $row["TenPhuongThuc"],
                "MoTa " => $row["MoTa"],
                "TrangThai " => $row["TrangThai"],
            );
            array_push( $dspttt["dsphuongthucthanhtoan"], $pttt);
        }
        echo json_encode($dspttt);
    }
