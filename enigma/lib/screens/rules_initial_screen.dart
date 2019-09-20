import 'package:enigma/size_config.dart';
import 'package:enigma/widgets/rules_widget.dart';
import 'package:flutter/material.dart';

class RulesInitialScreen extends StatefulWidget {
  @override
  _RulesInitialScreenState createState() => _RulesInitialScreenState();
}

class _RulesInitialScreenState extends State<RulesInitialScreen> {
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
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerboxisScrolled){
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color.fromRGBO(187, 21, 130, 1),
                  expandedHeight: SizeConfig.screenHeight*0.25,
                  floating: false,
                  pinned: true,
                
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    //titlePadding: EdgeInsets.fromLTRB(0, SizeConfig.screenHeight*(1/24),0, SizeConfig.screenHeight*(1/24)),
                    //collapseMode: CollapseMode.parallax,
                    title: Text('RULES',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Chosence',
                            fontSize: SizeConfig.safeBlockHorizontal*8,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    background: Image.asset('assets/images/road.png', fit: BoxFit.cover,),
                  ),
                )
              ];
            },
            body: ListView(
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
                  SizedBox(height: SizeConfig.blockSizeVertical*2,)    
              ],
            )
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
              onPressed: (){},
            ),
          )
        ]
      )
    );
  }
}

class DrawCircle extends CustomPainter {
  Paint _paint;

  DrawCircle() {
    _paint = Paint()
      ..color = Color.fromRGBO(187, 21, 130, 1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
     canvas.drawCircle(Offset(10.0,10.0), 10.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}