import 'package:flutter/material.dart';
import 'package:qr_code_scaner/Screen/splash_screen.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch:Colors.amber),
      debugShowCheckedModeBanner: false,
      title:"QR Code Scanner",
      home: SplashScreen(),
    );
    
  }

}