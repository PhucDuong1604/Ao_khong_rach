<?php
session_start();
require_once("../../config/db.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data['email']) || !isset($data['current_password']) || !isset($data['new_password'])) {
        echo json_encode(["success" => false, "message" => "Thiếu thông tin cần thiết."]);
        exit;
    }
    
    $email = $data['email'];
    $current_password = $data['current_password'];
    $new_password = $data['new_password'];
    $confirm_password = $data['confirmPassword'];

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode(["success" => false, "message" => "Định dạng email không hợp lệ."]);
        exit;
    }

    if ($new_password !== $confirm_password) {
        echo json_encode(["success" => false, "message" => "Mật khẩu mới và xác nhận không khớp."]);
        exit;
    }

    if (strlen($new_password) < 8) {
        echo json_encode(["success" => false, "message" => "Mật khẩu mới phải có ít nhất 8 ký tự."]);
        exit;
    }

    // Kết nối cơ sở dữ liệu
    $db = new Database();
    $conn = $db->connect();
    if (!$conn) {
        echo json_encode(["success" => false, "message" => "Không thể kết nối cơ sở dữ liệu."]);
        exit;
    }

    // Kiểm tra tài khoản trong bảng 'TaiKhoan'
    $stmt = $conn->prepare("SELECT MatKhau FROM taikhoan WHERE Email =?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo json_encode(["success" => false, "message" => "Tài khoản không tồn tại."]);
        exit;
    }

    $user = $result->fetch_assoc();
    if ($current_password !== $user['MatKhau']) {
        echo json_encode(["success" => false, "message" => "Mật khẩu cũ không chính xác."]);
        exit;
    }

    // Cập nhật mật khẩu trong bảng 'TaiKhoan'
    $update_stmt = $conn->prepare("UPDATE TaiKhoan SET MatKhau = ? WHERE Email = ?");
    $update_stmt->bind_param("ss", $new_password, $email);

    if (!$update_stmt->execute()) {
        echo json_encode(["success" => false, "message" => "Lỗi khi cập nhật mật khẩu trong bảng TaiKhoan."]);
        exit;
    }

    // Cập nhật mật khẩu trong bảng 'KhachHang'
    $update_stmt_kh = $conn->prepare("UPDATE KhachHang SET MatKhau = ? WHERE Email = ?");
    $update_stmt_kh->bind_param("ss", $new_password, $email);

    if ($update_stmt_kh->execute()) {
        echo json_encode(["success" => true, "message" => "Đổi mật khẩu thành công."]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi khi cập nhật mật khẩu trong bảng KhachHang."]);
    }

    // Đóng kết nối và chuẩn bị các truy vấn
    $stmt->close();
    $update_stmt->close();
    $update_stmt_kh->close();
    $conn->close();

} else {
    echo json_encode(["success" => false, "message" => "Chỉ hỗ trợ phương thức POST."]);
}
?>
