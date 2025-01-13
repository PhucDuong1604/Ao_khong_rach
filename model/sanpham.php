<?php
class SanPham
{
    private $conn;
    //thuộc tính của bảng sanpham
    public $MaSanPham ;
    public $TenSanPham ;
    public $MoTa ;
    public $Gia ;
    public $MaDanhMuc  ;
    public $TrangThai ;
    
    

    //connect database
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
