<?php
class KichThuoc
{
    private $conn;
    //thuộc tính của bảng kichthuoc
    public $MaKichThuoc ;
    public $TenKichThuoc  ;
    public $MoTa ;
    public $TrangThai ;

    //connect database
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachKichThuoc()
    {
        $sql = "SELECT * FROM kichthuoc";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
   
}
