import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';

class LeaderBoardWidget extends StatefulWidget {
  String rank;
  String name;
  String ques;
  String score;
  LeaderBoardWidget({this.name, this.rank, this.ques, this.score});

  @override
  _LeaderBoardWidgetState createState() => _LeaderBoardWidgetState();
}

class _LeaderBoardWidgetState extends State<LeaderBoardWidget> {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal*15,
          child: Center(
            child: Text(
              widget.rank,
              style: TextStyle(
                fontFamily: 'Saira',
                fontSize: SizeConfig.blockSizeVertical*2,
                fontStyle: FontStyle.normal,
                color: Colors.white
              ),
            ),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal*15,
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(
                fontFamily: 'Saira',
                fontSize: SizeConfig.blockSizeVertical*2,
                fontStyle: FontStyle.normal,
                color: Colors.white
              ),
            ),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal*15,
          child: Center(
            child: Text(
              widget.ques,
              style: TextStyle(
                fontFamily: 'Saira',
                fontSize: SizeConfig.blockSizeVertical*2,
                fontStyle: FontStyle.normal,
                color: Colors.white
              ),
            ),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal*15,
          child: Center(
            child: Text(
              widget.score,
              style: TextStyle(
                fontFamily: 'Saira',
                fontSize: SizeConfig.blockSizeVertical*2,
                fontStyle: FontStyle.normal,
                color: Colors.white
              ),
            ),
          ),
        ),
      ],
    );
  }
}
