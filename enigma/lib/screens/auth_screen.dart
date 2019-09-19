import 'package:enigma/screens/profile_setup.dart';
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
      await Provider.of<Auth>(context).emailPasswordLogin(_authData['email'], _authData['password']);
      } else {
        // Sign user up
        await Provider.of<Auth>(context).emailPasswordSignup(_authData['email'], _authData['password']);
      }
    }
    catch(error){
      String errorMessage = 'Could not authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
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

  @override
  void initState() {
    password1Visible = false;
    password2Visible = false;
  }
  


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                          height: SizeConfig.blockSizeVertical*7,
                          width: SizeConfig.blockSizeHorizontal*75,
                          // Facebook Login Button
                          child: FlatButton(
                            onPressed: (){},
                            color: Color.fromRGBO(33, 33, 33, 1),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                            child: Text('Login using Facebook', style: TextStyle(
                              fontFamily: 'Saira',
                              fontSize: SizeConfig.safeBlockHorizontal*5,
                              fontStyle: FontStyle.normal,
                            ),),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top:SizeConfig.blockSizeVertical*3),),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical*7,
                          width: SizeConfig.blockSizeHorizontal*75,
                          // Google Login Button
                          child: FlatButton(
                            onPressed: () async{
                              try{
                                await Provider.of<Auth>(context).signInWithGoogle();
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
                            child: Text('Login using Google', style: TextStyle(
                              fontFamily: 'Saira',
                              fontSize: SizeConfig.safeBlockHorizontal*5,
                              fontStyle: FontStyle.normal,
                            ),),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2)),
                        Text('OR', style: TextStyle(
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
                                    height: 20,
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
                                      onPressed: _submit,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                                      color: _authMode == AuthMode.Signup ? Colors.yellow[600] : Color.fromRGBO(206, 246, 249, 1),
                                      textColor: Colors.black,
                                    ),
                                  SizedBox(height: SizeConfig.blockSizeVertical*3,),
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
