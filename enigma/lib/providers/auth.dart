import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<AuthResult> emailPasswordLogin(String email, String password) async{
    try{
      AuthResult user = await _auth.signInWithEmailAndPassword(email: email, password: password);
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
      AuthResult user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await user.user.sendEmailVerification();
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

  Future<void> signOut() async{
    await _auth.signOut();
  }

  Future<AuthResult> signInWithGoogle() async{
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult user = await _auth.signInWithCredential(credential);

  assert(!user.user.isAnonymous);
  assert(await user.user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.user.uid == currentUser.uid);

  return user;
  }

  Future<void> signOutGoogle() async{
    await googleSignIn.signOut();
  }
}

