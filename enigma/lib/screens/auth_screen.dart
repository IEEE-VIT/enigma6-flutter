import 'package:enigma/screens/profile_setup.dart';
import 'package:enigma/screens/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:enigma/size_config.dart';
import 'package:enigma/providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

AuthMode _authMode = AuthMode.Login;

class AuthScreen extends StatefulWidget {
	static const routeName = '/auth';

	@override
	_AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

	final GlobalKey<FormState> _formKey = GlobalKey();
	final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
	bool password1Visible = false;
	bool password2Visible = false;
	//Map to store entered data
	Map<String, String> _authData = {
		'email': '',
		'password': '',
	};
	var _isLoading = false;
	final _passwordController = TextEditingController();

	void _showErrorDialog(String error){
		showDialog(
			context: context,
			builder: (ctx) => AlertDialog(
				title: Text('Error!'),
				content: Text('$error'), 
				actions: <Widget>[
					FlatButton(
						child: Text('Ok'),
						onPressed:() {Navigator.of(ctx).pop();},
					)
				],
			)
		);
	}

	void _switchAuthMode() {
		if (_authMode == AuthMode.Login) {
			setState(() {
				_authMode = AuthMode.Signup;
			});
		} else {
			setState(() {
				_authMode = AuthMode.Login;
			});
		}
	}


