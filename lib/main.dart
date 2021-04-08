import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFF2F2F2),
        scaffoldBackgroundColor: Color(0xFFF2F2F2),
        fontFamily: 'Manrope',
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
