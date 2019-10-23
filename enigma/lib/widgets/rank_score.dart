import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RankAndScore extends StatelessWidget {
  
  String rank = '';
  String score = '';
  RankAndScore(this.rank, this.score);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(
         text: new TextSpan(
           style: new TextStyle(
             fontSize: SizeConfig.safeBlockHorizontal*4.5,
             fontStyle: FontStyle.normal,
             fontFamily: 'Saira',
           ),
           children: <TextSpan>[
             new TextSpan(text: 'SCORE ', style: new TextStyle(color: Colors.white)),
             new TextSpan(text: ' - 20', style: new TextStyle(color: Colors.yellow[600])),
           ]
         ),
       ),
        RichText(
         text: new TextSpan(
           style: new TextStyle(
             fontSize: SizeConfig.safeBlockHorizontal*4.5,
             fontStyle: FontStyle.normal,
             fontFamily: 'Saira',
           ),
           children: <TextSpan>[
             new TextSpan(text: 'RANK ', style: new TextStyle(color: Colors.white)),
             new TextSpan(text: ' - 5', style: new TextStyle(color: Colors.yellow[600])),
           ]
         ),
       ),
      ],
    );
  }
}
