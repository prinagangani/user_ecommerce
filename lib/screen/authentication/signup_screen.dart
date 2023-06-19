import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_ecommerce/utils/firebase_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  @override
  Widget build(BuildContext context) {  Container(height:double.infinity,width:double.infinity,child: Image.network("https://cdn.wallpapersafari.com/66/48/JwW4mI.jpg",fit: BoxFit.cover,));
    Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
    color: Colors.grey.shade500.withOpacity(0.85)
    ),
    );
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(height:double.infinity,width:double.infinity,child: Image.network("https://cdn.wallpapersafari.com/66/48/JwW4mI.jpg",fit: BoxFit.cover,)),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade500.withOpacity(0.85)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(controller: txtemail,
                      decoration: InputDecoration(hintText: "Enter your email",labelText: "Email",enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder()),),
                    SizedBox(height: 10,),
                    TextField(
                      controller: txtpass,
                      decoration: InputDecoration(hintText: "Enter your Password",labelText: "Password",enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder()),),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),onPressed: () {
                      FireBaseHelper.fireBaseHelper.signUp(email: txtemail.text, password: txtpass.text);
                      Get.toNamed('/signin');
                    }, child: Text("Sign up"))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}