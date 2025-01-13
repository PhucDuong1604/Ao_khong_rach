<?php

header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/taikhoan.php");
session_start();
$db = new Database();
$conn = $db->connect();

// Lấy dữ liệu từ request body
$data = json_decode(file_get_contents("php://input"), true);
$email = isset($data['email']) ? $data['email'] : '';
$password = isset($data['password']) ? $data['password'] : '';
/*
// Kiểm tra dữ liệu đầu vào
if (empty($email) || empty($password)) {
    echo json_encode([
        "success" => false,
        "message" => "Email và mật khẩu không được để trống!"
    ]);
    exit();
}

// Truy vấn kiểm tra tài khoản
$sql = "SELECT MaTaiKhoan, HoTen, Email, SoDienThoai, MatKhau, TrangThai 
        FROM TaiKhoan 
        WHERE Email = ? AND MatKhau = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $email, $password);
$stmt->execute();
$result = $stmt->get_result();

// Xử lý kết quả
if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();

    if ($user['TrangThai'] === "HoatDong") {
        // Lưu thông tin người dùng vào session
        $_SESSION['MaTaiKhoan'] = $user['MaTaiKhoan'];
        $_SESSION['HoTen'] = $user['HoTen'];
        $_SESSION['Email'] = $user['Email'];
        $_SESSION['SoDienThoai'] = $user['SoDienThoai'];
        $_SESSION['TrangThai'] = $user['TrangThai'];

        // Đăng nhập thành công
        echo json_encode([
            "success" => true,
            "data" => [
                "MaTaiKhoan" => $user['MaTaiKhoan'],
                "HoTen" => $user['HoTen'],
                "Email" => $user['Email'],
                "SoDienThoai" => $user['SoDienThoai'],
                "TrangThai" => $user['TrangThai']
            ]
        ]);
    } else {
        // Tài khoản bị khóa
        echo json_encode([
            "success" => false,
            "message" => "Tài khoản của bạn đã bị khóa!"
        ]);
    }
} else {
    // Email hoặc mật khẩu không đúng
    echo json_encode([
        "success" => false,
        "message" => "Email hoặc mật khẩu không đúng!"
    ]);
}

// Đóng kết nối
$stmt->close();
$conn->close();
?>
<?php

header("Content-Type: application/json");
require_once("../../config/db.php");
require_once("../../model/taikhoan.php");
*/
 // Bắt đầu session

// Kiểm tra phương thức POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Lấy dữ liệu từ request body
    $data = json_decode(file_get_contents("php://input"), true);

    // Kiểm tra xem yêu cầu có phải là đăng nhập hay đổi mật khẩu
    if (isset($data['email']) && isset($data['password'])) {
        // Đây là yêu cầu đăng nhập
        $email = $data['email'];
        $password = $data['password'];

        // Kiểm tra dữ liệu đầu vào
        if (empty($email) || empty($password)) {
            echo json_encode([
                "success" => false,
                "message" => "Email và mật khẩu không được để trống!"

            ]);
            exit();
        }

        // Truy vấn kiểm tra tài khoản
        $db = new Database();
        $conn = $db->connect();
        $sql = "SELECT MaTaiKhoan, HoTen, Email, SoDienThoai, MatKhau, TrangThai 
                FROM TaiKhoan 
                WHERE Email = ? AND MatKhau = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ss", $email, $password);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();

            if ($user['TrangThai'] === "HoatDong") {
                // Lưu thông tin người dùng vào session
                $_SESSION['Email'] = $user['Email'];
                $_SESSION['MaTaiKhoan'] = $user['MaTaiKhoan'];
                $_SESSION['HoTen'] = $user['HoTen'];
                $_SESSION['MatKhau'] = $user['MatKhau'];
                // Đăng nhập thành công
                echo json_encode([
                    "success" => true,
                    "message" => "Đăng nhập thành công",
                    "data" => [
                        "MaTaiKhoan" => $user['MaTaiKhoan'],
                        "HoTen" => $user['HoTen'],
                        "Email" => $user['Email'],
                        "SoDienThoai" => $user['SoDienThoai'],
                        "TrangThai" => $user['TrangThai']
                    ]
                ]);
            } else {
                // Tài khoản bị khóa
                echo json_encode([
                    "success" => false,
                    "message" => "Tài khoản của bạn đã bị khóa!"
                ]);
            }
        } else {
            echo json_encode([
                "success" => false,
                "message" => "Email hoặc mật khẩu không đúng!"
            ]);
        }
        
        $conn->close();
    } elseif (isset($data['MatKhau']) && isset($data['new_password'])) {
        // Đây là yêu cầu đổi mật khẩu
        if (isset($_SESSION['Email'])) {
            // Nếu có, thông báo đã lưu thành công
            echo "Email đã được lưu vào session: " . $_SESSION['Email'];
        } else {
            // Nếu không, thông báo chưa lưu
            echo "Chưa lưu email vào session.";
        }
        if (!isset($_SESSION['Email'])) {
            echo json_encode(["success" => false, "message" => "Bạn chưa đăng nhập"]);
            exit;
        }

        $currentPassword = $data['MatKhau'];
        $newPassword = $data['new_password'];

        $email = $_SESSION['Email'];

        // Kiểm tra mật khẩu hiện tại
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

            // Kiểm tra mật khẩu mới
            if (password_verify($newPassword, $taiKhoan['MatKhau'])) {
                echo json_encode(["success" => false, "message" => "Mật khẩu mới không được giống mật khẩu cũ"]);
                exit;
            }

            // Cập nhật mật khẩu mới
            $updateSql = "UPDATE TaiKhoan SET MatKhau = ? WHERE Email = ?";
            $updateStmt = $conn->prepare($updateSql);
            $updateStmt->bind_param("ss", password_hash($newPassword, PASSWORD_DEFAULT), $email);

            if ($updateStmt->execute()) {
                echo json_encode(["success" => true, "message" => "Cập nhật mật khẩu thành công"]);
            } else {
                echo json_encode(["success" => false, "message" => "Cập nhật mật khẩu thất bại"]);
            }
        } else {
            echo json_encode(["success" => false, "message" => "Tài khoản không tồn tại"]);
        }
        $conn->close();
    } else {
        echo json_encode(["success" => false, "message" => "Dữ liệu không hợp lệ"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Phương thức yêu cầu không hợp lệ"]);
}
?>
