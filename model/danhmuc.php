<?php
class DanhMuc
{
    private $conn;
    //thuộc tính của bảng danhmuc
    public $MaDanhMuc  ;
    public $TenDanhMuc  ;
    public $MoTa ;
    public $TrangThai ;

    //connect database
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachDanhMuc()
    {
        $sql = "SELECT * FROM danhmuc";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
    
}