	void _submit() async{
		if (!_formKey.currentState.validate()) {
			// Invalid!
			return;
		}
		_formKey.currentState.save();
		setState(() {
			_isLoading = true;
		});
		try{
			if (_authMode == AuthMode.Login) {
				// Log user in  
		    await Provider.of<Auth>(context).emailPasswordLogin(_authData['email'], _authData['password']).then((response) async {
          if(!response.isEmailVerified){
          	_showErrorDialog('It seems like you haven\'t verified your mail. Please do so before proceeding.');
          	return;
          }
          await Provider.of<Auth>(context).registerUser(response.uid, '', response.email).then((val){
            if(val.wasUserRegistered==true){
              Navigator.of(context).pushNamed(QuestionScreen.routeName);
            }
            else if (val.wasUserRegistered==false){
              Navigator.of(context).pushNamed(ProfileSetupScreen.routeName);
            }
          });
        });				
			
			} else {
				// Sign user up
        await Provider.of<Auth>(context).emailPasswordSignup(_authData['email'], _authData['password']).then((onValue){
			  _switchAuthMode();
				_scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('A link has been sent to your mail! Please click on it to verify your account.')));
        }).catchError((onError){
          print(onError.toString());
          if(onError.toString().contains('ERROR_WEAK_PASSWORD')){
            _showErrorDialog('Please chose a stronger password.');
          }
          else if(onError.toString().contains('ERROR_EMAIL_ALREADY_IN_USE')){
            _showErrorDialog('This email is already in use.');
          }
          else{
            _showErrorDialog('There was a problem singning you up');
          }
        });
			}
		}
		catch(error){
			print('lol');
			print(error.toString());
			if (error.toString().contains('ERROR_WRONG_PASSWORD')){
				_showErrorDialog('It seems you have entered a wrong password.');
			}
			else if(error.toString().contains('ERROR_USER_DOES_NOT_EXIST')){
				_showErrorDialog('Please sign up with this email before loggin in.');
			}
			else{
				String errorMessage = 'Could not authenticate you!';
				print(error);
				_showErrorDialog(errorMessage);
			}
		}
		setState(() {
			_isLoading = false;
		});
	}

	@override
	void initState() {
		password1Visible = false;
		password2Visible = false;
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		SizeConfig().init(context);
		return Scaffold(
			key: _scaffoldKey,
			body: Stack(
				children: <Widget>[
					Container(
						decoration: BoxDecoration(
							color: Colors.black
						),
					),
					SingleChildScrollView(
						child: Container(
							height: SizeConfig.screenHeight,
							width: SizeConfig.screenWidth,
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.center,
								children: <Widget>[
									//CustomApppBar with image and title
									Flexible(
										child: _authMode == AuthMode.Login ?
										Container(
											padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth/8, SizeConfig.screenHeight/10, 0, 0),
											width: SizeConfig.screenWidth,
											height: SizeConfig.screenHeight/4,
											decoration: BoxDecoration(
												image: DecorationImage(
													image: ExactAssetImage('assets/images/hoodie.png'),
													fit: BoxFit.cover
												)
											),
											child: Text('Login', style: TextStyle(
												color: Colors.black,
												fontFamily: 'Chosence',
												fontSize: SizeConfig.safeBlockHorizontal*12,
												fontStyle: FontStyle.normal,
												//fontWeight: FontWeight.bold
											),),
										)
										:
										Container(
											padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth/8, SizeConfig.screenHeight/10, 0, 0),
											width: SizeConfig.screenWidth,
											height: SizeConfig.screenHeight/4,
											decoration: BoxDecoration(
												image: DecorationImage(
													image: ExactAssetImage('assets/images/hoodie_2.png'),
													fit: BoxFit.cover
												)
											),
											child: Text('Signup', style: TextStyle(
												color: Colors.black,
												fontFamily: 'Chosence',
												fontSize: SizeConfig.safeBlockHorizontal*12,
												fontStyle: FontStyle.normal,
												//fontWeight: FontWeight.bold
											),),
										)
									),
									Flexible(
										flex: 3,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.center,
											children: <Widget>[
												Padding(padding: EdgeInsets.only(top:SizeConfig.blockSizeVertical*6),),
												SizedBox(
													height: _authMode == AuthMode.Signup ? SizeConfig.blockSizeVertical
													: SizeConfig.blockSizeVertical*7,
													width: SizeConfig.blockSizeHorizontal*75,
													// Google Login Button
													child: _authMode == AuthMode.Signup ? SizedBox(height: 0,)
													: FlatButton(
														onPressed: () async{
															try{
                                await Provider.of<Auth>(context).signInWithGoogle().then((response) async {
                                  await Provider.of<Auth>(context).registerUser(response.uid, '', response.email).then((val){
                                    if(val.wasUserRegistered==true){
                                      Navigator.of(context).pushNamed(QuestionScreen.routeName);
                                    }
                                    else if (val.wasUserRegistered==false){
                                      Navigator.of(context).pushNamed(ProfileSetupScreen.routeName);
                                    }
                                  });
                                });																
															}
															catch(e)
															{
																print(e);
															}
														},
														color: Color.fromRGBO(33, 33, 33, 1),
														textColor: Colors.white,
														shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(6),
																			),
														child: Text('Continue using Google', style: TextStyle(
															fontFamily: 'Saira',
															fontSize: SizeConfig.safeBlockHorizontal*5,
															fontStyle: FontStyle.normal,
														),),
													),
												),
												Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2)),
												_authMode == AuthMode.Signup ? Text('')
												: Text('OR', style: TextStyle(
													color: Colors.white,
													fontFamily: 'Saira',
													fontStyle: FontStyle.normal,
													fontSize: SizeConfig.safeBlockHorizontal*4
												)),
												Form(
													key: _formKey,
													child: SingleChildScrollView(
														child: Container(
															width: SizeConfig.blockSizeHorizontal*65,
															child: Column(
																children: <Widget>[
																	Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2)),
																	TextFormField(
																		style: TextStyle(color: Colors.white),
																		decoration: InputDecoration(
																			labelText: 'Email',
																			labelStyle: TextStyle(
																				color: Colors.white, 
																				fontSize: SizeConfig.blockSizeHorizontal*4,
																				fontStyle: FontStyle.normal,
																				fontFamily: 'Saira'
																				),
																			contentPadding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal*3, 0, 0, SizeConfig.blockSizeVertical*2),
																			enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)) 
																			),
																		keyboardType: TextInputType.emailAddress,
// ignore: missing_return
																		validator: (value) {
																			if (value.isEmpty || !value.contains('@')) {
																				return 'Invalid email!';
																			}
																		},
																		onSaved: (value) {
																			_authData['email'] = value;
																		},
																	),
																	Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2)),
																	TextFormField(
																		style: TextStyle(color: Colors.white),
																		decoration: InputDecoration(
																			labelText: 'Password',
																			labelStyle: TextStyle(
																				color: Colors.white, 
																				fontSize: SizeConfig.blockSizeHorizontal*4,
																				fontStyle: FontStyle.normal,
																				fontFamily: 'Saira'
																				),
																			contentPadding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal*3, 0, 0, SizeConfig.blockSizeVertical*2),
																			enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
																			suffixIcon: IconButton(
																				icon: Icon(
																					// Based on passwordVisible state choose the icon
																					password1Visible
																					? Icons.visibility
																					: Icons.visibility_off,
																					color: Colors.white,
																					),
																				onPressed: () {
																					// Update the state i.e. toogle the state of passwordVisible variable
																					setState(() {
																							password1Visible = !password1Visible;
																					});
																				},
																				),
																			),
																		obscureText: !password1Visible,
																		controller: _passwordController,
// ignore: missing_return
																		validator: (value) {
																			if (value.isEmpty || value.length < 5) {
																				return 'Password is too short!';
																			}
																		},
																		onSaved: (value) {
																			_authData['password'] = value;
																		},
																	),
																	Padding(
																		padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
																		child: _authMode == AuthMode.Signup?
																			TextFormField(
																			style: TextStyle(color: Colors.white),
																			decoration: InputDecoration(
																				labelText: 'Confirm Password',
																				labelStyle: TextStyle(
																					color: Colors.white, 
																					fontSize: SizeConfig.blockSizeHorizontal*4,
																					fontStyle: FontStyle.normal,
																					fontFamily: 'Saira'
																					),
																				contentPadding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal*3, 0, 0, SizeConfig.blockSizeVertical*2),
																				enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
																				suffixIcon: IconButton(
																					icon: Icon(
																						// Based on passwordVisible state choose the icon
																						password2Visible
																						? Icons.visibility
																						: Icons.visibility_off,
																						color: Colors.white,
																						),
																					onPressed: () {
																						// Update the state i.e. toogle the state of passwordVisible variable
																						setState(() {
																								password2Visible = !password2Visible;
																						});
																					},
																					),
																				),
																				enabled: _authMode == AuthMode.Signup,
																				obscureText: !password2Visible,
																				validator: _authMode == AuthMode.Signup
// ignore: missing_return
																						? (value) {
																								if (value != _passwordController.text) {
																									return 'Passwords do not match!';
																								}
																							}
																						:
																						null
																			)
																			:
																			GestureDetector(
																				onTap: (){},
																				child: Container(
																				padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical*3, SizeConfig.blockSizeHorizontal*35,0 ),
																					child:Text('Forgot Password?', style: TextStyle(
																						color: Colors.white,
																					),
																					),
																				),
																			),
																	),
																	SizedBox(
																		height: SizeConfig.blockSizeVertical*4,
																	),
																	if (_isLoading)
																		CircularProgressIndicator()
																	else
																		RaisedButton(
																			child:
																					Text(
																						_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
																						style: TextStyle(
																							fontFamily: 'Saira',
																							fontSize: SizeConfig.blockSizeHorizontal*4
																						),
																						),
																			onPressed: (){
																				_submit();
																				},
																			shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(5),
																			),
																			padding:
																					EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
																			color: _authMode == AuthMode.Signup ? Colors.yellow[600] : Color.fromRGBO(206, 246, 249, 1),
																			textColor: Colors.black,
																		),
																	_authMode == AuthMode.Login 
																	? SizedBox(height: SizeConfig.blockSizeVertical*9.5,)
																	:SizedBox(height: SizeConfig.blockSizeVertical*8),
																	Row(
																		mainAxisAlignment: MainAxisAlignment.center,
																		children: <Widget>[
																			Text('Don\'t have an account ? ', style: TextStyle(
																				color: Colors.white,
																				fontSize: SizeConfig.blockSizeHorizontal*4,
																				fontFamily: 'Saira'
																			),),
																			GestureDetector(
																				onTap: (){_switchAuthMode();},
																				child: Text('${_authMode == AuthMode.Login ? 'Sign Up' : 'Login'}', style: TextStyle(
																					color: _authMode == AuthMode.Login ? Colors.yellow[600] : Color.fromRGBO(206, 246, 249, 1),
																					fontSize: SizeConfig.blockSizeHorizontal*4,
																					fontFamily: 'Saira',
																					fontWeight: FontWeight.bold,
																				),),
																			)
																		],
																	)
																],
															),
														),
													),
												),
											],
										),
									)                    
								],
							),
						),
					),
				],
			),
		);
	}
}
