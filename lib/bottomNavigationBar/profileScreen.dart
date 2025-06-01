import 'package:cartify/controller/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/setProfileImageController.dart';
import '../screen/profileEditor.dart';

class profileScreen extends StatelessWidget {
  profileScreen({super.key});
  final authController AuthController = Get.find();
  final SetProfileImagecontroller setProfileImageController =
      Get.find<SetProfileImagecontroller>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // setProfileImageController.fetchImageUrl();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      setProfileImageController.fetchImageUrl(userId);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  //child: Icon(Icons.arrow_back),
                ),
              ),
              Positioned(
                top: size.height / 15,
                left: size.width / 2.87,
                child: Obx(() {
                  final imageUrl = setProfileImageController.imageUrl.value;
                  final isUploading =
                      setProfileImageController.isUploading.value;

                  return Stack(
                    children: [
                      Container(
                        height: size.height / 6,
                        width: size.width / 3.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                setProfileImageController.imageUrl.value.isEmpty
                                    ? AssetImage('asset/p.jpg') // Default image
                                    : NetworkImage(imageUrl) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (isUploading)
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.amber,
                          ),
                          strokeWidth: 3,
                        ),
                    ],
                  );
                }),
              ),
              Positioned(
                top: size.height / 5.7,
                left: size.width / 2.05,
                child: ElevatedButton(
                  onPressed: () {
                    Get.bottomSheet(
                      profileOptionSheet(),
                      // isDismissible: false,
                      // enableDrag: false,
                    );
                  },
                  style: ElevatedButton.styleFrom(shape: CircleBorder()),
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
              Positioned(
                top: size.height / 4.1,
                width: size.width,
                child: Center(
                  child: Text(
                    "Wasey Jamal",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height / 3.6,
                width: size.width,
                child: Center(
                  child: Text(
                    'waseyjamal00@gmail.com',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: size.height / 3.08,
                width: size.width / 1,
                child: Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          elevation: 6,
                        ),
                        child: const Text(
                          'Upgrade to PRO',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height / 2.3,
                width: size.width,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print('check Privacy');
                      },
                      child: Container(
                        width: size.width / 1.35,
                        height: size.height / 18,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 240, 240),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.privacy_tip_sharp,
                                    // color: Colors.black54,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Privacy',
                                  style: TextStyle(
                                    fontSize: 18,
                                    // color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11),
                              child: Icon(
                                Icons.chevron_right,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: size.width / 1.35,
                        height: size.height / 18,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 240, 240),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.history,
                                    // color: Colors.black54,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Purchase History',
                                  style: TextStyle(
                                    fontSize: 18,
                                    // color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11),
                              child: Icon(
                                Icons.chevron_right,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: size.width / 1.35,
                        height: size.height / 18,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 240, 240),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.help,
                                    // color: Colors.black54,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Help & Support',
                                  style: TextStyle(
                                    fontSize: 18,
                                    // color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11),
                              child: Icon(
                                Icons.chevron_right,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: size.width / 1.35,
                        height: size.height / 18,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 240, 240),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.settings,
                                    // color: Colors.black54,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                    fontSize: 18,
                                    // color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11),
                              child: Icon(
                                Icons.chevron_right,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {},
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: size.width / 1.35,
                          height: size.height / 18,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 240, 240),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Icon(
                                      Icons.person_add,
                                      // color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Invite Friends',
                                    style: TextStyle(
                                      fontSize: 18,
                                      // color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 11),
                                child: Icon(
                                  Icons.chevron_right,
                                  size: 34,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: size.width / 1.35,
                        height: size.height / 18,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 240, 240),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.logout,
                                    // color: Colors.black54,
                                  ),
                                ),
                                SizedBox(width: 4),
                                InkWell(
                                  onTap: () {
                                    AuthController.logout();
                                    setProfileImageController.clearImageUrl();
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 18,
                                      // color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11),
                              child: Icon(
                                Icons.chevron_right,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
