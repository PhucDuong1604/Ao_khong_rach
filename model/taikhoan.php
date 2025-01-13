<?php
class TaiKhoan
{
    private $conn;
    //thuộc tính của bảng nhanvien
    public $LoaiTaiKhoan;
    public $MaTaiKhoan;
    public $HoTen;
    public $Email;
    public $MatKhau;
    public $SoDienThoai;
    public $TrangThai;

    //connect database
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachTaiKhoan()
    {
        $sql = "SELECT * FROM taikhhoan";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
   
    public function themTaiKhoan()
    {
        $sql = "INSERT INTO taikhoan(LoaiTaiKhoan, MaTaiKhoan, HoTen, Email, MatKhau, SoDienThoai, TrangThai) VALUES ";
        $sql .= "('" . $this->LoaiTaiKhoan . "', '" . $this->MaTaiKhoan . "', '". $this->HoTen . "', '" . $this->Email . "', '" . $this->MatKhau . "'," ;
        $sql .= "'" . $this->SoDienThoai . "', '"  . $this->TrangThai . "')";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }
}
