import 'package:cartify/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:cartify/bottomNavigationBar/cartScreen.dart';
import 'package:cartify/bottomNavigationBar/historyScreen.dart';
import 'package:cartify/bottomNavigationBar/mainScreen.dart';
import 'package:cartify/bottomNavigationBar/profileScreen.dart';
import 'package:cartify/orders/orderConfirmationScreen.dart';
import 'package:cartify/controller/authController.dart';
import 'package:cartify/controller/setProfileImageController.dart';
import 'package:cartify/firebase_options.dart';
import 'package:cartify/screen/firstScreen.dart';
import 'package:cartify/screen/loginScreen.dart';
import 'package:cartify/route/routeName.dart';
import 'package:cartify/screen/signUpScreen.dart';
import 'package:cartify/screen/splashScreen.dart';
import 'package:cartify/views/itemView.dart';
import 'package:cartify/views/productDetail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cartify/screen/dropDown.dart';

import 'controller/historyController.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );

   await GetStorage.init();
   Get.put(SetProfileImagecontroller());
   

   
   Get.put(authController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: Routename.splashScreen,
      initialBinding: BindingsBuilder(() {
        Get.put(historyController()); 
      }),
      
      getPages: [
        
        GetPage(name: Routename.splashScreen, page: () => splashScreen()),
        GetPage(name: Routename.firstScreen, page: () => firstScreen()),
        GetPage(name: Routename.loginScreen, page: () => loginScreen()),
        GetPage(name: Routename.signUpScreen, page: () => signUpScreen()),
        GetPage(
            name: Routename.bottomNavigationBar,
            page: () => const bottomNavigationBar()),
        GetPage(name: Routename.mainScreen, page: () => mainScreen()),
        GetPage(name: Routename.profileScreen, page: () => profileScreen()),
        GetPage(name: Routename.historyScreen, page: ()=>historyScreen()),
        GetPage(name: Routename.cartScreen, page: ()=>cartScreen()),
        GetPage(name: Routename.itemViewScreen, page: ()=>Itemview()),
        GetPage(name: Routename.viewProduct, page: ()=>viewProduct()),
        GetPage(name: Routename.dropDown, page: ()=>dropDown()),
        GetPage(name: Routename.orderConfirmationScreen, page: ()=>orderConfirmationScreen()),
        
      ],
    );
  }
}
