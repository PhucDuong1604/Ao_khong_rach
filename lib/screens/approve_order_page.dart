import 'package:cua_hang_ao_khong_rach/Objects/order_admin.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApproveOrderPage extends StatefulWidget {
  const ApproveOrderPage({super.key});

  @override
  State<ApproveOrderPage> createState() => _ApproveOrderPageState();
}

class _ApproveOrderPageState extends State<ApproveOrderPage> {
  List<Order> orders = [];
  bool isLoading = false;
  String filterStatus = 'All'; 

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8888/restful_api_php/api/donhang/dsdonhang.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['orders'];
        setState(() {
          orders = data.map((order) => Order.fromJson(order)).toList();
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading orders: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8888/restful_api_php/api/donhang/sua.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'MaDonHang': orderId,
          'TrangThai': newStatus,
        }),
      );

      if (response.statusCode == 200) {
        fetchOrders(); 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order status updated successfully')),
        );
      } else {
        throw Exception('Failed to update order status');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating order status: $e')),
      );
    }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchOrders,
          ),
        ],
      ),
      body: Column(
        children: [
          // Status filter
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Filter by status: '),
                DropdownButton<String>(
                  value: filterStatus,
                  items: ['All', 'Pending', 'Approved', 'Rejected']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      filterStatus = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          // Orders list
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      if (filterStatus != 'All' &&
                          order.TrangThai != filterStatus) {
                        return Container();
                      }
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          title: Text('Order #${order.MaDonHang}'),
                          subtitle: Text(
                              '${order.NgayDatHang}\nStatus: ${order.TrangThai}'),
                          trailing: Text(
                            '₫${order.TongTien.toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          children: [
                            ...order.items.map((item) => ListTile(
                                  title: Text(item.tenSanPham),
                                  subtitle: Text(
                                      'Color: ${item.mauSac}, Size: ${item.kichThuoc}'),
                                  trailing: Text(
                                      '${item.SoLuong}x ₫${item.gia.toString()}'),
                                )),
                            if (order.TrangThai == 'Pending')
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => updateOrderStatus(
                                          order.MaDonHang, 'Approved'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: const Text('Approve'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => updateOrderStatus(
                                          order.MaDonHang, 'Rejected'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text('Reject'),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
