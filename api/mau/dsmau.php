<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/mausac.php");
    $db = new Database();
    $conn = $db->connect();

    $mau = new MauSac($conn);
    $result = $mau->layDanhSachMauSac();
    if (mysqli_num_rows($result) > 0) {
        $dsmau = [];
        $dsmau["dsmau"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $mau = array(
                "MaMauSac " => $row["MaMauSac"],
                "TenMauSac " => $row["TenMauSac"],
                "MaMauHex " => $row["MaMauHex"],
                "MoTa " => $row["MoTa"],
                "TrangThai " => $row["TrangThai"],
            );
            array_push($dsmau["dsmau"], $mau);
        }
        echo json_encode($dsmau);
    }
