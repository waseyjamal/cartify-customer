import 'package:cartify/route/routeName.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class authController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage storage = GetStorage();
  var isLoggedIn = false.obs;

  Future<bool> _hasInternet() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void signUp(
    String name,
    String email,
    String pass,
    String confirmPass,
  ) async {
    if (pass != confirmPass) {
      Get.snackbar('Error', 'Password and Confirm Password do not match');
      return; 
    }
    
    if (await _hasInternet()) {
      try {
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );

        if (credentials.user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(credentials.user!.uid)
              .set({
                "email": email,
                "name": name,
                "password": pass,
                "uid": credentials.user!.uid.toString(),
                'timestamp': FieldValue.serverTimestamp(),
              });

          storage.write('name', name);
          storage.write('email', email);
          storage.write('pass', pass);
          storage.write('confirmpass', confirmPass);

          Fluttertoast.showToast(
            msg: 'SignUp Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );

          Get.toNamed(Routename.loginScreen);
        }
      } catch (e) {
        Get.snackbar('error', e.toString());
      }
    } else {
      Get.snackbar('Error', "No internet. Try again later");
    }
  }

  void login(String emailController, String passController) async {
    if (await _hasInternet()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController,
          password: passController,
        );
        storage.write('isLoggedIn', true);
        Get.snackbar('Success', 'Login Successful!');
        Get.toNamed(Routename.bottomNavigationBar);
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
      // ye offline handle krne keliya
    } else {
      String? storedEmail = storage.read('email');
      String? storedPassword = storage.read('pass');

      if (emailController == storedEmail && passController == storedPassword) {
        storage.write('isLoggedIn', true);
        Get.snackbar('Success', 'Offline Login Successful!');
        Get.toNamed(Routename.bottomNavigationBar);
      } else {
        Get.snackbar('Error', 'Invalid Email or Password');
      }
    }
  }

  void logout() {
    isLoggedIn.value = false;
    storage.remove('isLoggedIn');
    Get.toNamed(Routename.loginScreen);
  }
}
