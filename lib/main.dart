import 'package:cua_hang_ao_khong_rach/screens/forgot_password_page.dart';
import 'package:cua_hang_ao_khong_rach/screens/login_page.dart';
import 'package:cua_hang_ao_khong_rach/screens/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgotpassword': (context) => ForgotPasswordPage(),
      },
    );
  }
}
