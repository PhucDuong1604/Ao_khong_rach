<?php
class ChiTietDonHang
{
    private $conn;

    public $MaChiTietDonHang ;
    public $MaDonHang ;
    public $MaSanPham ;
    public $SoLuong;
    public $Gia;


    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachChiTietDonHang()
    {
        $sql = "SELECT * FROM chitietdonhang";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
    
    public function themChiTietDonHang()
    {
        $sql = "INSERT INTO chitietdonhang(MaChiTietDonHang, MaDonHang, MaSanPham, SoLuong, Gia) VALUES ";
        $sql .= "('" . $this->MaChiTietDonHang . "', '" . $this->MaDonHang . "', '" . $this->MaSanPham . "', '" . $this->SoLuong  .  "','" . $this->Gia .  "')";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }
}
