import 'dart:async';
import 'package:enigma/providers/auth.dart';
import 'package:enigma/providers/profile.dart';
import 'package:enigma/screens/profile_screen.dart';
import 'package:enigma/size_config.dart';
import 'package:enigma/widgets/app_drawer.dart';
import 'package:enigma/widgets/progress_bar.dart';
import 'package:enigma/widgets/question_pic.dart';
import 'package:enigma/widgets/question_text.dart';
import 'package:enigma/widgets/rank_score.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:enigma/providers/question.dart' as q;
import '../providers/answer.dart' as a;
import 'package:provider/provider.dart';

const questionUrl = 'https://enigma6-backend.herokuapp.com/api/auth/getCurrent/';
const answerUrl = 'https://enigma6-backend.herokuapp.com/api/auth/checkAnswer/';
const rankScoreUrl = 'https://enigma6-backend.herokuapp.com/api/auth/profile/';


class QuestionScreen extends StatefulWidget {

  static const routeName = '/questionScreen';

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  ScrollController _scrollController = ScrollController();

  Future<q.Payload> currentQuestion;
  Future<Profile> rankAndScore;

  TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final token = Provider.of<Auth>(context, listen: false).uIdToken;
    currentQuestion = _getCurrentQuestion(token);
    //rankAndScore = _getRankScore(token);
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }


   Future<q.Payload> _getCurrentQuestion(String uid) async{
     print(uid);
      try{
        final response = await http.post(
          questionUrl,
          headers: {'Authorization': 'Bearer $uid'}
        );
        q.Question question = q.questionFromJson(response.body);
        return question.payload;
      }
      catch(error){
        print(error);
        throw error;
      }
    }

    Future<a.AnswerResponse> submitAnswer(String uid, String answer) async{
      final response = await http.post(
        answerUrl,
        headers: {'Authorization': 'Bearer $uid'},
        body: {'answer': answer}
      );
      final result = a.answerResponseFromJson(response.body);
      return result;
    }

    Future<Profile> _getRankScore(String uid) async{
      final response  = await http.get(
        rankScoreUrl,
        headers: {'uid': uid}
      );
      final profile = profileFromJson(response.body);
      return profile;
    }
  
  @override
  Widget build(BuildContext context) {

    final uId = Provider.of<Auth>(context).uIdToken;

    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.screenHeight/13),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Enigma',
              style: TextStyle(
                color: Colors.yellow[600],
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*8,
                fontStyle: FontStyle.normal,
              ),
            ),
            backgroundColor: Color.fromRGBO(52, 52, 52, 1),
          ),
        ),
        drawer: AppDrawer(),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black
              ),
            ),
           Center(
             child: FutureBuilder<q.Payload>(
               future: currentQuestion,
                // ignore: missing_return
                builder: (context, snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));

                    case ConnectionState.none:
                      return Text('a');

                    case ConnectionState.active:
                      return Text('a');

                    case ConnectionState.done:
                      if(snapshot.hasError){
                        return Text('lol');
                      }
                      if(snapshot.hasData){
                        print(snapshot.data.question);
                        return ListView(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeVertical*6),
                          QuestionPic(snapshot.data.imgUrl, snapshot.data.level.toString()),
                          SizedBox(height: SizeConfig.blockSizeVertical*4,),
                          QuestionText(snapshot.data.question),
                          SizedBox(height: SizeConfig.blockSizeHorizontal*7),
                          Form(
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: SizeConfig.screenHeight/5,
                                    width: SizeConfig.screenWidth/1.2,
                                    child: TextFormField(
                                      autofocus: false,
                                      textInputAction: TextInputAction.done,
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
                                      submitAnswer(uId, _answerController.text).then((result){
                                        if(result.isAnswerCorrect == true){
                                          final snackBar = SnackBar(content: Text('You are correct!'));
                                          Scaffold.of(context).showSnackBar(snackBar);
                                          setState(() {
                                            hintClicked = false;
                                            _answerController.clear();
                                            currentQuestion = _getCurrentQuestion(uId);
                                            //rankAndScore = _getRankScore(uId);
                                          });
                                        }
                                        else if(result.isAnswerCorrect == false){
                                          final snackBar = SnackBar(content: Text(result.payload.howClose));
                                          Scaffold.of(context).showSnackBar(snackBar);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical*20),
                        ],
                      );
                      }
                      else{
                        return Text('s');
                      }
                  }
                }
             ),
           ),
          //  FutureBuilder<Profile>(
          //   future: rankAndScore,
          //   builder: (ctx, snapshot){
          //     switch(snapshot.connectionState){
          //       case ConnectionState.none:
          //         return Text('s');
          //       case ConnectionState.active:
          //         return Text('a');
          //       case ConnectionState.waiting:
          //         return Positioned(
          //         bottom: 0,
          //         child: Container(
          //           padding: EdgeInsets.all(20),
          //           decoration: BoxDecoration(
          //             color: Color.fromRGBO(52, 52, 52, 1)
          //           ),
          //           width: SizeConfig.screenWidth,
          //           height: SizeConfig.screenHeight/6.5,
          //           child: Column(
          //             children: <Widget>[
          //               RankAndScore('', ''),
          //               Padding(padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical),),
          //               ProgressBar(null)
          //             ],
          //           ),
          //         ),
          //       );
          //       case ConnectionState.done:
          //         Positioned(
          //           bottom: 0,
          //           child: Container(
          //             padding: EdgeInsets.all(20),
          //             decoration: BoxDecoration(
          //               color: Color.fromRGBO(52, 52, 52, 1)
          //             ),
          //             width: SizeConfig.screenWidth,
          //             height: SizeConfig.screenHeight/6.5,
          //             child: Column(
          //               children: <Widget>[
          //               RankAndScore(snapshot.data.payload.user.rank.toString(), snapshot.data.payload.user.points.toString()),
          //               Padding(padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical),),
          //               ProgressBar(snapshot.data.payload.user.level)
          //               ],
          //             ),
          //           ),
          //         );
          //     }
          //   }
          //  )
          ],
        ),
      ),
    );
  }
}




