import 'package:flutter/material.dart';
import 'package:get/get.dart';




class SignupController extends GetxController{
  Rx<TextEditingController> userController = TextEditingController().obs;
  Rx<TextEditingController> passController = TextEditingController().obs;
  RxBool isCheck = false.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> confirmPassController = TextEditingController().obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  var isFieldNotEmpty = false.obs;

  

  void toggleCheckBox(bool value) {
    isCheck.value = value;
  }
  
  
}
// class authController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GetStorage storage = GetStorage();
//   var isLoggedIn = false.obs;

//   Future<bool> _hasInternet() async {
//     try {
//       final result = await http.get(
//           Uri.parse('https://www.google.com')); 
//       return result.statusCode == 200;
//     } catch (e) {
//       return false; 
//     }
//   }
//    void signUp(
//       String name, String email, String pass, String confirmPass) async {
//     if (await _hasInternet()) {
//       try {
//         UserCredential credentials = await _auth.createUserWithEmailAndPassword(
//             email: email, password: pass);

//         if (credentials.user != null) {
          
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(credentials.user!.uid)
//               .set({
//             "email": email,
//             "name": name,
//             "password": pass,
//             "uid": credentials.user!.uid.toString(),
//           });

//           storage.write('name', name);
//           storage.write('email', email);
//           storage.write('pass', pass);
//           storage.write('confirmpass', confirmPass);

//           Fluttertoast.showToast(
//             msg: 'SignUp Successfully',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.TOP,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//           );

//           Get.toNamed(Routename.loginScreen);
//         }
//       } catch (e) {
//         Get.snackbar('error', e.toString());
//       }
//     } else {
//       Get.snackbar('Error', "No internet. Try again later");
//     }
//   }

// }

