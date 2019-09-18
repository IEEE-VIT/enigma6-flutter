import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
       body: 
     Stack(
         children: <Widget>[
           Container(
             child: new Image.asset(
               'assets/images/background.png',
               width: SizeConfig.screenWidth,
               height: SizeConfig.screenHeight,
               fit: BoxFit.fill
             ),
           ),
           Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth/20, SizeConfig.screenHeight/25, 0, 0),
            child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal*7,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Chosence',
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: '0', style: new TextStyle(color: Colors.white)),
                      new TextSpan(text: '7', style: new TextStyle(color: const Color(0xffe3cd14))),
                    ],
                  ),
                )
              ),
           ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, SizeConfig.screenWidth/20, SizeConfig.screenHeight/25),
            child: Align(
                alignment: Alignment.bottomRight,
                child: RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal*7,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Chosence',
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: '1', style: new TextStyle(color: Colors.greenAccent[400])),
                      new TextSpan(text: '0', style: new TextStyle(color: Colors.white)),
                    ],
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, SizeConfig.screenHeight/20, SizeConfig.screenWidth/20, 0),
            child: Align(
                alignment: Alignment.topRight,
                child: RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal*7,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Chosence',
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: '8', style: new TextStyle(color: const Color.fromRGBO(0, 240, 255, 1),)),
                      new TextSpan(text: '0', style: new TextStyle(color: const Color(0xffffffff))),
                    ],
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth/20, 0, 0, SizeConfig.screenHeight/20),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal*7,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Chosence',
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: '0', style: new TextStyle(color: Colors.white)),
                      new TextSpan(text: '9', style: new TextStyle(color: Colors.purpleAccent[400])),
                    ],
                  ),
                )
            ),
          ),
          Positioned(
            bottom: SizeConfig.screenHeight/3.2,
            left: SizeConfig.screenWidth/11,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/enigma.png', width: SizeConfig.screenWidth/1.2,),
                SizedBox(height: 10,),
                Text('AN ONLINE CRYPTIC HUNT', style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.screenHeight/30,
                  fontFamily: 'Chosence',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: SizeConfig.screenHeight/10,),
                Stack(
                  children: <Widget>[
                    Icon(Icons.play_circle_outline, color: Colors.white, size: SizeConfig.screenHeight/15,)
                  ],
                )
              ],
            ),
          )
        ]
      )
    );
  }
}
