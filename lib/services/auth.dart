
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth{

  final _auth = FirebaseAuth.instance;

  //signup method
  Future<AuthResult> signUp(String email,String password)async{
    // رح ترجعلي قيمة بالمستقبل من نوع AuthResult
   final  authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return authResult;
  }
  //signin method
  Future<AuthResult> signIn(String email,String password)async{
    // رح ترجعلي قيمة بالمستقبل من نوع AuthResult
    final  authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }
}