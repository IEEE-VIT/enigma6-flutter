import 'package:enigma/providers/auth.dart';
import 'package:enigma/screens/question_screen.dart';
import 'package:enigma/screens/rules_initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:enigma/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetupScreen extends StatefulWidget {

  static const routeName = '/profile_setup';
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

String fullName = '';
TextEditingController _nameController = new TextEditingController();


class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;

  //Map to store entered data
    Map<String, String> _authData = {
    'first_name': '',
    'last_name': '',
    'username': '',
  };

    void _submit(){
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });
  }

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

  //TextField Widget
  List<Widget> textField(String title, String data, String intial, bool e){
    return[
      Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*5)),
      TextFormField(
        textCapitalization: TextCapitalization.words,
        initialValue: intial,
        enabled: e,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: '$title',
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.blockSizeHorizontal*4,
            fontStyle: FontStyle.normal,
            fontFamily: 'Saira'
            ),
          contentPadding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal*3, 0, 0, SizeConfig.blockSizeVertical*2),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          suffixIcon: e ? Icon(Icons.mode_edit, color: Colors.white) : null
          ),
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          _authData['$data'] = value;
        },
      ),
    ];
  }

  //Submit Button
  List<Widget> button(Auth object){
    return[
      Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*15),),
        RaisedButton(
          child:
            Text(
              'DONE',
              style: TextStyle(
                fontFamily: 'Saira',
                fontSize: SizeConfig.blockSizeHorizontal*4
              ),
              ),
          onPressed: () async {
            _submit();
            await Provider.of<Auth>(context).registerUser(object.uIdToken, _authData['username'], object.userEmail).
            then((response) async {
              if(response.isRegSuccess == true){
                fullName = _authData['first_name'] + ' ' +  _authData['last_name'];
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('FullName', fullName);
                Navigator.of(context).pushNamed(RulesInitialScreen.routeName);
              }
              else if(response.isRegSuccess == false && response.payload.msg == "Username already Taken"){
                final snackBar = SnackBar(content: Text('This username is already taken, please chose another one.'));
                Scaffold.of(context).showSnackBar(snackBar);
              }
              else if(response.statusCode == 400){
                String errorMessage = 'Could not authenticate you. Please try again later';
                _showErrorDialog(errorMessage);
              }
              else if(response.wasUserRegistered == true){
                Navigator.of(context).pushNamed(QuestionScreen.routeName);
              }
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding:
            EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        color: Color.fromRGBO(97, 247, 147, 1),
        textColor: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context);
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
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth/8, SizeConfig.screenHeight/10, 0, 0),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight/4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/hoodie_3.png'),
                          fit: BoxFit.cover
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('SET UP YOUR', style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Chosence',
                            fontSize: SizeConfig.safeBlockHorizontal*8,
                            fontStyle: FontStyle.normal,
                            //fontWeight: FontWeight.bold
                          ),),
                          Text('PROFILE', style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Chosence',
                            fontSize: SizeConfig.safeBlockHorizontal*12,
                            fontStyle: FontStyle.normal,
                            //fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    )
                  ),
                  Flexible(
                    flex: 3,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal*65,
                          child: Column(
                            children: textField('Email', null, token.userEmail, false) + textField('First Name', 'first_name', null, true) + textField('Last Name', 'last_name', null, true) + textField('Username', 'username', null, true) + button(token)
                          ),
                        ),
                      ),
                    ),
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}