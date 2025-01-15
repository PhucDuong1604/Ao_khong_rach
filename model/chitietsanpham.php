<?php
class ChiTietSanPham
{
    private $conn;
 
    public $MaChiTietSanPham;
    public $MaSanPham;
    public $MaMauSac;
    public $MaKichThuoc;
    public $SoLuongTon;
    public $Gia;
    public $TrangThai;


    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    public function layDanhSachChiTietSanPham()
    {
        $sql = "SELECT * FROM chitietsanpham";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }


    public function xoaChiTietSanPham()
    {
        $sql = "DELETE FROM chitietsanpham WHERE MaChiTietSanPham ='" . $this->MaChiTietSanPham . "'";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }

    public function suaChiTietSanPham()
    {
 
        $sqlCheck = "SELECT COUNT(*) FROM chitietsanpham WHERE MaChiTietSanPham = ?";
        $stmtCheck = $this->conn->prepare($sqlCheck);
        $stmtCheck->bind_param("s", $this->MaChiTietSanPham); 
        $stmtCheck->execute();
        $resultCheck = $stmtCheck->get_result();
        $row = $resultCheck->fetch_array();

        if ($row[0] == 0) {
            return "Lỗi: MaChiTietSanPham không tồn tại!";
        }

        $sql = "UPDATE chitietsanpham SET 
                    MaSanPham = ?, 
                    MaMauSac = ?, 
                    MaKichThuoc = ?, 
                    SoLuongTon = ?, 
                    Gia = ?, 
                    TrangThai = ? 
                WHERE MaChiTietSanPham = ?";

        $stmt = $this->conn->prepare($sql);

        $stmt->bind_param("sssssss", $this->MaSanPham, $this->MaMauSac, $this->MaKichThuoc, $this->SoLuongTon, $this->Gia, $this->TrangThai, $this->MaChiTietSanPham);

        if ($stmt->execute()) {
            return true;
        } else {
            return "Lỗi: " . $stmt->error;
        }
    }
}
?>
