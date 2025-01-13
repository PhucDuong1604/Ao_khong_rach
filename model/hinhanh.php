<?php
class HinhAnh
{
    private $conn;
    //thuộc tính của bảng hinhanh
    public $MaHinhAnh  ;
    public $MaSanPham   ;
    public $LinkHinhAnh ;
    public $HinhAnhChinh ;
    public $MoTaHinhAnh ;

    //connect database
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
