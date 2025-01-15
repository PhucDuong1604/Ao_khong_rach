<?php
class DanhMuc
{
    private $conn;

    public $MaDanhMuc  ;
    public $TenDanhMuc  ;
    public $MoTa ;
    public $TrangThai ;

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
