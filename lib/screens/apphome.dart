import 'package:provider/src/provider.dart';
import 'package:ti/LanguageChangeProvider.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/navigation_menue.dart';
import 'package:ti/generated/l10n.dart';
import 'package:ti/screens/apphome_screen.dart';
import 'package:ti/screens/login_page.dart';
import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _pageIndex = 0;
  PageController _pageController = PageController();

  List<Widget> tabPages = [
    AppHomePageForm(),
    LoginPageForm(),
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
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.teal,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 // 'यातायात निरीक्षक (TI)',
                  S.of(context).welcome,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          context.read<LanguageChangeProvider>().changeLocale('hi');
                        },
                        child: Text('हिन्दी' ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: (){
                          context.read<LanguageChangeProvider>().changeLocale('en');
                        },
                        child: Text('English'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
          backgroundColor: Colors.grey[200],
          drawer: NavigationMenue.navigationdrawerForAppHome(context),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.teal,
            currentIndex: _pageIndex,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            onTap: onTabTapped,
            // this will be set when a  tab is tapped
            items: [
               BottomNavigationBarItem(
                icon: Icon(Icons.home),
                //icon:  Icon(Icons.home),
                label: S.of(context).Home,
              ),
              if (TiUtilities.user == null)
                 BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin),
                  label: S.of(context).Login

                ),
              if (TiUtilities.user != null)
                const BottomNavigationBarItem(
                  //icon:  Icon(Icons.person),
                  icon: Icon(Icons.power_settings_new),
                  label: 'Logout',
                ),
               BottomNavigationBarItem(
                icon: Icon(Icons.live_help),
                label: S.of(context).Helpdesk,
              )
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
    if (index == 2) {
      const url =
          'https://cms.indianrail.gov.in/cmsREPORT/JSPRWD/rpt/ContactUs.html';
      TiUtilities.launchURL(url);
    } else {
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
