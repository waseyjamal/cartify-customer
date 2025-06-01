import 'package:cartify/controller/getDataController.dart';
import 'package:cartify/controller/signUpController.dart.dart';
import 'package:cartify/views/custom_GridView.dart';
import 'package:cartify/views/imageSliderScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  var controller = Get.put(SignupController());
  Getcontroller getcontroller = Get.put(Getcontroller());

  @override
  void initState() {
    getcontroller.getAllProducts();
    getcontroller.getFilterProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "asset/logo1.png",
                          color: const Color.fromARGB(255, 116, 7, 218),
                          fit: BoxFit.cover,
                          height: size.height / 22,
                          width: size.height / 39,
                        ),
                        const SizedBox(width: 2),
                        const Text('artify', style: TextStyle(fontSize: 28)),
                      ],
                    ),
                    const SizedBox(height: 13),
        
                    Obx(
                      () => TextFormField(
                        controller: controller.searchController.value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, size: 34),
                          hintText: 'Search products',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 10,
                          ),
                        ),
                        onChanged: (userData) {
                          getcontroller.searchQuery.value = userData;
                          getcontroller.getFilterProducts();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    children: [
                      const SizedBox(height: 23),
        
                      CarouselSliderView(),
                      const SizedBox(height: 15),
        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'New Arrivals',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
        
                      CustomGridView(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
