import 'package:flutter/material.dart';

class QrMakerScreen extends StatefulWidget {
  const QrMakerScreen({super.key});

  @override
  State<QrMakerScreen> createState() => _QrMakerScreenState();
}

class _QrMakerScreenState extends State<QrMakerScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Generate QR Code"),
        centerTitle:true,
        backgroundColor: Colors.deepPurpleAccent,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
      ),
     
    );
  }
}