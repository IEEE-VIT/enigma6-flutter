import 'package:flutter/material.dart';
import 'package:enigma/size_config.dart';

class ProfileSetupScreen extends StatefulWidget {

  static const routeName = '/profile_setup';
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  //Map to store entered data
    Map<String, String> _authData = {
    'first_name': '',
    'last_name': '',
    'username': '',
  };

  //TextField Widget
  List<Widget> textField(String title, String data){
    return[
      Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*5)),
      TextFormField(
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
          suffixIcon: Icon(Icons.mode_edit, color: Colors.white)
          ),
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          _authData['$data'] = value;
        },
      ),
    ];
  }

  //Submit Button
  List<Widget> button(){
    return[
      Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*25),),
        RaisedButton(
          child:
            Text(
              'DONE',
              style: TextStyle(
                fontFamily: 'Saira',
                fontSize: SizeConfig.blockSizeHorizontal*4
              ),
              ),
          onPressed: (){},
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
                            children: textField('First Name', 'first_name') + textField('Last Name', 'last_name') + textField('Username', 'username') + button()
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