<?php
class NhanVien
{
    private $conn;
    //thuộc tính của bảng nhanvien
    public $MaNhanVien;
    public $HoTen;
    public $Email;
    public $MatKhau;
    public $SoDienThoai;
    public $VaiTro;
    public $TrangThai;

    //connect database
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachNhanVien()
    {
        $sql = "SELECT * FROM nhanvien";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
    public function xoaNhanVien()
    {
        $sql = "DELETE FROM nhanvien WHERE MaNhanVien ='" . $this->MaNhanVien . "'";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }
    public function themNhanVien()
    {
        $sql = "INSERT INTO nhanvien(MaNhanVien, HoTen, Email, MatKhau, SoDienThoai, VaiTro, TrangThai) VALUES ";
        $sql .= "('" . $this->MaNhanVien . "', '" . $this->HoTen . "', '" . $this->Email . "', '" . $this->MatKhau . "'," ;
        $sql .= "'" . $this->SoDienThoai . "', '" . $this->VaiTro . "', '" . $this->TrangThai . "')";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }
}
