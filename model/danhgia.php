<?php
class DanhGiaSanPham
{
    private $conn;

    public $MaDanhGia  ;
    public $MaSanPham   ;
    public $MaKhachHang  ;
    public $DiemDanhGia ;
    public $NoiDung ;
    public $NgayDanhGia ;

    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachDanhGia()
    {
        $sql = "SELECT * FROM danhgiasanpham";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
    
    public function themDanhGia()
    {
        $sql = "INSERT INTO danhgiasanpham (MaDanhGia, MaSanPham, MaKhachHang, DiemDanhGia, NoiDung, NgayDanhGia) VALUES ";
        $sql .= "('" . $this->MaDanhGia . "', '" . $this->MaSanPham . "', '" . $this->MaKhachHang . "', '" . $this->DiemDanhGia  . "','" . $this->NoiDung . "','" . $this->NgayDanhGia . "')";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }
}
