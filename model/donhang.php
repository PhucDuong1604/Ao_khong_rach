<?php
class DonHang
{
    private $conn;
    //thuộc tính của bảng don_hang
    public $MaDonHang  ;
    public $MaKhachHang   ;
    public $NgayDatHang ;
    public $TrangThai ;
    public $TongTien ;
    public $MaPhuongThuc  ;
    public $NgayGiaoHang ;
    public $MaGiamGia    ;
    public $MaNhanVien  ;
    public $TrangThaiThanhToan ;
    public $TenNguoiNhan ;
    public $DiaChi  ;
    public $SoDienThoaiNguoiNhan ;

    //connect database
    public function __construct($conn)
    {
        $this->conn = $conn;
    }
    public function layDanhSachDonHang()
    {
        $sql = "SELECT * FROM donhang";
        $result = mysqli_query($this->conn, $sql);
        return $result;
    }
    public function xoaDonHang()
    {
        $sql = "DELETE FROM donhang WHERE MaDonHang ='" . $this->MaDonHang . "'";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }
    public function themDonHang()
    {
        $sql = "INSERT INTO donhang (MaDonHang, MaKhachHang, NgayDatHang, TrangThai, TongTien, MaPhuongThuc, NgayGiaoHang, MaGiamGia, MaNhanVien, TrangThaiThanhToan, TenNguoiNhan, DiaChi, SoDienThoaiNguoiNhan) VALUES ";
        $sql .= "('" . $this->MaDonHang . "', '" . $this->MaKhachHang . "', '" . $this->NgayDatHang . "', '" . $this->TrangThai  . "','" . $this->TongTien . "','" . $this->MaPhuongThuc . "',";
        $sql .= "'" . $this->NgayGiaoHang . "', '" . $this->MaGiamGia . "', '" . $this->MaNhanVien . "', '" . $this->TrangThaiThanhToan . "', '" . $this->TenNguoiNhan . "', '" . $this->DiaChi . "', '" . $this->SoDienThoaiNguoiNhan. "')";
        if (mysqli_query($this->conn, $sql)) {
            return true;
        } else {
            return mysqli_error($this->conn);
        }
    }
}
