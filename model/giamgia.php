<?php
class GiamGia
{
    private $conn;
    //thuộc tính của bảng giamgia
    public $MaGiamGia ;
    public $MaGiamGiaCode  ;
    public $MoTa ;
    public $SoTienGiam ;
    public $NgayBatDau ;
    public $NgayKetThuc ;
    public $TrangThai ;

    //connect database
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachMaGiamGia()
    {
        $sql = "SELECT * FROM magiamgia";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
   
}
