import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<double> totalPrice = 0.0.obs;
  var checkboxStates = <String, bool>{}.obs; // Assuming IDs are strings
  var allCartProducts = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxInt selectedItemCount = 0.obs;

  Future<void> addtoCart(String image, String name, String price) async {
    var colRef = FirebaseFirestore.instance
        .collection('allusers')
        .doc('Profile${FirebaseAuth.instance.currentUser?.uid}')
        .collection('cart');

    var docRef = await colRef.add({
      // "ProductID": ProductId,
      "ImageURL": image,
      "Name": name,
      "Price": price,
      "timestamp": FieldValue.serverTimestamp(),
      "totalPrice": price,
      "quantity": 1,
    });
    await docRef.update({
      "CartItemID": docRef.id, // Store the document ID as 'CartItemID'
    });
  }

  Future<void> fetchCartItem() async {
    isLoading.value = true;

    try {
      FirebaseFirestore.instance
          .collection("allusers")
          .doc("Profile${FirebaseAuth.instance.currentUser?.uid}")
          .collection("cart")
          .snapshots()
          .listen((querySnapshot) {
            // cartItems.value = querySnapshot.docs.map((doc) => doc.data()).toList();
            cartItems.value =
                querySnapshot.docs
                    .map((doc) => doc.data())
                    .where(
                      (item) =>
                          item['CartItemID'] != null && item['Price'] != null,
                    )
                    .toList();
          });
    } catch (e) {
      print("Error fetching cart items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleCheckbox(String productId, bool value) {
    checkboxStates[productId] = value;
    calculateTotalPrice();
    updateSelectedItemCount();
  }

  bool isChecked(String productId) {
    return checkboxStates[productId] ?? false;
  }

  void calculateTotalPrice() {
    double total = 0.0;
    checkboxStates.forEach((productId, isChecked) {
      if (isChecked) {
        var item = cartItems.firstWhere(
          (item) => item['CartItemID'] == productId,
        );
        total += double.tryParse(item['Price'].toString()) ?? 0.0;
      }
    });
    totalPrice.value = total;
  }

  void updateSelectedItemCount() {
    int count = 0;
    checkboxStates.forEach((productId, isChecked) {
      if (isChecked) {
        count++;
      }
    });
    selectedItemCount.value = count;
  }

  Future<void> deleteSelectedItems() async {
    try {
      // Get the current user's cart reference
      var cartRef = FirebaseFirestore.instance
          .collection('allusers')
          .doc('Profile${FirebaseAuth.instance.currentUser?.uid}')
          .collection('cart');

      // Iterate through the checkboxStates map
      for (var entry in checkboxStates.entries) {
        String cartItemId = entry.key;
        bool isChecked = entry.value;

        // If the item is selected, delete it from Firestore
        if (isChecked) {
          await cartRef.doc(cartItemId).delete();
        }
      }

      // Clear the selected items from the checkboxStates map
      checkboxStates.clear();
      // Recalculate total price
      calculateTotalPrice();
      // Update selected item count
      updateSelectedItemCount();
      // Refresh the cart items
      fetchCartItem();
    } catch (e) {
      print("Error deleting selected items: $e");
    }
  }

  // this controller is used for the selected item will go to the history screen
  List<Map<String, dynamic>> getSelectedItems() {
    List<Map<String, dynamic>> selectedItems = [];
    checkboxStates.forEach((productId, isChecked) {
      if (isChecked) {
        var item = cartItems.firstWhere(
          (item) => item['CartItemID'] == productId,
        );
        selectedItems.add(item);
      }
    });
    return selectedItems;
  }

  // Clear the cart
  void clearCart() {
    cartItems.clear();
    totalPrice.value = 0.0;
  }
}

  
//   void calculateTotalPrice(){
//   double total =0.0;
//   for(var item in cartItems){
//     total=total+item["totalPrice"]??0.0;
//   }
//   totalPrice.value=total;
// }
// void incrementQunatity(String cartItemId,String curentPrice,int currentQuantity){
// updateQuantity(cartItemId, curentPrice, currentQuantity+1);

// }
// void decremmentQunatity(String cartItemId,String curentPrice,int currentQuantity){
//   if(currentQuantity>1){
// updateQuantity(cartItemId, curentPrice, currentQuantity-1);
//   }



// void updateQuantity(String cartItemId,String curentPrice,int newQuantity){

// double total=double.parse(curentPrice)*newQuantity;
// FirebaseFirestore.instance.collection('allusers').doc('Profile${FirebaseAuth.instance.currentUser?.uid}').collection('cart').doc(cartItemId).update({
//   "totalPrice":total,
//   "quantity":newQuantity
// });
// calculateTotalPrice();

// }
 

// void toggleCheckbox(String productId, bool value) {
//   checkboxStates[productId] = value;
// }

// bool isChecked(String productId) {
//   return checkboxStates[productId] ?? false;
// }

// void calculateTotalPrice() {
//   double total = 0.0;
//   checkboxStates.forEach((productId, isChecked) {
//     if (isChecked) {
//       var item = cartItems.firstWhere((item) => item['CartItemID'] == productId);
//       total += double.tryParse(item['Price'].toString()) ?? 0.0;
//     }
//   });
//   totalPrice.value = total;
// }





 




// class checkBoxController extends GetxController{
//   Rx isChecked= false.obs;
//   void togglecheckbox(bool value){
//     isChecked.value=value;
//   }
// }