import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cua_hang_ao_khong_rach/tools/Build_textField.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_textFieldPassword.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    // URL API
    const String apiUrl = "http://localhost:8888/restful_api_php/api/khachhang/them.php";

    // Dữ liệu đăng ký
    final Map<String, String> userData = {
    //  "MaKhachHang": "",
      "HoTen": nameController.text,
      "Email": emailController.text,
      "MatKhau": passwordController.text,
      "SoDienThoai": phoneController.text,
      "TrangThai": "HoatDong",
    };

    // Gửi yêu cầu POST
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      );

      // Kiểm tra phản hồi
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          // Hiển thị thông báo thành công
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Dang ky thanh cong!")),
          );

          // Điều hướng quay lại trang đăng nhập
          Navigator.pop(context);
        } else {
          // Hiển thị lỗi từ API
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi: ${responseData['message']}")),
          );
        }
      } else {
        throw Exception("Failed to register user: ${response.statusCode}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đã xảy ra lỗi: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(245, 6, 209, 228),
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 168, 151, 151).withOpacity(0.5),
                borderRadius: BorderRadius.circular(50),
                border:
                    Border.all(color: const Color.fromARGB(255, 12, 12, 12)),
              ),
              height: 700,
              width: 350,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/logo.png",
                      height: 120,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildTextField(
                        textEditingController: nameController,
                        labelText: "FullName"),
                    const SizedBox(
                      height: 10,
                    ),
                    
                    BuildTextField(
                        textEditingController: phoneController,
                        labelText: "Phone"),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildTextField(
                        textEditingController: emailController,
                        labelText: "Email"),
                    const SizedBox(
                      height: 10,
                    ),
                   
                    BuildTextFieldPassword(
                        textEditingController: passwordController,
                        labelText: "Password"),
                    const SizedBox(height: 10),
                    BuildTextFieldPassword(
                        textEditingController: confirmPasswordController,
                        labelText: "Confirm Password"),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(160, 45),
                                backgroundColor:
                                    const Color.fromARGB(255, 9, 9, 9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await registerUser();
                             Navigator.pop(context);
                           },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(160, 45),
                                backgroundColor:
                                    const Color.fromARGB(255, 9, 9, 9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )
                              ],
                            )),
                      ],
                    )
                  ]),
            ))));
  }
}
