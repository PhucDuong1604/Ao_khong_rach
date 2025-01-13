<?php
    header("Content-Type: application/json");
    require_once("../../config/db.php");
    require_once("../../model/sanpham.php");

    $db = new Database();
    $conn = $db->connect();

    $sp = new SanPham($conn);

    // Câu truy vấn SQL để lấy dữ liệu sản phẩm kèm theo các thông tin liên quan
    $query = "
        SELECT 
            sp.MaSanPham, sp.TenSanPham, sp.Gia, sp.MoTa AS MoTaSanPham,
            dm.TenDanhMuc, 
            hs.LinkHinhAnh, hs.HinhAnhChinh, 
            ctsp.SoLuongTon,
            ms.TenMauSac, 
            kt.TenKichThuoc
        FROM 
            SanPham sp
        JOIN 
            DanhMuc dm ON sp.MaDanhMuc = dm.MaDanhMuc
        LEFT JOIN 
            HinhAnhSanPham hs ON sp.MaSanPham = hs.MaSanPham
        LEFT JOIN 
            ChiTietSanPham ctsp ON sp.MaSanPham = ctsp.MaSanPham
        LEFT JOIN 
            MauSac ms ON ctsp.MaMauSac = ms.MaMauSac
        LEFT JOIN 
            KichThuoc kt ON ctsp.MaKichThuoc = kt.MaKichThuoc
        WHERE 
            sp.TrangThai = 'ConHang'
        ORDER BY 
            sp.TenSanPham;
    ";

    // Thực thi truy vấn
    $result = mysqli_query($conn, $query);

    // Kiểm tra kết quả
    if (mysqli_num_rows($result) > 0) {
        $dssp = [];
        $dssp["dssanpham"] = [];
        $sanpham_cache = [];

        // Duyệt qua tất cả các sản phẩm
        while ($row = mysqli_fetch_assoc($result)) {
            $maSanPham = $row["MaSanPham"];
            
            // Nếu sản phẩm đã tồn tại trong mảng $sanpham_cache, gộp các chi tiết lại
            if (!isset($sanpham_cache[$maSanPham])) {
                $sanpham_cache[$maSanPham] = array(
                    "MaSanPham" => $row["MaSanPham"],
                    "TenSanPham" => $row["TenSanPham"],
                    "MoTa" => $row["MoTaSanPham"],
                    "Gia" => $row["Gia"],
                    "DanhMuc" => $row["TenDanhMuc"],
                    "HinhAnh" => $row["LinkHinhAnh"],
                    "HinhAnhChinh" => $row["HinhAnhChinh"],
                    "SoLuongTon" => $row["SoLuongTon"],
                    "MauSac" => $row["TenMauSac"],
                    "ChiTiet" => []
                );
            }

            // Thêm màu sắc và kích thước vào chi tiết sản phẩm
            if ($row["TenMauSac"]) {
                $sanpham_cache[$maSanPham]["ChiTiet"][] = array(
                    "MauSac" => $row["TenMauSac"],
                    "KichThuoc" => $row["TenKichThuoc"]
                );
            }
        }

        // Chuyển từ mảng cache thành kết quả trả về
        foreach ($sanpham_cache as $sanpham) {
            $dssp["dssanpham"][] = $sanpham;
        }

        // Trả về kết quả dưới dạng JSON
        echo json_encode($dssp);
    } else {
        echo json_encode(array("message" => "Không có sản phẩm nào."));
    }

    // Đóng kết nối
    mysqli_close($conn);
?>
