import 'package:flutter/material.dart';
import 'package:qr_code_scaner/Screen/qr_maker_screen.dart';
import 'package:qr_code_scaner/Screen/qr_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar:AppBar(
          title: Text("QR Code Generator & Scanner"),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
          backgroundColor:Colors.deepPurpleAccent,
          centerTitle: true,
         ),
         body:Center(
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                   Navigator.push(context,
                   MaterialPageRoute(builder: (context) => const QrScreen()),);
                  
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepPurple, 
                   foregroundColor: Colors.white,
                   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12),
                  ),
                   elevation: 5,
                ),
                child:Text("QR-Scanner")),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: (){
                   Navigator.push(context,
                   MaterialPageRoute(builder: (context) => const QrMakerScreen()),);
                }, 
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepPurple, 
                   foregroundColor: Colors.white, 
                   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12),
                  ),
                   elevation: 5,
                 ),
                child:Text("QR-Genarator")),
              ],
            ),
          ),
         ),
         );
  
  }
}