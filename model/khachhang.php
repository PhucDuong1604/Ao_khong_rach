<?php
class KhachHang
{
    private $conn;
    // Thuộc tính của bảng khachhang
    public $MaKhachHang;
    public $HoTen;
    public $Email;
    public $MatKhau;
    public $SoDienThoai;
    public $TrangThai;

    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    public function layDanhSachKhachHang()
    {
        $sql = "SELECT * FROM khachhang";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }

    public function themKhachHang()
    {
        if (empty($this->MaKhachHang)) {
            // Tạo mã khách hàng tự động
            $this->MaKhachHang = $this->generateMaKhachHang();
        }
        $sql = "INSERT INTO khachhang(MaKhachHang, HoTen, Email, MatKhau, SoDienThoai, TrangThai) VALUES ";
        $sql .= "('" . $this->MaKhachHang . "', '" . $this->HoTen . "', '" . $this->Email . "', '" . $this->MatKhau . "'," ;
        $sql .= "'" . $this->SoDienThoai . "', '" . $this->TrangThai . "')";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }

    private function generateMaKhachHang()
    {
        // Tạo mã khách hàng dựa trên dữ liệu hiện có
        $query = "SELECT MAX(MaKhachHang) AS LastID FROM KhachHang";
        $result = mysqli_query($this->conn, $query);

        if ($result) {
            $row = mysqli_fetch_assoc($result);
            if ($row && $row['LastID']) {
                $lastIdNumber = (int) substr($row['LastID'], 2); // Tách số từ "KH001"
                $newId = "KH" . str_pad($lastIdNumber + 1, 3, "0", STR_PAD_LEFT); // Sinh mã mới
                return $newId;
            }
        }
        // Nếu không có dữ liệu, trả về mã mặc định
        return "KH001";
    }
  
    
    public function suaKhachHang()
    {
        $sql = "UPDATE khachhang SET 
                    HoTen = '" . $this->HoTen . "',
                    Email = '" . $this->Email . "',
                    MatKhau = '" . $this->MatKhau . "',
                    SoDienThoai = '" . $this->SoDienThoai . "',
                    TrangThai = '" . $this->TrangThai . "'
                WHERE MaKhachHang = '" . $this->MaKhachHang . "'";

        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }

}
?>
