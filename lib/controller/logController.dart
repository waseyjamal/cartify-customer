import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LogController extends GetxController {

  Rx<TextEditingController> passController = TextEditingController().obs;
  RxBool isCheck = false.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;


  

  void toggleCheckBox(bool value) {
    isCheck.value = value;
  }

}


 



