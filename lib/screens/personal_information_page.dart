import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/screens/edit_profile_page.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/screens/reset_password_page.dart';
import 'package:cua_hang_ao_khong_rach/tools/Desgin_Drawer.dart';
import 'package:flutter/material.dart';

class PersonalInformationPage extends StatefulWidget {
  final User user;
  final Cart cart;
  const PersonalInformationPage({super.key, required this.user, required this.cart});
  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(253, 158, 158, 158),
        centerTitle: true,
        title: Image.asset(
          "images/logo.png",
          height: 100,
          width: 100,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // Xử lý khi người dùng nhấn vào nút tìm kiếm
            },
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              // Xử lý khi người dùng nhấn vào nút thông báo
            },
          ),
        ],
      ),
      drawer: DesignDrawer(
        user: widget.user,
        cart: widget.cart,
      ),
      body: Center(
        child: Column(
          
          children: [
            buildDetailRow('Tên:', '${widget.user.HoTen}'),
            buildDetailRow('Số điện thoại:', '${widget.user.SoDienThoai}'),
            buildDetailRow('Email:', '${widget.user.Email}'),
            buildDetailRow('Password:', '${widget.user.MatKhau}'),
             Divider(
              color: Colors.black,  
              thickness: 2,         
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPage(
                                user: widget.user,
                              )));
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(160, 35),
                    backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                )),
                SizedBox(width: 50,),
                 ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                                user: widget.user,
                              )));
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(160, 35),
                    backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Edit profile",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                )),
              ],
            )
           
                
          ],
        ),
      ),
    );
  }
  Widget buildDetailRow(String title, String value) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 15),
          Expanded(child: Text(value))
        ]));
  }
}
