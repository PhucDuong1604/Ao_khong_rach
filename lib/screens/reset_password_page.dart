/*import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_textField.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
 // final String email;
  const ResetPage({
    super.key, required User user,
    // required this.email
     });

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
   final currentPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();
  bool isLoading = false;

  void despose() {
    super.dispose();
    currentPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  bool checkIsLoading() {
    isLoading = !isLoading;
    return isLoading;
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
              height: 500,
              width: 350,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/logo.png",
                      height: 200,
                    ),
                     BuildTextField(
                        textEditingController: passwordController,
                        labelText: "Your Password"),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildTextField(
                        textEditingController: passwordController,
                        labelText: "Password"),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildTextField(
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
                                fixedSize: Size(160, 45),
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
                                  "Back",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {},
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
                                  "Reset",
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
*/import 'dart:convert'; // Để xử lý JSON
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_textField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPage extends StatefulWidget {
  final User user; // Thông tin user được truyền vào

  const ResetPage({super.key, required this.user});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    currentPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> resetPassword() async {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showMessage("Please fill in all fields.");
      return;
    }

    if (newPassword != confirmPassword) {
      _showMessage("Passwords do not match.");
      return;
    }

    toggleLoading();

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8888/restful_api_php/api/taikhoan/login.php"), // API URL
        body: jsonEncode({
          "MatKhau": widget.user.MatKhau, // Tham chiếu tới mật khẩu hiện tại
          "current_password": currentPassword,
          "new_password": newPassword,
        }),
        headers: {"Content-Type": "application/json"},
      );
       print('Response body: ${response.body}');  // In nội dung phản hồi
        final responseData = jsonDecode(response.body);

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success']) {
        _showMessage(result['message']);
        Navigator.pop(context); // Quay lại màn hình trước đó
      } else {
        _showMessage(result['message']);
      }
    } catch (error) {
      _showMessage("An error occurred: $error");
    } finally {
      toggleLoading();
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
              color: const Color.fromARGB(255, 168, 151, 151).withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: const Color.fromARGB(255, 12, 12, 12)),
            ),
            height: 500,
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/logo.png",
                  height: 200,
                ),
                BuildTextField(
                  textEditingController: currentPasswordController,
                  labelText: "Current Password",
                  //obscureText: true,
                ),
                const SizedBox(height: 10),
                BuildTextField(
                  textEditingController: passwordController,
                  labelText: "New Password",
                //  obscureText: true,
                ),
                const SizedBox(height: 10),
                BuildTextField(
                  textEditingController: confirmPasswordController,
                  labelText: "Confirm Password",
                //  obscureText: true,
                ),
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
                        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Back",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: isLoading ? null : resetPassword,
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(160, 45),
                        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Reset",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_ios,
                                    color: Colors.white),
                              ],
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
