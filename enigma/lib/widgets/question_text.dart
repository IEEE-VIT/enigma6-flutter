import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';

// class QuestionText extends StatefulWidget {
  
//   @override
//   _QuestionTextState createState() => _QuestionTextState();
// }

// class _QuestionTextState extends State<QuestionText> {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Center(
//       child: Container(
//         width: SizeConfig.screenWidth/1.2,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                 child: Text(widget.text,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontStyle: FontStyle.normal,
//                     fontSize: SizeConfig.blockSizeHorizontal*4,
//                     fontFamily: 'Saira'
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//     );
//   }
// }

class QuestionText extends StatelessWidget {
  String text = '';
  QuestionText(this.text);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Container(
        width: SizeConfig.screenWidth/1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(text,
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontSize: SizeConfig.blockSizeHorizontal*4,
                    fontFamily: 'Saira'
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
