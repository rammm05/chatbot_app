import 'dart:async';
import 'package:chatbot_app/screens/initial_page.dart';
import 'package:chatbot_app/utils/util_helper.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget{
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> InitialPage()));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBlack,
      body: Center(child: SizedBox(
        height: 130,
          child: Image.asset("assets/images/ic_logo.png")),),
    );
  }
}