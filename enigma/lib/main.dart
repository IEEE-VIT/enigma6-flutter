import 'package:enigma/providers/auth.dart';
import 'package:enigma/screens/auth_screen.dart';
import 'package:enigma/screens/profile_setup.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: MaterialApp(
        title: 'Enigma 6.0',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthScreen(),
        routes: {
          ProfileSetupScreen.routeName: (ctx) => ProfileSetupScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Enigma 6.0!", style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
