<?php
class GioHang
{
    private $conn;

    public $MaGioHang;
    public $MaKhachHang;

    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    public function layDanhSachGioHang()
    {
        $sql = "SELECT * FROM giohang";
        $result = mysqli_query($this->conn, $sql);

        if ($result) {
            $gioHangList = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $gioHangList[] = $row;
            }
            return $gioHangList; 
        } else {
            return null;
        }
    }

    public function layGioHangCuaKhachHang($maKhachHang) {
      
        $sql = "SELECT 
                    g.MaGioHang, 
                    g.MaKhachHang, 
                    g.MaChiTietSanPham, 
                    g.SoLuong, 
                    g.Gia, 
                    (g.SoLuong * g.Gia) AS TongTien 
                FROM GioHang g 
                WHERE g.MaKhachHang = ?";
        
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("s", $maKhachHang);  
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $gioHangList = [];
            while ($row = $result->fetch_assoc()) {
                $gioHangList[] = $row; 
            }
            return $gioHangList; 
        } else {
            return null; 
        }
    }


    public function themSanPhamVaoGioHang($maKhachHang, $maSanPham, $soLuong, $donGia) 
    {

        $sqlCheck = "SELECT MaGioHang FROM GioHang WHERE MaKhachHang = ? AND TrangThai = 'ĐangMua' LIMIT 1";
        $stmt = $this->conn->prepare($sqlCheck);
        $stmt->bind_param("s", $maKhachHang);
        $stmt->execute();
        $stmt->bind_result($maGioHang);
        $stmt->fetch();

        if ($maGioHang) {
  
            $sqlInsert = "INSERT INTO ChiTietGioHang (MaGioHang, MaSanPham, SoLuong, DonGia) 
                          VALUES (?, ?, ?, ?)";
            $stmt = $this->conn->prepare($sqlInsert);
            $stmt->bind_param("iiid", $maGioHang, $maSanPham, $soLuong, $donGia);
            if ($stmt->execute()) {
                return true;
            } else {
                return "Lỗi khi thêm sản phẩm vào giỏ hàng";
            }
        } else {

            $sqlCreateCart = "INSERT INTO GioHang (MaKhachHang, TrangThai) VALUES (?, 'ĐangMua')";
            $stmt = $this->conn->prepare($sqlCreateCart);
            $stmt->bind_param("s", $maKhachHang);
            if ($stmt->execute()) {
                $maGioHang = $stmt->insert_id; 
                return $this->themSanPhamVaoGioHang($maKhachHang, $maSanPham, $soLuong, $donGia);
            } else {
                return "Lỗi khi tạo giỏ hàng";
            }
        }
    }
}
?>
