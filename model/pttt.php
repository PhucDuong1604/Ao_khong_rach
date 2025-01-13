<?php
class PhuongThucThanhToan
{
    private $conn;
    //thuộc tính của bảng khach_hang
    public $MaPhuongThuc;
    public $TenPhuongThuc ;
    public $MoTa ;
    public $TrangThai ;
    

    //connect database
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
