import 'dart:async';

import 'package:assessmentcelebrare/Screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children:[
           Center(
             child:Column(
               children: [
                 Icon(Icons.email_outlined,color: Colors.grey,size: 60,),
                 Text('Celebrare',style: GoogleFonts.dancingScript(
                     fontWeight: FontWeight.bold,
                     fontSize: 41,
                     color: Colors.grey
                 ),)
               ],
             ),
           ),
             ],
       ),
    );
  }
}
