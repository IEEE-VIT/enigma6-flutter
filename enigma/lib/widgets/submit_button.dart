import 'package:enigma/providers/auth.dart';
import 'package:enigma/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

Future<Map<String, String>> submitAnswer(String uid, String answer) async{
  final response = await http.post(
    url,
    headers: {'Authentication': 'Bearer $uid'},
    body: {'answer': answer}
  );
  final extractedResponse = json.decode(response.body);
  final result = {
    'message': extractedResponse['payload']['msg'],
    'accuracy': extractedResponse['payload']['howClose']
  };
  return result;
}

class SubmitButton extends StatefulWidget {
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

const url = '/submitAnswer';

class _SubmitButtonState extends State<SubmitButton> {

  TextEditingController _answerController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context).uIdToken;
    SizeConfig().init(context);
    return Form(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: SizeConfig.screenHeight/5,
              width: SizeConfig.screenWidth/1.2,
              child: TextFormField(
                controller: _answerController,
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
          ),
          SizedBox(height: SizeConfig.blockSizeVertical*2),
          Center(
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal*5, SizeConfig.blockSizeVertical, SizeConfig.blockSizeHorizontal*5, SizeConfig.blockSizeVertical),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical)
              ),
              color: Colors.yellow[600],
              child: Text('SUBMIT', style: TextStyle(
                color: Colors.black,
                fontFamily: 'Saira',
                fontSize: SizeConfig.blockSizeHorizontal*5,
                fontStyle: FontStyle.normal
              ),),
              onPressed: (){
                submitAnswer(token, _answerController.text).then((result){
                  if(result['message'] == 'Correct Answer'){
                    
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
