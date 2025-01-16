import 'package:cua_hang_ao_khong_rach/Objects/product.dart';
import 'package:cua_hang_ao_khong_rach/Objects/User.dart';
import 'package:cua_hang_ao_khong_rach/tools/Build_TextField.dart';
import 'package:flutter/material.dart';

class PayPage extends StatefulWidget {
  final Product product;
  final User user;
  const PayPage({super.key, required this.product, required this.user});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the address from user data
    addressController.text = widget.user.address ?? '';
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(253, 158, 158, 158),
        centerTitle: true,
        title: Image.asset(
          "images/logo.png",
          height: 100,
          width: 100,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
            opacity: 0.6,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 168, 151, 151).withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: const Color.fromARGB(255, 12, 12, 12)),
            ),
            width: 400,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Payment Details",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Product details
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product: ${widget.product.tenSanPham}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "Price: ${widget.product.gia} VND",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "Size: ${widget.product.SoLuong}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BuildTextField(
                  textEditingController: cardNumberController,
                  labelText: "Card Number",
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: BuildTextField(
                        textEditingController: expiryDateController,
                        labelText: "MM/YY",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: BuildTextField(
                        textEditingController: cvvController,
                        labelText: "CVV",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BuildTextField(
                  textEditingController: addressController,
                  labelText: "Shipping Address",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 45),
                        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add payment processing logic here
                        // Show success dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Payment Successful"),
                            content: const Text(
                                "Your order has been placed successfully!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                    ..pop()
                                    ..pop()
                                    ..pop(); // Return to product list
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 45),
                        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pay Now",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.white,
                          ),
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
