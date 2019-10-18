import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class ProgressBar extends StatefulWidget {
  int level;
  ProgressBar(this.level);
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('START', style: TextStyle(
              color: Colors.yellow[600],
              fontFamily: 'Saira',
              fontSize: SizeConfig.blockSizeHorizontal*3,
              fontStyle: FontStyle.normal
            ),),
            Text('END', style: TextStyle(
              color: Colors.green,
              fontFamily: 'Saira',
              fontSize: SizeConfig.blockSizeHorizontal*3,
              fontStyle: FontStyle.normal
            ),)
          ],
        ),
        Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),),
        LinearPercentIndicator(
            width: SizeConfig.screenWidth*0.89,
            percent: 0.5,
            progressColor: Colors.yellow[600],
            animation: true,
            lineHeight: SizeConfig.blockSizeVertical,
            linearStrokeCap: LinearStrokeCap.roundAll,
          ),
      ],
    );
  }
}
