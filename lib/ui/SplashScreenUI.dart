// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silvertouch_contach/utils/AppString.dart';

import 'CategoryScreenUI.dart';


class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({Key? key}) : super(key: key);

  @override
  _SplashScreenUIState createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4,),(){
      Get.off(()=> CategoryScreenUI(),);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/ic_bg.jpg",),fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppString.imagePath +"ic_main_logo.png",),

              Text(AppString.appName,style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),


            ],
          ),
        ),
      ),
    );
  }
}
