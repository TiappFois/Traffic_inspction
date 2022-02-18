import 'dart:io';

import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:ti/commonutils/no_connection.dart';
import 'package:ti/screens/common/coming_soon.dart';
import 'package:ti/screens/common/about_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//mport 'package:launch_review/launch_review.dart';

import 'location_settings.dart';

class NavigationMenue {
  static final log = getLogger('HistoryLimit');
  static int navIndex = 0;
  // At home screen on phone back button pressed
  //----------------------------EXIT-APP-SHEET(ON BACK PRESSED)------------------------------------//
  static void onBackButtonPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 150,
            child: Container(
              child: _buildBottomNavigationMenu(context),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  static Column _buildBottomNavigationMenu(BuildContext context) {
    log.d('you are here user home back pressed');
    return Column(
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(top: 10)),
        const Text(
          "Do you want to exit?",
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        const Padding(padding: EdgeInsets.only(top: 10.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(left: 40.0, top: 20.0)),
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                "No",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              color: Colors.teal,
              minWidth: 150,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            const Padding(padding: EdgeInsets.only(right: 40.0, top: 20.0)),
            MaterialButton(
              onPressed: () => SystemNavigator.pop(),
              //exit(0)/*Navigator.of(context).pop(true)*/,
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              color: Colors.teal,
              minWidth: 150,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(left: 65.0, top: 20.0)),
            TextButton(
              child: const Text("Rate Us",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              onPressed: () {
               /* LaunchReview.launch(
                  //StoreRedirect.redirect(
                  androidAppId: "com.cris.cmsm",
                  iOSAppId: "in.org.cris.cmsm",
                ); */
              },
            ),
            const Padding(padding: EdgeInsets.only(left: 70.0, top: 30.0)),
            TextButton(
              onPressed: () {
                TiUtilities.pushNamedPage(context, "/report");
              },
              child: const Text("Report Problem",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            )
          ],
        )
      ],
    );
  }
  //----------------------------END EXIT-APP-SHEET(ON BACK PRESSED)------------------------------------//

// END At home screen on phone back button pressed

// bottom navigation drawer before login
  static Widget navigationdrawerForAppHome(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            constraints: const BoxConstraints.expand(height: 180.0),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/0.jpg'), fit: BoxFit.cover),
            ),
            child: const Text(
              'Welcome',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              TiUtilities.pushPage(context, () => AboutUs());
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About Us'),
          ),
          ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text('Rate Us'),
              onTap: () {
             /*   LaunchReview.launch(
                  //StoreRedirect.redirect(
                  androidAppId: "com.cris.cmsm",
                  iOSAppId: "in.org.cris.cmsm",
                ); */
              }),
        ],
      ),
    );
  }

// bottom navigation drawer after login
  static Widget navigationdrawerForUserHome(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              },
              child: Container(
                  constraints: const BoxConstraints.expand(height: 180.0),
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/3.jpg'), fit: BoxFit.cover),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'user',
                            //TiUtilities.user.fname,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const <Widget>[
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ))),
          ListTile(
              onTap: () async {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/user_home', (Route<dynamic> route) => false);
              },
              leading: const Icon(
                Icons.home,
                textDirection: TextDirection.rtl,
              ),
              title: const Text(
                'UserHome',
                style: TextStyle(fontSize: 15),
              )),
          if ((TiUtilities.user.userType == "4" &&
                  TiUtilities.user.userType.toString() == "NA") ||
              TiUtilities.user.userType.toString().contains("4"))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
                const Text(
                  'View Contracts',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  textAlign: TextAlign.start,
                ),
                ListTile(
                    onTap: () async {
                      try {
                        var connectivityresult =
                            await InternetAddress.lookup('google.com');
                        if (connectivityresult != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ComingSoon()));
                        }
                      } on SocketException catch (_) {
                        // ignore: avoid_print
                        print('internet not available');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NoConnection()));
                      }
                    },
                    leading: Icon(Icons.border_color),
                    title: Text('My PO/RNote/RChallan')),
                ListTile(
                    onTap: () async {
                      try {
                        var connectivityresult =
                            await InternetAddress.lookup('google.com');
                        if (connectivityresult != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ComingSoon()));
                        }
                      } on SocketException catch (_) {
                        print('internet not available');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoConnection()));
                      }
                    },
                    leading: Icon(Icons.verified_user),
                    title: Text('TDS Certificate')),
              ],
            ),
          const SizedBox(
            height: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.teal),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 5,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
              const Text(
                'My Account',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                textAlign: TextAlign.start,
              ),
              ListTile(
                onTap: () {
                  TiUtilities.pushPage(context, () => AboutUs());
                },
                leading: const Icon(Icons.info_outline),
                title: const Text('About Us'),
              ),
              ListTile(
                  onTap: () async {
                    TiUtilities.pushNamedPage(context, '/change_password');
                    //Navigator.of(context).pushNamedAndRemoveUntil('/change_password', (Route<dynamic> route) => false);
                  },
                  leading: const Icon(Icons.security_update),
                  title: const Text('Change Password')),
              ListTile(
                  onTap: () {
                    TiUtilities.pushPage(context, () => LocationSettings());
                  },
                  leading: const Icon(Icons.pin_drop),
                  title: const Text('App Location Settings')),
              ListTile(
                  onTap: () {
                    TiUtilities.callLogoutAction(context);
                  },
                  leading: const Icon(Icons.power_settings_new),
                  title: const Text('Logout')),
            ],
          ),
        ],
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
      ),
    );
  }
}
