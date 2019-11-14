import 'package:enigma/widgets/app_drawer.dart';
import 'package:enigma/widgets/rules_widget.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class RulesScreen extends StatelessWidget {

  static const routeName = '/rulesScren';
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
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                backgroundColor: Color.fromRGBO(187, 21, 130, 1),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("RULES",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Chosence',
                        fontSize: SizeConfig.blockSizeHorizontal*6,
                        fontStyle: FontStyle.normal,
                      )),
                  background: Image.asset('assets/images/road.png',
                    fit: BoxFit.cover,
                  )),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*2,),
                      RulesWidget('For every correct answer without using hints, you will get x points'),
                      SizedBox(height: SizeConfig.blockSizeVertical*5,)
                    ]
                  ),
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}