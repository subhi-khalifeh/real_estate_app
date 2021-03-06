import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_estate_app/ui/MainView.dart';
import 'package:real_estate_app/ui/onboarding.dart';
import 'package:real_estate_app/ui/verification_interfaces/login.dart';
import 'package:real_estate_app/ui/verification_interfaces/signup.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/shared_preference.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Widget firstScreen ;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()async{
      bool isLoggedIn = await SharedPreferenceStore.getCheckLogin();
      String isShowOnBoarding = await SharedPreferenceStore.getCheckShowOnBoarding();

      print("isLoggedIn $isLoggedIn");
      print("isShowOnBoarding $isShowOnBoarding");
      if(isShowOnBoarding == null )
        firstScreen = Onboarding();
      else if(isShowOnBoarding == "SignUpPressed")
      {
        if(isLoggedIn == null || !isLoggedIn )
          firstScreen = SignInView();
        else
          firstScreen = MainView();
      }
      else if(isShowOnBoarding == "LogInPressed")
        {
          if(isLoggedIn == null || !isLoggedIn )
            firstScreen = LoginView();
          else
            firstScreen = MainView();
        }
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(
        builder: (context) => firstScreen,
      ),(Route ee) =>false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorGrey,
          Colors.white],
          begin: Alignment.bottomCenter,end: Alignment.topCenter,
          stops: [0.1,1],tileMode: TileMode.clamp
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("svg/Logo.svg"),
          SizedBox(height: 50,),
          Text("تطبيق دلال",style: TextStyle(color: colorApp,fontSize: 26,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,),
          SizedBox(height: 75,),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(activeIconNavBar),
          ),
        ],
      ),
    );
  }
}
