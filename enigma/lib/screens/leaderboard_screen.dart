import 'package:enigma/providers/auth.dart';
import 'package:enigma/providers/leaderboard.dart';
import 'package:enigma/size_config.dart';
import 'package:enigma/widgets/app_drawer.dart';
import 'package:enigma/widgets/leaderboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const leaderBoardUrl = 'https://enigma6-backend.herokuapp.com/api/auth/leaderBoard/';

Future<Leaderboard> playerList;

Future<Leaderboard> _getLeaderBoard(String uid) async{
  final response = await http.post(
    leaderBoardUrl,
    headers: {'Authorization': 'Bearer $uid'}
  );

  print('Leaderboard data size: ${response.body.length}');
  final leaders = leaderboardFromJson(response.body);
  return leaders;
}


class LeaderBoardScreen extends StatefulWidget {
  static const routeName = '/leaderboard';
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {

   @override
  void initState(){
    final uId = Provider.of<Auth>(context, listen: false).uIdToken;
    playerList = _getLeaderBoard(uId);
    super.initState();
  }

  final leaderAppBar = SliverAppBar(
    backgroundColor: Colors.grey[600],
    expandedHeight: 200.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("LEADERBOARD",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Chosence',
              fontSize: SizeConfig.blockSizeHorizontal*6,
              fontStyle: FontStyle.normal,
            )),
        background: Image.asset('assets/images/winner.png',
          fit: BoxFit.cover,
        )),
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: AppDrawer(),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black
              ),
            ),
            FutureBuilder<Leaderboard>(
              future: playerList,
              builder: (context, snapshot){
                Widget listLeaders;
                if(snapshot.connectionState == ConnectionState.waiting){
                  listLeaders = SliverList(
										delegate: SliverChildListDelegate(
											[
												for(int i=0; i<12; i++)
													Column(
														children: <Widget>[
															FadingPlaceholder(),
															SizedBox(height: SizeConfig.blockSizeVertical*3)
													],)

											]
										),
									);
                }
                else{
                  listLeaders = SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        for(int i = 0; i<snapshot.data.payload.leaderBoard.length; i++)
                          Column(children: <Widget>[
                            LeaderBoardWidget(
                            name: snapshot.data.payload.leaderBoard[i].name,
                            score: snapshot.data.payload.leaderBoard[i].points.toString(),
                            rank: snapshot.data.payload.leaderBoard[i].rank.toString(),
                            ques: snapshot.data.payload.leaderBoard[i].level.toString(),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical*3)
                          ],
                        )
                      ]
                    )
                  );
                }
                return CustomScrollView(
                  slivers: <Widget>[
                    leaderAppBar,
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(height: SizeConfig.blockSizeVertical*3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: SizeConfig.blockSizeHorizontal*15,
                                child: Center(
                                  child: Text(
                                    "RANK",
                                    style: TextStyle(
                                      fontFamily: 'Saira',
                                      fontSize: SizeConfig.blockSizeVertical*2,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(164, 34, 255, 1)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: SizeConfig.blockSizeHorizontal*15,
                                child: Center(
                                  child: Text(
                                    "NAME",
                                    style: TextStyle(
                                      fontFamily: 'Saira',
                                      fontSize: SizeConfig.blockSizeVertical*2,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(164, 34, 255, 1)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: SizeConfig.blockSizeHorizontal*15,
                                child: Center(
                                  child: Text(
                                    "LEVEL",
                                    style: TextStyle(
                                      fontFamily: 'Saira',
                                      fontSize: SizeConfig.blockSizeVertical*2,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(164, 34, 255, 1)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: SizeConfig.blockSizeHorizontal*15,
                                child: Center(
                                  child: Text(
                                    "SCORE",
                                    style: TextStyle(
                                      fontFamily: 'Saira',
                                      fontSize: SizeConfig.blockSizeVertical*2,
                                      fontStyle: FontStyle.normal,
                                      color: Color.fromRGBO(164, 34, 255, 1)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical*3,),
                        ]
                      )
                    ),
                    listLeaders
                  ]
                );
              },
            )
          ]
        )
      ),
    );
  }
}

class FadingPlaceholder extends StatefulWidget {
  @override
  _FadingPlaceholderState createState() => _FadingPlaceholderState();
}

class _FadingPlaceholderState extends State<FadingPlaceholder> {

	double opacity = 1.0;

	changeOpacity() {
		Future.delayed(Duration(milliseconds: 400), () {
			if(mounted){
				setState(() {
					opacity = opacity == 0.2 ? 1.0 : 0.2;
					changeOpacity();
				});
			}
		});
	}

	@override
  void initState() {
		changeOpacity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
			mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        AnimatedOpacity(
					opacity: opacity,
          duration: Duration(milliseconds: 400),
          child: Container(
						height: SizeConfig.blockSizeVertical*2,
						width: SizeConfig.blockSizeHorizontal*15,
						decoration: BoxDecoration(color: Color.fromRGBO(239, 240, 245, 1),
						borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical*3),
						)
					),
        ),
				AnimatedOpacity(
					opacity: opacity,
					duration: Duration(milliseconds: 400),
					child: Container(
						height: SizeConfig.blockSizeVertical*2,
						width: SizeConfig.blockSizeHorizontal*15,
						decoration: BoxDecoration(color: Color.fromRGBO(239, 240, 245, 1),
							borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical*3),
						)
					),
				),
				AnimatedOpacity(
					opacity: opacity,
					duration: Duration(milliseconds: 400),
					child: Container(
						height: SizeConfig.blockSizeVertical*2,
						width: SizeConfig.blockSizeHorizontal*15,
						decoration: BoxDecoration(color: Color.fromRGBO(239, 240, 245, 1),
							borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical*3),
						)
					),
				),
				AnimatedOpacity(
					opacity: opacity,
					duration: Duration(milliseconds: 400),
					child: Container(
						height: SizeConfig.blockSizeVertical*2,
						width: SizeConfig.blockSizeHorizontal*15,
						decoration: BoxDecoration(color: Color.fromRGBO(239, 240, 245, 1),
							borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical*3),
						)
					),
				),
      ],
    );
  }
}








