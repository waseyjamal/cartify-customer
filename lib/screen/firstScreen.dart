import 'package:cartify/route/routeName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class firstScreen extends StatefulWidget {
  const firstScreen({super.key});

  @override
  State<firstScreen> createState() => _firstScreenState();
}

class _firstScreenState extends State<firstScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height/12,
              ),
              SizedBox(
                // color: Colors.amber,
                width: size.width,
                height: size.height / 3,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('asset/Cartifyl.png'),
                      fit: BoxFit.contain,
                      width: size.width,
                      height: size.height / 3,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height/15),
              Text(
                'Welcome !',
                style: TextStyle(
                  // fontWeight: FontWeight.bold,/
                  fontSize: 28,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routename.signUpScreen);
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF930F00)),
                  backgroundColor: const Color(0xFFDF1600),
                  fixedSize: Size(360, 50),
                ),
                child: Center(
                  child: const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 17),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routename.loginScreen);
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFDF1600)),
                  backgroundColor: Colors.white,
                  fixedSize: Size(360, 50),
                ),
                child: Center(
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFDF1600),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 16.9,
                      backgroundImage: AssetImage('asset/t.png'),
                      backgroundColor: Colors.white,
                      // child: Icon(Icons.facebook),
                    ),
                    SizedBox(width: 11),
                    CircleAvatar(
                      radius: 17.4,
                      backgroundImage: AssetImage('asset/link.png'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: 11),
                    CircleAvatar(
                      radius: 17.4,
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
          ),
        ),
      ),
    );
  }
}
