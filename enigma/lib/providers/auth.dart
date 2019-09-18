import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth with ChangeNotifier{

  Future<AuthResult> emailPasswordLogin(String email, String password) async{
    try{
      AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      try{
        if (user.user.isEmailVerified){
          return user;
        }
        else{
          return null;
        }
      }
      catch(error){
        throw(error);
      }
      
    }
    catch(error){
      throw(error);
    }
  }

  Future<AuthResult> emailPasswordSignup(String email, String password) async{
    try{
      AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await user.user.sendEmailVerification();
    }
    catch(error){
      throw(error);
    }
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }
}