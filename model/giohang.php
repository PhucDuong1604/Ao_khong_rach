<?php
class GioHang
{
    private $conn;
    // Thuộc tính của bảng giohang
    public $MaGioHang;
    public $MaKhachHang;

    // Kết nối với cơ sở dữ liệu
    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    // Lấy danh sách giỏ hàng
    public function layDanhSachGioHang()
    {
        $sql = "SELECT * FROM giohang";
        $result = mysqli_query($this->conn, $sql);

        if ($result) {
            $gioHangList = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $gioHangList[] = $row;
            }
            return $gioHangList; // Trả về mảng kết quả
        } else {
            return null; // Nếu có lỗi, trả về null
        }
    }

    public function layGioHangCuaKhachHang($maKhachHang) {
        // Truy vấn giỏ hàng của khách hàng
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
        $stmt->bind_param("s", $maKhachHang);  // "s" là kiểu dữ liệu cho VARCHAR
        $stmt->execute();
        $result = $stmt->get_result();

        // Kiểm tra kết quả truy vấn và trả về dữ liệu
        if ($result->num_rows > 0) {
            $gioHangList = [];
            while ($row = $result->fetch_assoc()) {
                $gioHangList[] = $row; // Thêm mỗi sản phẩm vào mảng giỏ hàng
            }
            return $gioHangList; // Trả về mảng giỏ hàng của khách hàng
        } else {
            return null; // Nếu không có sản phẩm trong giỏ hàng, trả về null
        }
    }

    // Thêm sản phẩm vào giỏ hàng của khách hàng
    public function themSanPhamVaoGioHang($maKhachHang, $maSanPham, $soLuong, $donGia) 
    {
        // Kiểm tra xem khách hàng đã có giỏ hàng chưa
        $sqlCheck = "SELECT MaGioHang FROM GioHang WHERE MaKhachHang = ? AND TrangThai = 'ĐangMua' LIMIT 1";
        $stmt = $this->conn->prepare($sqlCheck);
        $stmt->bind_param("s", $maKhachHang);
        $stmt->execute();
        $stmt->bind_result($maGioHang);
        $stmt->fetch();

        if ($maGioHang) {
            // Giỏ hàng đã tồn tại, thêm sản phẩm vào giỏ hàng
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
            // Nếu khách hàng chưa có giỏ hàng, tạo giỏ hàng mới
            $sqlCreateCart = "INSERT INTO GioHang (MaKhachHang, TrangThai) VALUES (?, 'ĐangMua')";
            $stmt = $this->conn->prepare($sqlCreateCart);
            $stmt->bind_param("s", $maKhachHang);
            if ($stmt->execute()) {
                // Sau khi tạo giỏ hàng, thêm sản phẩm vào giỏ hàng
                $maGioHang = $stmt->insert_id; // Lấy ID giỏ hàng mới tạo
                return $this->themSanPhamVaoGioHang($maKhachHang, $maSanPham, $soLuong, $donGia);
            } else {
                return "Lỗi khi tạo giỏ hàng";
            }
        }
    }
}
?>
