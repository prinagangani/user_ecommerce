
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:user_ecommerce/screen/home/view/buy_screen.dart';
import 'package:user_ecommerce/screen/home/view/cart_screen.dart';
import 'package:user_ecommerce/screen/home/view/home_screen.dart';
import 'package:user_ecommerce/screen/home/view/profile_screen.dart';
import 'package:user_ecommerce/screen/home/view/second_screen.dart';

import 'screen/authentication/signin_screen.dart';
import 'screen/authentication/signup_screen.dart';
import 'screen/authentication/splash_screen.dart';
Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(builder: (context, orientation, deviceType) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signin',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/cart', page: () => CartScreen()),
        GetPage(name: '/second', page: () => SecondScreen()),
        GetPage(name: '/buy', page: () => BuyScreen()),
      ],
    ),),
  );
}