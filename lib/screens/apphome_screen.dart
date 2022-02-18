import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:ti/commonutils/navigation_menue.dart';
import 'package:ti/commonutils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppHomePageForm extends StatefulWidget {
  static var projectVersion;

  const AppHomePageForm({Key key}) : super(key: key);
  @override
  _AppHomePageFormState createState() => _AppHomePageFormState();
}

class _AppHomePageFormState extends State<AppHomePageForm> {
  final log = getLogger('ReportAbnormalityForm');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();
  var appVersion, sqfliteVersion, webServiceVersion;

  void versionControl() async {
    //final dbhelper = DatabaseHelper.instance;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.buildNumber;
    log.d("appVersion = " + appVersion);
    AppHomePageForm.projectVersion = packageInfo.version;
    log.d("Version = " + AppHomePageForm.projectVersion);
  }

  //----------------------------IMAGE-SLIDESHOW------------------------------------//
  CarouselSlider carouselSlider;
  final int _current = 0;
  List imgList = [
    'assets/0.jpg',
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
    'assets/6.jpg',
  ];
//----------------------------IMAGE-SLIDESHOW------------------------------------//
  @override
  Future<void> initState() {
    TiUtilities.versionCheck(context, true);
    super.initState();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

//--------------------------------------WIDGET BUILD OVERRIDE-----------------------------
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          NavigationMenue.onBackButtonPressed(context);
          return Future(() => false);
        },
        child: Scaffold(
          key: _scaffoldKey,

          body: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    carouselSlider = CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        height: 200.0,
                        initialPage: 0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        reverse: false,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        //pauseAutoPlayOnTouch: Duration(seconds: 5),
                        scrollDirection: Axis.horizontal,
                      ),
                      items: imgList.map((imgUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image(
                                  image: AssetImage(imgUrl),
                                ));
                          },
                        );
                      }).toList(),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(imgList, (index, url) {
                        return Container(
                          width: 10.0,
                          height: 1.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 2.0),
                        );
                      }),
                    ),
                    //////////////////image slider/carousel ends/////////////////////////////

                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight / 7),
            ],
          ),

          //////Bottom Navigation Bar//////////////
          //////Bottom Navigation Bar//////////////
          //bottomNavigationBar: NavigationMenue.bottomnavigationbar(context)
        ));
  }

//-----------------------------------END WIDGET BUILD OVERRIDE-----------------------------

}
