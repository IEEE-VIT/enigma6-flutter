import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RulesWidget extends StatelessWidget {
  String rule;
  RulesWidget(this.rule);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal*4, 0, SizeConfig.blockSizeHorizontal*4, SizeConfig.blockSizeVertical*1.75),
          child: Container(
            width: SizeConfig.blockSizeHorizontal*3,
            height: SizeConfig.blockSizeVertical*6,
            decoration: BoxDecoration(
              color: Color.fromRGBO(187, 21, 130, 1),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text("$rule", style: TextStyle(
            fontFamily: 'Saira', 
            fontSize: SizeConfig.blockSizeHorizontal*4,
            fontStyle: FontStyle.normal,
            color: Colors.white
          ),),
        )
      ],
    );
  }
}