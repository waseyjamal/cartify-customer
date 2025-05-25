import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/shippingAddress.dart';

class shippingAddressController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  //in this Validate the form and return the shipping address
  ShippingAddress? validateAndGetAddress() {
    if (formKey.currentState!.validate()) {
      return ShippingAddress(
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        zip: zipController.text,
      );
    }
    return null;
  }

  
  void clearForm() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();
  }
}