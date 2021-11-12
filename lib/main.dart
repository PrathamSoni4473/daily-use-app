import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:useharian/provider/todos.dart';
import './screens/homepage.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                color: Colors.white,
                fontFamily: 'Lobster',
                fontSize: 40,
              ),
              headline2: const TextStyle(
                color: Colors.white,
                fontFamily: 'Rajdhani',
                fontSize: 30,
              ),
              headline3: const TextStyle(
                color: Colors.black,
                fontFamily: 'Rajdhani',
                fontSize: 30,
              ),
              headline4: const TextStyle(
                color: Colors.white,
                fontFamily: 'Rajdhani',
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
              bodyText1: const TextStyle(
                color: Colors.white,
                fontFamily: 'Rajdhani',
                fontSize: 20,
              ),
              bodyText2: const TextStyle(
                color: Colors.white,
                fontFamily: 'Rajdhani',
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              headline5: const TextStyle(
                color: Colors.white,
                fontFamily: 'Rajdhani',
                fontSize: 25,
              ),
              headline6: const TextStyle(
                color: Colors.black,
                fontFamily: 'Rajdhani',
                fontSize: 25,
              ),
            ),
      ),
      home: AnimatedSplashScreen(
        splash: 'assets/images/logo2.png',
        splashIconSize: 350,
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        duration: 1500,
        backgroundColor: const Color.fromRGBO(49, 38, 62, 1),
      ),
    );
  }
}
