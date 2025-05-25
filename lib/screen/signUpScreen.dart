import 'package:cartify/controller/authController.dart';
// import 'package:cartify/controller/logController.dart';
import 'package:cartify/controller/signUpController.dart.dart';
import 'package:cartify/route/routeName.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final authController authcontroller = authController();
  var controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: size.width,
                    height: size.height / 3.3,
                    child: Column(
                      children: [
                        SafeArea(
                          child: Image(
                            image: AssetImage('asset/Cartifyl.png'),
                            fit: BoxFit.contain,
                            width: size.width,
                            height: size.height / 3.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Text(
                //   'Sign up',
                //   style: TextStyle(
                //       fontSize: 36,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black87),
                // ),
                Text('Create your account', style: TextStyle(fontSize: 22)),
                SizedBox(height: 30),
                Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: TextFormField(
                          controller: controller.userController.value,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 241, 237, 237),

                            // focusColor: Colors.green,
                            hintText: 'Username',

                            // labelText: 'Username',
                            border: InputBorder.none,

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 233, 231, 231),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 233, 231, 231),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: TextFormField(
                          controller: controller.emailController.value,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 241, 237, 237),

                            // focusColor: Colors.green,
                            hintText: 'Email',

                            // labelText: 'Username',
                            border: InputBorder.none,

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 233, 231, 231),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 233, 231, 231),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: TextFormField(
                          controller: controller.passController.value,
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              'asset/Password.png',
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 241, 237, 237),

                            // focusColor: Colors.green,
                            hintText: 'Password',

                            // labelText: 'Username',
                            border: InputBorder.none,

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 233, 231, 231),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 233, 231, 231),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: TextFormField(
                          controller: controller.confirmPassController.value,
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              'asset/Password.png',
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 241, 237, 237),

                            // focusColor: Colors.green,
                            hintText: 'Confirm Password',

                            // labelText: 'Username',
                            border: InputBorder.none,

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 233, 231, 231),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 233, 231, 231),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          authcontroller.signUp(
                            controller.userController.value.text.trim(),
                            controller.emailController.value.text.trim(),
                            controller.passController.value.text.trim(),
                            controller.confirmPassController.value.text.trim(),
                          );

                          // if (username.isEmpty ||
                          //     email.isEmpty ||
                          //     password.isEmpty ||
                          //     confirmPassword.isEmpty) {
                          //   Fluttertoast.showToast(
                          //     msg: 'please fill all Blanks',
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.TOP,
                          //     backgroundColor: Colors.red,
                          //     textColor: Colors.white,
                          //   );
                          // } else {
                          //   await saveSignupData(
                          //       username, email, password, confirmPassword);
                          //       Get.toNamed(Routename.loginScreen);
                          //       Fluttertoast.showToast(
                          //   msg: 'Signup Successfully',
                          //   toastLength: Toast.LENGTH_SHORT,
                          //   gravity: ToastGravity.TOP,
                          //   backgroundColor: Colors.green,
                          //   textColor: Colors.white,
                          //   fontSize: 16.0,
                          // );
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          backgroundColor: Colors.white,
                          fixedSize: Size(220, 50),
                        ),
                        child: Center(
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 55),
                              child: Divider(
                                thickness: 1.2,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'OR',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 55),
                              child: Divider(
                                thickness: 1.2,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Get.toNamed(Routename.bottomNavigationBar);
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          backgroundColor: Colors.white,
                          fixedSize: Size(360, 43),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: Image(
                                  image: AssetImage('asset/google.png'),
                                ),
                              ),
                              SizedBox(width: 5),
                              const Text(
                                "Login with Google",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 116, 7, 218),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?'),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routename.loginScreen);
                            },
                            child: Text(
                              'Login',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 116, 7, 218),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
