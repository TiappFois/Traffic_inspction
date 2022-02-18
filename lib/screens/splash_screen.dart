import 'dart:async';

import 'package:ti/bl/login_bl.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:ti/generated/l10n.dart';
import 'package:ti/screens/apphome.dart';
import 'package:ti/screens/userhome.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final log = getLogger('SplashScreen');

  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    log.d("spalsh screeen called");
    super.initState();
    // postorg();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    LoginBl.checkLoginStatusAtAppStarting().then((appLoginStatus) {
      log.d('avinesh--$appLoginStatus');
      if (appLoginStatus == 'LOGGED_IN') {
        Timer(
            Duration(seconds: 2),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserHome())));
      } else {
        Timer(
            Duration(seconds: 2),
            //() => Navigator.push(context, MaterialPageRoute(builder: (context) => AppHomePageForm())));
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AppHome())));
      }
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: const [
                    0.1,
                    0.5
                  ],
                  colors: [
                    Colors.teal[300],
                    Colors.teal[700],
                  ]),
            ),
            child: ScaleTransition(
                scale: _animation,
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Image.asset(
                                'assets/splash_cris_logo.png',
                                width: 105,
                                height: 105,
                              ),
                              Padding(padding: EdgeInsets.all(11.0)),
                              Text(
                                'यातायात निरीक्षक (TI)',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            ]),
                      ),
                      Text(
                        'Efficiency - Transparency - Monitoring',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.end,
                      ),
                      Padding(padding: EdgeInsets.all(10.0))
                    ]))));
  }
}
