<?php
class HinhAnh
{
    private $conn;

    public $MaHinhAnh  ;
    public $MaSanPham   ;
    public $LinkHinhAnh ;
    public $HinhAnhChinh ;
    public $MoTaHinhAnh ;


    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachHinhAnh()
    {
        $sql = "SELECT * FROM hinhanhsanpham";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
   
}
