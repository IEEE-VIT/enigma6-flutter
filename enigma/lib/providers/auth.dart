import 'package:enigma/providers/registerPlayer.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const registerUrl = 'https://enigma6-backend.herokuapp.com/api/registerPlayer/';

// All authentication methods reside inside this class.
class Auth with ChangeNotifier {
	final FirebaseAuth _auth = FirebaseAuth.instance;
	final GoogleSignIn googleSignIn = GoogleSignIn();
	String _uIdToken;
	String _userEmail;
	bool _signedInWithGoogle;

	bool get isAuth {
		return uIdToken != null;
	}

	String get uIdToken {
		return _uIdToken;
	}

	String get userEmail {
		return _userEmail;
	}

	// Logging in with an email and a password.
	Future<FirebaseUser> emailPasswordLogin(String email, String password) async {
		try {
			AuthResult user = await _auth.signInWithEmailAndPassword(
					email: email, password: password);
			_uIdToken = user.user.uid;
			_userEmail = user.user.email;
			_signedInWithGoogle = false;
			print(_signedInWithGoogle);

			notifyListeners();

			final prefs = await SharedPreferences.getInstance();
			prefs.setString('uId', _uIdToken);
			prefs.setBool('googleSignIn', false);
			return user.user;
		} catch (error) {
			throw(error);
		}
	}

	// Signing up for a new account.
	Future<void> emailPasswordSignup(String email, String password) async {
		try {
			AuthResult user = await _auth.createUserWithEmailAndPassword(
					email: email, password: password);
			await user.user.sendEmailVerification();
			notifyListeners();
		} catch (error) {
			throw (error);
		}
	}

	// Method to get the current logged in user.
	Future<void> currentUser() async {
		FirebaseUser user = await _auth.currentUser();
		notifyListeners();
		return user;
	}

	// Signing out a user (both email and google).
	Future<void> signOut() async {
		print(_signedInWithGoogle);
		final prefs = await SharedPreferences.getInstance();
		prefs.remove('googleSignIn');
		prefs.remove('uId');
		!_signedInWithGoogle ? await _auth.signOut() : await googleSignIn.signOut();
		//await _auth.signOut();
		notifyListeners();
	}

	// Signing in a user with his/her Google account.
	Future<FirebaseUser> signInWithGoogle() async {
		try{
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
			prefs.setBool('googleSignIn', true);
			return user.user;
		}

		catch(error){
			throw error;
		}
	}

	// method to automatically sign in users even if the app was removed from memory.
	Future<bool> autoLogin() async {
		final prefs = await SharedPreferences.getInstance();
		if (!prefs.containsKey('uId')) {
			return false;
		}
		final token = prefs.getString('uId');
		print('automatically logged in');
		_signedInWithGoogle = prefs.getBool('googleSignIn');
		print(_signedInWithGoogle);
		_uIdToken = token;
		notifyListeners();
		return true;
	}

	// method to register a user in the rtd after they have logged in.
	Future<RegisterPlayer> registerUser(
			String uid, String name, String email) async {
		try {
			print(uid);
			print(name);
			print(email);
			final response = await http.post(registerUrl,
					headers: {
						'Content-Type': 'application/json',
						'Authorization': "Bearer $uid"
					},
					body: json.encode({'name': name, 'email': email}));
			print(response.body);
			final extractedResponse = registerPlayerFromJson(response.body);
			return extractedResponse;
		} catch (error) {
			throw (error);
		}
	}
}
