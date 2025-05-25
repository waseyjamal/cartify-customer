import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Getcontroller extends GetxController {
  var allProducts = <Map<String, dynamic>>[].obs;
  var filterProducts = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;
  
  

  Future<void> getAllProducts() async {
    var snapshots =
        await FirebaseFirestore.instance.collection('products').get();
    var products = snapshots.docs.map((oneDoc) => oneDoc.data()).toList();
    allProducts.assignAll(products);
    // print(allProducts);
    getFilterProducts();
  }

  void getFilterProducts() {
    if (searchQuery.isEmpty || searchQuery.value == '') {
     filterProducts.assignAll(allProducts);
      
    
    } else {
      filterProducts.value = allProducts
          .where((products) =>
              products['Product Name'] != null &&
              products['Product Name']
                  .toString()
                  .toLowerCase()
                   .contains(searchQuery.value.toString().toLowerCase()))
          .toList();
    }
    update();
  
  }

  Stream<QuerySnapshot> getData() {
    Stream<QuerySnapshot> mysnapshot =
        FirebaseFirestore.instance.collection('products').snapshots();
    return mysnapshot;
  }

      Stream<QuerySnapshot> getProductData() {
    Stream<QuerySnapshot> todomysnapshot =
        FirebaseFirestore.instance.collection('products').snapshots();
    return todomysnapshot;
  }
}
