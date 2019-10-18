import 'package:enigma/screens/leaderboard_screen.dart';
import 'package:enigma/screens/profile_screen.dart';
import 'package:enigma/screens/question_screen.dart';
import 'package:enigma/screens/rules_screen.dart';
import 'package:flutter/material.dart';
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
            backgroundColor: Color.fromRGBO(52, 52, 52, 1),
          ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/images/rules.png'),
              title: Text('RULES', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(RulesScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/images/game.png'),
              title: Text('GAME', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(QuestionScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/images/leaderboard.png'),
              title: Text('LEADERBOARD', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(LeaderBoardScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/images/profile.png'),
              title: Text('PROFILE', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/images/logout.png'),
              title: Text('LOGOUT', style: TextStyle(
                fontFamily: 'Chosence',
                fontSize: SizeConfig.blockSizeHorizontal*6,
                fontStyle: FontStyle.normal,
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
