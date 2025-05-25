import 'dart:async';
import 'package:cartify/route/routeName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    bool internetAvailable = await _hasInternet();
    bool isLoggedIn = storage.read('isLoggedIn') ?? false;

    Timer(Duration(seconds: 3), () {
      if (isLoggedIn) {
         Get.toNamed(Routename.bottomNavigationBar);
      } else {
         Get.toNamed(Routename.firstScreen);
      }

      if (!internetAvailable) {
        Get.snackbar('No Internet', 'Offline mode enabled');
      }
    });
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width, 
        height: size.height, 
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/splash.png'), 
            fit: BoxFit.cover, 
          ),
        ),
      ),
    );
  }
}
