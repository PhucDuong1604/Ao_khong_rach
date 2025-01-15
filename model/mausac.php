<?php
class MauSac
{
    private $conn;

    public $MaMauSac ;
    public $TenMauSac ;
    public $MaMauHex ;
    public $MoTa ;
    public $TrangThai ;
    
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachMauSac()
    {
        $sql = "SELECT * FROM mausac";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
   
}
