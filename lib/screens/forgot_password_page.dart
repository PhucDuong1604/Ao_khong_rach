import 'package:cua_hang_ao_khong_rach/screens/reset_password_page.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_textField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  
  get user => null;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  void despose() {
    super.dispose();
    emailController.dispose();
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
              height: 400,
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
                        textEditingController: emailController,
                        labelText: "Email"),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(130, 50),
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
                            onPressed: () {
                              if (isValidEmail(emailController.text)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResetPage(user: widget.user,
                                           //   email: emailController.text,
                                            )));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(190, 50),
                                backgroundColor:
                                    const Color.fromARGB(255, 9, 9, 9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Reset password",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
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

  bool checkIsLoading() {
    isLoading = !isLoading;
    return isLoading;
  }

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }
}
