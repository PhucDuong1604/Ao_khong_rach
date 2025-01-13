<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/kichthuoc.php");
    $db = new Database();
    $conn = $db->connect();

    $kt = new KichThuoc($conn);
    $result = $kt->layDanhSachKichThuoc();
    if (mysqli_num_rows($result) > 0) {
        $dskt = [];
        $dskt["dskichthuoc"] = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $kichthuoc = array(
                "MaKichThuoc " => $row["MaKichThuoc"],
                "TenKichThuoc " => $row["TenKichThuoc"],
                "MoTa " => $row["MoTa"],
                "TrangThai " => $row["TrangThai"],
            );
            array_push($dskt["dskichthuoc"], $kichthuoc);
        }
        echo json_encode($dskt);
    }
