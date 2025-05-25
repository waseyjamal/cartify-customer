import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setdatacontroller extends GetxController {
  Rx<TextEditingController> productNameController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> discriptionController = TextEditingController().obs;
  Rx<TextEditingController> brandController = TextEditingController().obs;

  Future<void> setData(String imageUrl, productName, price,discription,brand,) async {
    try {
      await FirebaseFirestore.instance.collection('products').add({
        'ImageURL': imageUrl.toString(),
        'Product Name': productName,
        'Price': price,
        'Discription': discription,
        'Brand': brand,
        'timestamp': FieldValue.serverTimestamp(), 

      });
    } catch (e) {
      print("Error adding task: $e");
    }
  }
}

