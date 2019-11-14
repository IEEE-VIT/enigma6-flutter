import 'package:enigma/screens/question_screen.dart';
import 'package:enigma/size_config.dart';
import 'package:enigma/widgets/rules_widget.dart';
import 'package:flutter/material.dart';


class RulesInitialScreen extends StatefulWidget {

  static const routeName = '/inital-rules';

  @override
  _RulesInitialScreenState createState() => _RulesInitialScreenState();
}

class _RulesInitialScreenState extends State<RulesInitialScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal*40, SizeConfig.screenHeight/8, 0, 0),
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight/4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/images/road.png'),
                            fit: BoxFit.cover
                          )
                        ),
                        child: Text('RULES', style: TextStyle(
                          fontFamily: 'Chosence',
                          fontSize: SizeConfig.blockSizeHorizontal*12,
                          fontStyle: FontStyle.normal,
                          color: Colors.white
                        ),)
                      )
                    ),
                    Flexible(
                      flex: 3,
                      child: AllRules(),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical*8),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: SizeConfig.blockSizeVertical*5,
              left: SizeConfig.screenWidth*0.4,
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal*5, SizeConfig.blockSizeVertical, SizeConfig.blockSizeHorizontal*5, SizeConfig.blockSizeVertical),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical)
                ),
                color: Color.fromRGBO(187, 21, 130, 1),
                child: Text('PLAY', style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Saira',
                  fontSize: SizeConfig.blockSizeHorizontal*5,
                  fontStyle: FontStyle.normal
                ),),
                onPressed: (){
                  Navigator.of(context).pushNamed(QuestionScreen.routeName);
                },
              ),
            )
          ]
        )
      ),
    );
  }
}

class AllRules extends StatelessWidget {
  const AllRules({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*2,),
        RulesWidget('For every correct answer without using hints, you will get x points'),
        SizedBox(height: SizeConfig.blockSizeVertical*5,)    
      ],
    );
  }
}
