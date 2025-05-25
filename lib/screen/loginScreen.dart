import 'package:cartify/controller/authController.dart';
import 'package:cartify/controller/logController.dart';

import 'package:cartify/route/routeName.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final authController AuthController = Get.find();
  var controller = Get.put(LogController());
  bool _isPasswordVisible = false;

  @override
  //  void initState() {
  //   super.initState();
  //   isLoggedIn.value = storage.read('isLoggedIn') ?? false;
  //   if (isLoggedIn.value) {
  //     Get.to(() => bottomNavigationBar());
  //   }else{
  //     Get.offAll(() => loginScreen());
  //   }
  // }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height / 2.838,
                    child: Column(
                      children: [
                        SafeArea(
                          child: Image(
                            image: AssetImage('asset/Cartify.png'),
                            fit: BoxFit.contain,
                            width: size.width,
                            height: size.height / 3.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(width: 7),
                  Text('back !', style: TextStyle(fontSize: 24)),
                ],
              ),
              SizedBox(height: 40),
              Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28, right: 28),
                      child: TextFormField(
                        controller: controller.emailController.value,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('asset/Email.png',color: Colors.black,),
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
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('asset/Password.png',color: Colors.black,),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: size.height * 0.00,
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible =
                                    !_isPasswordVisible; 
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Checkbox(
                                side: BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                value: controller.isCheck.value,
                                onChanged: (value) {
                                  controller.toggleCheckBox(value!);
                                },
                              ),
                            ),
                            Text('Remember me'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(children: [Text('Forget password?')]),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        AuthController.login(
                          controller.emailController.value.text.trim(),
                          controller.passController.value.text.trim(),
                        );
                        // (Fluttertoast.showToast(
                        //   msg: "Incorrect",
                        //   toastLength: Toast.LENGTH_SHORT,
                        //   gravity: ToastGravity.TOP,
                        //   backgroundColor:
                        //       const Color.fromARGB(255, 224, 34, 34),
                        //   fontSize: 18,
                        //   textColor: Colors.white,
                        // ));
                        // String enterEmail =
                        //     controller.emailController.value.text.trim();
                        // String enterPassword =
                        //     controller.passController.value.text.trim();

                        // if (enterEmail.isEmpty ||
                        //     enterPassword.isEmpty) {
                        //   Fluttertoast.showToast(
                        //     msg: 'Please fill in all fields',
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.BOTTOM,
                        //     backgroundColor: Colors.red,
                        //     textColor: Colors.white,
                        //   );
                        // } else {
                        //   validateLogin(enterEmail, enterPassword);
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        backgroundColor: Colors.white,
                        fixedSize: Size(360, 50),
                      ),
                      child: Center(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 43, 43, 43),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New user?', style: TextStyle(fontSize: 18)),
                        SizedBox(width: 6),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routename.signUpScreen);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 116, 7, 218),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 55),
                            child: Divider(thickness: 1.2, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'OR',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 116, 7, 218),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 55),
                            child: Divider(thickness: 1.2, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),

                    //
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage('asset/t.png'),
                            backgroundColor: Colors.white,
                            // child: Icon(Icons.facebook),
                          ),
                          SizedBox(width: 11),
                          CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage('asset/link.png'),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 11),
                          CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage('asset/face.png'),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 11),
                          CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage('asset/google.png'),
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Sign in with another account',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
