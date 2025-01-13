<?php
header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/taikhoan.php");
//require_once("../../api/taikhoan/login.php");
// Kiểm tra nếu session đã được bắt đầu
session_start();

// Kiểm tra nếu không phải là request POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["success" => false, "message" => "Phương thức yêu cầu không hợp lệ"]);
    exit;
}

// Lấy dữ liệu từ request
$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra nếu thiếu dữ liệu
if (empty($data['MatKhau']) || empty($data['new_password'])) {
    echo json_encode(["success" => false, "message" => "Thiếu thông tin cần thiết"]);
    exit;
}

$currentPassword = $data['MatKhau'];
$newPassword = $data['new_password'];
/*
// Kiểm tra nếu chưa đăng nhập
if (!isset($_SESSION['Email'])) {
    echo json_encode(["success" => false, "message" => "Bạn chưa đăng nhập"]);
    exit;
}
*/
echo "Đăng nhập thành công. Email trong session: " . $_SESSION['Email'];
$email = $_SESSION['Email'];

$db = new Database();
$conn = $db->connect();

$sql = "SELECT MatKhau FROM TaiKhoan WHERE Email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $taiKhoan = $result->fetch_assoc();

    // Kiểm tra mật khẩu hiện tại
    if (!password_verify($currentPassword, $taiKhoan['MatKhau'])) {
        echo json_encode(["success" => false, "message" => "Mật khẩu hiện tại không đúng"]);
        exit;
    }

    // Kiểm tra mật khẩu mới có giống mật khẩu cũ không
    if (password_verify($newPassword, $taiKhoan['MatKhau'])) {
        echo json_encode(["success" => false, "message" => "Mật khẩu mới không được giống mật khẩu cũ"]);
        exit;
    }

    // Kiểm tra mật khẩu mới (ví dụ: dài ít nhất 6 ký tự)
    if (strlen($newPassword) < 6) {
        echo json_encode(["success" => false, "message" => "Mật khẩu mới quá ngắn"]);
        exit;
    }

    // Cập nhật mật khẩu
    $updateSql = "UPDATE TaiKhoan SET MatKhau = ? WHERE Email = ?";
    $updateStmt = $conn->prepare($updateSql);
    $updateStmt->bind_param("ss", $email);

    if ($updateStmt->execute()) {
        echo json_encode(["success" => true, "message" => "Cập nhật mật khẩu thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Cập nhật mật khẩu thất bại"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Tài khoản không tồn tại"]);
}

$conn->close();
?>
