import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_TextField.dart';
import 'package:cua_hang_ao_khong_rach/tools/Desgin_Drawer.dart';

import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({super.key, required this.user});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    nameController.text = widget.user.HoTen!;
    phoneController.text = widget.user.SoDienThoai!;
    emailController.text = widget.user.Email!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(253, 158, 158, 158),
          centerTitle: true,
          title: Image.asset(
            "images/logo.png",
            height: 100,
            width: 100,
          ),
        ),
        drawer: DesignDrawer(
          user: widget.user,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage('images/bg.jpg'),
                fit: BoxFit.cover,
                opacity: 0.6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildTextField(
                  textEditingController: nameController,
                  labelText: "Full Name"),
              const SizedBox(
                height: 20,
              ),
              
              BuildTextField(
                  textEditingController: phoneController,
                  labelText: "Phone Number"),
              const SizedBox(
                height: 20,
              ),
              BuildTextField(
                  textEditingController: emailController, labelText: "Email"),
              const SizedBox(
                height: 20,
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
                          fixedSize: Size(150, 30),
                          backgroundColor: const Color.fromARGB(255, 9, 9, 9),
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
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      )),
                  const Text(
                    "|",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, GetNewInforUser());
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 35),
                          backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "SUBMIT",
                            style: TextStyle(color: Colors.white, fontSize: 15),
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
            ],
          ),
        ));
  }

  User GetNewInforUser() {
    User user = widget.user;
    user.HoTen = nameController.text;
    user.Email = emailController.text;
    user.SoDienThoai = phoneController.text;
  
    return user;
  }
}
