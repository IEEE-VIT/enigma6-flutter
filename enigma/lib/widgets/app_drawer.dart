import 'package:enigma/providers/auth.dart';
import 'package:enigma/screens/auth_screen.dart';
import 'package:enigma/screens/leaderboard_screen.dart';
import 'package:enigma/screens/profile_screen.dart';
import 'package:enigma/screens/question_screen.dart';
import 'package:enigma/screens/rules_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';


class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[600]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AppBar(
            //centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'Enigma',
              style: TextStyle(
                color: Colors.yellow[600],
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*8,
                fontStyle: FontStyle.normal,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(52, 52, 52, 1),
          ),
            Divider(),
            ListTile(
              leading: Container(
                height: SizeConfig.blockSizeHorizontal*8,
                  child: Image.asset('assets/images/rules.png')
              ),
              title: Text('RULES', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(RulesScreen.routeName);
              },
            ),
            Divider(height: SizeConfig.blockSizeHorizontal*0.5,),
            ListTile(
              leading: Container(height: SizeConfig.blockSizeHorizontal*8,child: Image.asset('assets/images/game.png')),
              title: Text('GAME', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(QuestionScreen.routeName);
              },
            ),
            Divider(height: SizeConfig.blockSizeHorizontal*0.5,),
            ListTile(
              leading: Container(height: SizeConfig.blockSizeHorizontal*8,child: Image.asset('assets/images/leaderboard.png')),
              title: Text('LEADERBOARD', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(LeaderBoardScreen.routeName);
              },
            ),
            Divider(height: SizeConfig.blockSizeHorizontal*0.5,),
            ListTile(
              leading: Container(height: SizeConfig.blockSizeHorizontal*8,child: Image.asset('assets/images/profile.png')),
              title: Text('PROFILE', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
              },
            ),
            Divider(height: SizeConfig.blockSizeHorizontal*0.5,),
            ListTile(
              leading: Container(height: SizeConfig.blockSizeHorizontal*8,child: Image.asset('assets/images/logout.png')),
              title: Text('QUIT', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                try{
                Provider.of<Auth>(context).signOut().then((onValue){
                  Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
                });
                }
                catch(error){
                  throw(error);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
