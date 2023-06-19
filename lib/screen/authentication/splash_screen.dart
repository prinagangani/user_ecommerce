import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_ecommerce/utils/firebase_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    isLogin = FireBaseHelper.fireBaseHelper.checkUser();
  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),() => Get.offAndToNamed(isLogin==false?'/signin':'/home'));
    return SafeArea(child: Scaffold(
      body: Center(
        child: FlutterLogo(size: 80,),
      ),
    ));
  }

}