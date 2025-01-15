<?php
class PhuongThucThanhToan
{
    private $conn;

    public $MaPhuongThuc;
    public $TenPhuongThuc ;
    public $MoTa ;
    public $TrangThai ;
    


    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachPhuongThucThanhToan()
    {
        $sql = "SELECT * FROM phuongthucthanhtoan";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
    
}
