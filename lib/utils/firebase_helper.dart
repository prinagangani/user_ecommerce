import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseHelper {
  static FireBaseHelper fireBaseHelper = FireBaseHelper._();

  FireBaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  signIn({required email, required password}) async {
    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return "success";
    }).catchError((e) {
      return "$e";
    });
  }

  signUp({required email, required password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print("success"))
        .catchError((e) => print("fail : $e"));
  }

  bool checkUser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  String getUid()
  {
    User? user  = firebaseAuth.currentUser;
    var uid = user!.uid;
    return uid;
  }

  Future<String?> googleSignin() async {
    String? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? auth = await user!.authentication;
    var crd = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    await firebaseAuth
        .signInWithCredential(crd)
        .then((value) => msg = "success")
        .catchError((e) => msg = "failed : $e");
    return msg;
  }

  Future<void> insert(
      {required name,
        required price,
        required quantity,
        required description,
        required rate,required image}) async {
    String uid = getUid();
    await firestore.collection("userData").doc("$uid").collection("cart").add({
      "name": name,
      "price": price,
      "quantity": quantity,
      "description": description,
      "rate": rate,
      "image":image,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> read()
  {
    return firestore.collection("product").snapshots();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> readUser()
  {
    return firestore.collection("userData").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readData()
  {
    String uid = getUid();
    return firestore.collection("userData").doc("$uid").collection("cart").snapshots();
  }

  Future<void> delete(String docId)
  async {
    String uid = getUid();
    // var uid = getUid();
    print(docId);
    await firestore.collection("userData").doc("$uid").collection("cart").doc(docId).delete();
  }


  bool? logout()
  {
    bool? check;
    FirebaseAuth.instance.signOut().then((value) => check=true).catchError((e)=>check=false);
    GoogleSignIn().signOut().then((value) => check=true);
    return check;
  }

}