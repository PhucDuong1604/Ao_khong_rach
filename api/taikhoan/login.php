<?php
session_start();

require_once("../../config/db.php");
require_once("../../model/taikhoan.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

        $email = $data['email'];
        $password = $data['password'];

        if (empty($email) || empty($password)) {
            echo json_encode([
                "success" => false,
                "message" => "Email và mật khẩu không được để trống!"
            ]);
            exit();
        }

        $db = new Database();
        $conn = $db->connect();
        $sql = "SELECT MaTaiKhoan, HoTen, Email, SoDienThoai, MatKhau, TrangThai, DiaChi
                FROM TaiKhoan 
                WHERE Email = ? AND MatKhau = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ss", $email, $password);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            
            if ($user['TrangThai'] === "HoatDong") {
                $_SESSION['logged_in'] = true;
                $_SESSION['email'] = $user['Email'];
                $_SESSION['MaTaiKhoan'] = $user['MaTaiKhoan'];
                $_SESSION['HoTen'] = $user['HoTen'];
                $_SESSION['DiaChi'] = $user['DiaChi'];
                
                echo json_encode([
                    "success" => true,
                    "message" => "Đăng nhập thành công",
                    "data" => [
                        "MaTaiKhoan" => $user['MaTaiKhoan'],
                        "HoTen" => $user['HoTen'],
                        "Email" => $user['Email'],
                        "SoDienThoai" => $user['SoDienThoai'],
                        "TrangThai" => $user['TrangThai'],
                        "DiaChi" => $user['DiaChi'],
                    ]
                ]);
            } else {
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
}