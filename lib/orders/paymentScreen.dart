import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../controller/cartController.dart';
import '../models/shippingAddress.dart';
import '../route/routeName.dart';

class paymentScreen extends StatelessWidget {
  final ShippingAddress shippingAddress;
  final List<dynamic> selectedItems;
  final double totalPrice;

  paymentScreen({
    super.key,
    required this.shippingAddress,
    required this.selectedItems,
    required this.totalPrice,
  });

  final CartController cartController = Get.find<CartController>();
  late Razorpay _razorpay;

  Widget _buildShippingDetails() {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Divider(height: 20, thickness: 1),
            Row(
              children: [
                Icon(Icons.person, color: Colors.blueAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Name: ${shippingAddress.name}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blueAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Phone: ${shippingAddress.phone}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Colors.blueAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Address: ${shippingAddress.address}, ${shippingAddress.city}, ${shippingAddress.state}, ${shippingAddress.zip}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Divider(height: 20, thickness: 1),
            Expanded(
              child: ListView.separated(
                itemCount: selectedItems.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  var item = selectedItems[index];
                  return ListTile(
                    leading: Image.network(
                      item['ImageURL'], 
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['Name']),
                    trailing: Text('₹${item['Price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Total: ₹${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              openRazorpayPayment();
            },
            child: Text(
              'Proceed to Payment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black87),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent, Colors.greenAccent
              ], 
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildShippingDetails(),
            Expanded(child: _buildOrderSummary()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Success: ${response.paymentId}");
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print("Error: User not logged in");
      return;
    }
    double totalPrice = selectedItems.fold(0.0, (sum, item) {
      double price =
          item['Price'] is String ? double.parse(item['Price']) : item['Price'];
      return sum + price;
    });
    final order = {
      'paymentId': response.paymentId,
      'amount': totalPrice,
      'shippingAddress': shippingAddress.toMap(),
      'items': selectedItems,
      'status': 'Placed',
      'timestamp': FieldValue.serverTimestamp(),
      'userId': userId,
    };
    try {
      await FirebaseFirestore.instance.collection('orders').add(order);
      print("Order saved to Firestore");
    } catch (e) {
      print("Error saving order: $e");
    }
    cartController.clearCart();
    Get.toNamed(
      Routename.orderConfirmationScreen,
      arguments: {
        "paymentId": response.paymentId,
        "amount": totalPrice,
        "shippingAddress": shippingAddress.toMap(),
        "items": selectedItems,
      },
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
    Get.snackbar("Payment Failed", "Please try again.");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  void openRazorpayPayment() {
    double totalPrice = selectedItems.fold(0.0, (sum, item) {
      double price =
          item['Price'] is String ? double.parse(item['Price']) : item['Price'];
      return sum + price;
    });
    var options = {
      'key': 'rzp_test_huOPlhLk2gI4X4',
      'amount': (totalPrice * 100).toInt(),
      'name': 'Cartify',
      'description': 'Payment for Order',
      'prefill': {'contact': '9876543210', 'email': 'user@example.com'},
      'theme': {'color': '#F37254'},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }
}
