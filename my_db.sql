-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 03, 2025 lúc 12:36 AM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `my_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `quan_tri_vien`
--

CREATE TABLE `quan_tri_vien` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(30) NOT NULL,
  `mat_khau` varchar(32) NOT NULL,
  `email` varchar(50) NOT NULL,
  `ho_ten` varchar(50) NOT NULL,
  `lan_dang_nhap_cuoi` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `quan_tri_vien`
--

INSERT INTO `quan_tri_vien` (`id`, `ten_dang_nhap`, `mat_khau`, `email`, `ho_ten`, `lan_dang_nhap_cuoi`) VALUES
(1, 'nvan', '202cb962ac59075b964b07152d234b70', 'nvan@caothang.edu.vn', 'Nguyễn Văn An', '2024-12-24 20:59:37'),
(2, 'lhvinh', 'b24331b1a138cde62aa1f679164fc62f', 'lhvinh@caothang.edu.vn', 'LHV', '2024-12-24 20:59:37');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sinh_vien`
--

CREATE TABLE `sinh_vien` (
  `mssv` varchar(10) NOT NULL,
  `mat_khau` varchar(32) NOT NULL,
  `ho_ten` varchar(50) NOT NULL,
  `ngay_sinh` date NOT NULL,
  `gioi_tinh` tinyint(1) NOT NULL,
  `cccd` varchar(12) NOT NULL,
  `sdt` varchar(11) NOT NULL,
  `noi_sinh` varchar(50) NOT NULL,
  `dia_chi` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sinh_vien`
--

INSERT INTO `sinh_vien` (`mssv`, `mat_khau`, `ho_ten`, `ngay_sinh`, `gioi_tinh`, `cccd`, `sdt`, `noi_sinh`, `dia_chi`) VALUES
('', '', '', '0000-00-00', 0, '', '', '', ''),
('0306212323', '202cb962ac59075b964b07152d234b70', 'Nguyễn Văn A', '2024-11-29', 0, '038452782124', '0912345789', 'Tiền Giang', 'Bến Nghé'),
('030621454', '', '', '0000-00-00', 0, '', '', '', ''),
('030621455', '030621454', '030621454', '0000-00-00', 0, '030621454', '030621454', '030621454', '030621454'),
('0306221356', 'aba36301d71f43b3a867110252dd045c', 'Nguyễn Đức Nghĩa', '2004-11-30', 0, '0306221356', '0306221356', 'Bà Rịa - Vũng Tàu', 'Bà Rịa - Vũng Tàu'),
('0306231364', '', '', '0000-00-00', 0, '', '', '', '');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `quan_tri_vien`
--
ALTER TABLE `quan_tri_vien`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sinh_vien`
--
ALTER TABLE `sinh_vien`
  ADD PRIMARY KEY (`mssv`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `quan_tri_vien`
--
ALTER TABLE `quan_tri_vien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
