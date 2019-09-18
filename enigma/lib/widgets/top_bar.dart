import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String image;
  final String text;

  TopBar({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth/8, SizeConfig.screenHeight/10, 0, 0),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight/4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/$image.png'),
          fit: BoxFit.cover
        )
      ),
      child: Text('$text', style: TextStyle(
        color: Colors.black,
        fontFamily: 'Chosence',
        fontSize: SizeConfig.safeBlockHorizontal*12,
        fontStyle: FontStyle.normal,
        //fontWeight: FontWeight.bold
      ),),
    );
  }
}