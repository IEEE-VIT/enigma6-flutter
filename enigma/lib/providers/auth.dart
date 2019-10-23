import 'package:enigma/providers/registerPlayer.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


const registerUrl = 'https://enigma6-backend.herokuapp.com/api/registerPlayer/';
class Auth with ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String _uIdToken;
  String _userEmail;
  bool _signedInWithGoogle;

  bool get isAuth{
    return uIdToken!=null;
  }

  String get uIdToken{
    return _uIdToken;
  }

  String get userEmail{
    return _userEmail;
  }


  Future<FirebaseUser> emailPasswordLogin(String email, String password) async{
    try{
      AuthResult user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _uIdToken = user.user.uid;
        _userEmail = user.user.email;
        _signedInWithGoogle = false;
        print(_signedInWithGoogle);
        
        notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('uId', _uIdToken);
      return user.user;
      
  
    }
    catch(error){
      print(error);
      return null;
    }
  }

  Future<void> emailPasswordSignup(String email, String password) async{
    try{
      AuthResult user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await user.user.sendEmailVerification();
      notifyListeners();
    }
    catch(error){
      throw(error);
    }
  }

  Future<void> currentUser() async{
    FirebaseUser user = await _auth.currentUser();
    notifyListeners();
    return user;
  }

  Future<void> signOut() async{
    !_signedInWithGoogle ? 
    await _auth.signOut() : 
    await googleSignIn.signOut();
    notifyListeners();
  }

  Future<FirebaseUser> signInWithGoogle() async{
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

  _uIdToken = user.user.uid;
  _userEmail = user.user.email;
  _signedInWithGoogle = true;
  print(_signedInWithGoogle);
  notifyListeners();
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('uId', _uIdToken);
  return user.user;
  }

  Future<void> signOutGoogle() async{
    await googleSignIn.signOut();
  }

  Future<bool> autoLogin() async{
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('uId')) {
      return false;
    }
    final token = prefs.getString('uId');
    _uIdToken = token;
    notifyListeners();
    return true;
  }

  Future<RegisterPlayer>registerUser(String uid, String name, String email) async{
    try{
      print(uid);
      print(name);
      print(email);
      final response = await http.post(
      registerUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $uid"
      },
      body: json.encode({
        'name': name,
        'email': email
      })
    );
    print(response.body);
    final extractedResponse = registerPlayerFromJson(response.body);
    return extractedResponse;
    }
    catch(error){
      throw(error);
    }
  }
}

