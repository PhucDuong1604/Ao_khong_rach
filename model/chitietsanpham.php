<?php
class ChiTietSanPham
{
    private $conn;
    // Thuộc tính của bảng chitietsanpham
    public $MaChiTietSanPham;
    public $MaSanPham;
    public $MaMauSac;
    public $MaKichThuoc;
    public $SoLuongTon;
    public $Gia;
    public $TrangThai;

    // Kết nối với cơ sở dữ liệu
    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    // Lấy danh sách chi tiết sản phẩm
    public function layDanhSachChiTietSanPham()
    {
        $sql = "SELECT * FROM chitietsanpham";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }

    // Xóa chi tiết sản phẩm
    public function xoaChiTietSanPham()
    {
        $sql = "DELETE FROM chitietsanpham WHERE MaChiTietSanPham ='" . $this->MaChiTietSanPham . "'";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }

    // Sửa chi tiết sản phẩm
    public function suaChiTietSanPham()
    {
        // Kiểm tra xem MaChiTietSanPham có tồn tại trong bảng chitietsanpham không
        $sqlCheck = "SELECT COUNT(*) FROM chitietsanpham WHERE MaChiTietSanPham = ?";
        $stmtCheck = $this->conn->prepare($sqlCheck);
        $stmtCheck->bind_param("s", $this->MaChiTietSanPham); // "s" là kiểu chuỗi
        $stmtCheck->execute();
        $resultCheck = $stmtCheck->get_result();
        $row = $resultCheck->fetch_array();

        if ($row[0] == 0) {
            return "Lỗi: MaChiTietSanPham không tồn tại!";
        }

        // Cập nhật chi tiết sản phẩm
        $sql = "UPDATE chitietsanpham SET 
                    MaSanPham = ?, 
                    MaMauSac = ?, 
                    MaKichThuoc = ?, 
                    SoLuongTon = ?, 
                    Gia = ?, 
                    TrangThai = ? 
                WHERE MaChiTietSanPham = ?";

        // Sử dụng Prepared Statement để tránh lỗi SQL Injection
        $stmt = $this->conn->prepare($sql);
        
        // Bind các tham số vào Prepared Statement
        $stmt->bind_param("sssssss", $this->MaSanPham, $this->MaMauSac, $this->MaKichThuoc, $this->SoLuongTon, $this->Gia, $this->TrangThai, $this->MaChiTietSanPham);

        if ($stmt->execute()) {
            return true;
        } else {
            return "Lỗi: " . $stmt->error;
        }
    }
}
?>
