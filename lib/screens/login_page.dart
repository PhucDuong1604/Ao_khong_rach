import 'dart:convert';
import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/screens/List_products_page.dart';
import 'package:cua_hang_ao_khong_rach/screens/forgot_password_page.dart';
import 'package:cua_hang_ao_khong_rach/screens/register_page.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_TextFieldPassword.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_TextField.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> loginUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email và mật khẩu không được để trống!")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8888/restful_api_php/api/taikhoan/login.php'), 
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      print('Response body: ${response.body}');  
      final responseData = jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });

      if (responseData['success'] == true) {
        User user = User(
          HoTen: responseData['data']['HoTen'] ?? "User",
          Email: email,
          SoDienThoai: responseData['data']['SoDienThoai'] ?? "N/A",
          MatKhau: password,
          DiaChi: responseData['data']['DiaChi']
        );
        Cart cart = Cart(user: user);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListProductsPage(user: user,cart: cart,),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } catch (e) {
       setState(() {
    isLoading = false;
  });
    print('Lỗi: $e'); 
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Có lỗi xảy ra khi đăng nhập.")),
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
              color: const Color.fromARGB(255, 168, 151, 151).withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: const Color.fromARGB(255, 12, 12, 12)),
            ),
            height: 520,
            width: 350,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/logo.png",
                  ),
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
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()));
                            },
                            child: const Text(
                              "forgot password",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 30, 2, 241),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () => loginUser(context),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(245, 45),
                          backgroundColor: const Color.fromARGB(255, 6, 9, 11),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.signIn,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                )
                              ],
                            )),
                  const SizedBox(height: 2),
                  Container(
                    height: 2,
                    color: const Color.fromARGB(255, 17, 2, 2),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 85),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Have you already account?",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: const Text(
                          "register",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 30, 2, 241),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ]),
          ))),
        );
  }
}
