<?php
class SanPham
{
    private $conn;

    public $MaSanPham ;
    public $TenSanPham ;
    public $MoTa ;
    public $Gia ;
    public $MaDanhMuc  ;
    public $TrangThai ;
    
  
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachSanPham()
    {
        $sql = "SELECT * FROM sanpham";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
   
}
