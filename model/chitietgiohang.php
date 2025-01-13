<?php
class ChiTietGioHang
{
    private $conn;
    //thuộc tính của bảng chitietgiohang
    public $MaChiTietGioHang;
    public $MaGioHang;
    public $MaSanPham;
    public $SoLuong;
    public $Gia;
    public $TrangThai;

    //connect database
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachChiTietGioHang()
    {
        $sql = "SELECT * FROM chitietgiohang";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
  
    public function themChiTietGioHang()
    {
        $sql = "INSERT INTO chitietgiohang(MaChiTietGioHang, MaGioHang, MaSanPham, SoLuong, Gia, TrangThai) VALUES ";
        $sql .= "('" . $this->MaChiTietGioHang . "', '" . $this->MaGioHang . "', '" . $this->MaSanPham . "', '" . $this->SoLuong  .  "','" . $this->Gia . "','" . $this->TrangThai . "')";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }
}
