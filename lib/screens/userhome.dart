import 'dart:io';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/navigation_menue.dart';
import 'package:ti/screens/user_home.dart';

import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _pageIndex = 0;
  PageController _pageController = PageController();

  List<Widget> tabPages = [
    UserHomePageForm(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          NavigationMenue.onBackButtonPressed(context);
          return Future(() => false);
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: TiUtilities.tiAppBar(context, 'चालक दल (TI)'),
          drawer: NavigationMenue.navigationdrawerForUserHome(context),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.teal,
            currentIndex: _pageIndex,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            onTap: onTabTapped,
            // this will be set when a new tab is tapped
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                //icon: new Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                //icon: new Icon(Icons.person),
                icon: Icon(Icons.power_settings_new),
                label: 'Logout',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.live_help),
                label: 'Helpdesk',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up), label: 'Reports')
            ],
          ),
          body: PageView(
            children: tabPages,
            onPageChanged: onPageChanged,
            controller: _pageController,
          ),
        ));
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    if (index == 1) {
      TiUtilities.callLogoutAction(context);
    } else if (index == 2) {
      const url =
          'https://cms.indianrail.gov.in/tiREPORT/JSPRWD/rpt/ContactUs.html';
      TiUtilities.launchURL(url);
    } else if (index == 3) {
      const url = 'https://cms.indianrail.gov.in/tiREPORT';
      TiUtilities.launchURL(url);
    } else {
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
