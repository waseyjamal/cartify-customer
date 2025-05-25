import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/mainScreenModel.dart';

class Itemview extends StatelessWidget {
  const Itemview({super.key});

  @override
  Widget build(BuildContext context) {
    Item arguments = Get.arguments;
    return Scaffold(
      body: Text(arguments.imagePath),
    );
  }
}
