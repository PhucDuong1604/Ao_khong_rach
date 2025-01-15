import 'package:cua_hang_ao_khong_rach/Objects/cart.dart';
import 'package:cua_hang_ao_khong_rach/screens/List_products_page.dart';
import 'package:cua_hang_ao_khong_rach/screens/category_ao_page.dart';
import 'package:cua_hang_ao_khong_rach/screens/category_quan_page.dart';
import 'package:cua_hang_ao_khong_rach/screens/personal_information_page.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:flutter/material.dart';

class DesignDrawer extends StatefulWidget {
  final User user;
  final Cart cart;
  const DesignDrawer({super.key, required this.user, required this.cart});
  @override
  State<DesignDrawer> createState() => _DesignDrawerState();
}

class _DesignDrawerState extends State<DesignDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset("images/logo.png")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListProductsPage(
                            user: widget.user, cart: widget.cart,
                          )));
            },
          ),
            
          ExpansionTile(
            leading: Icon(Icons.view_list), 
            title: Text('Category'), 
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text('Áo'),
                onTap: () {
                  Navigator.push(
                   context,
                     MaterialPageRoute(builder: (context) => CategoryAoPage(user: widget.user, cart:widget.cart,)),
                );
                },
              ),
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text('Quần'),
                onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryQuanPage(user: widget.user, cart:widget.cart,)),
                  );
                },
              ),
            ],
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonalInformationPage(
                            user: widget.user,
                            cart: widget.cart,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ElevatedButton(
              onPressed: () {
                logout();
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 45),
                  backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void ControltoMainPage() {
    Navigator.pop(context);
  }

  void logout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }
}
