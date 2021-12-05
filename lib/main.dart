import 'package:buy_and_go/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await -> um comando para permitir que sejam executadas funções não sincronizadss
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Engenharia da Computação',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LoginScreen(
        title: "Buy And GO",
      ),
    );
  }
}
