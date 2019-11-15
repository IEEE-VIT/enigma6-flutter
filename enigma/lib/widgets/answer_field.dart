import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';


class AnswerField extends StatefulWidget {
  @override
  _AnswerFieldState createState() => _AnswerFieldState();
}

class _AnswerFieldState extends State<AnswerField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: SizeConfig.screenHeight/5,
        width: SizeConfig.screenWidth/1.2,
        child: TextFormField(
          style: TextStyle(color: Colors.white, fontFamily: 'Saira', fontSize: SizeConfig.blockSizeHorizontal*4),
          cursorColor: Colors.yellow[600],
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color.fromRGBO(28, 29, 31,1),
            filled: true
          ),
        ),
      ),
    );
  }
}
