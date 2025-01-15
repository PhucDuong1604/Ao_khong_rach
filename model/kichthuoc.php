<?php
class KichThuoc
{
    private $conn;

    public $MaKichThuoc ;
    public $TenKichThuoc  ;
    public $MoTa ;
    public $TrangThai ;

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
