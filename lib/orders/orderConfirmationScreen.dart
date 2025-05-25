import 'package:cartify/route/routeName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class orderConfirmationScreen extends StatelessWidget {
  const orderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentId = Get.arguments['paymentId'];
    final amount = Get.arguments['amount'];
    final shippingAddress = Get.arguments['shippingAddress'];
    final items = Get.arguments['items'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Confirmation',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.greenAccent,],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Confirmed!',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      SizedBox(height: 10),
                      Text('Payment ID: $paymentId', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Text('Total Amount: ₹$amount', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shipping Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Name: ${shippingAddress['name']}', style: TextStyle(fontSize: 16)),
                      Text('Phone: ${shippingAddress['phone']}', style: TextStyle(fontSize: 16)),
                      Text('Address: ${shippingAddress['address']}', style: TextStyle(fontSize: 16)),
                      Text('City: ${shippingAddress['city']}', style: TextStyle(fontSize: 16)),
                      Text('State: ${shippingAddress['state']}', style: TextStyle(fontSize: 16)),
                      Text('ZIP: ${shippingAddress['zip']}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Order Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        var item = items[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(item['Name'], style: TextStyle(fontSize: 16)),
                          subtitle: Text('Price: ₹${item['Price']}', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Get.offAllNamed(Routename.bottomNavigationBar);
                  },
                  child: Text(
                    'Continue Shopping',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
