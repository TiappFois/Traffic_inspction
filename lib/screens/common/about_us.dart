import 'package:ti/commonutils/logger.dart';
import 'package:ti/commonutils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final log = getLogger('AboutUs');
  double width, height;
  var padding;

  @override
  initState() {
    super.initState();
    versionControl();
    log.d("calling---");
  }

  String appVersionCode = '';
  void versionControl() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersionCode =
          packageInfo.version + ' (' + packageInfo.buildNumber + ')';
    });

    log.d("aboutappVersionCode = " + appVersionCode);
  }

  String url;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    width = SizeConfig.screenWidth;
    height = SizeConfig.screenHeight;
    padding = MediaQuery.of(context).padding;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // key: _scaffoldkey,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          title: Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 1.0)),
              Container(
                  /*   padding: const EdgeInsets.all(20.0),*/
                  alignment: Alignment.center,
                  child: const Text('   About Us    ')),
              const Padding(padding: EdgeInsets.only(right: 15.0)),
              IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.home,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/user_home', (Route<dynamic> route) => false);
                },
              ),
            ],
          )),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          // child: Container(
          //margin: new EdgeInsets.all(15.0),
          child: Form(
            child: FormUI(context),
          ),
          // ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget FormUI(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Expanded(
                    child: Card(
                      color: Colors.teal,
                      child: Text(
                        "\n    चालक दल (ti)\n    Crew Management System                 \n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          //),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 1, color: Colors.grey.shade300),
            ),
            // color: Colors.grey[100],

            child: Row(
              children: const <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),

                /* The crew management system (ti) is a critical IT application of the Indian Railways which manages crew assignment to various trains and directly impacts the safety of train operations. ... The application aims at managing over one lakh drivers and guards to ensure round the clock safe operations of railways.*/
                Flexible(
                  child: Text(
                    "\nThis is the official mobile app of ti application (ti.indianrail.gov.in ). ti  mobile  app  provides information available on ti. This app also provides Crew to SignOn/Off, feeding Abnormality, providing CLI to give the information about his own working, and to monitor allotted Crew etc.\n",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 1, color: Colors.grey.shade300),
            ),
            //color: Colors.grey[100],
            child: Row(
              children: const <Widget>[
                Text(
                  " \n   App Name:\n",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.teal),
                ),
                Text(
                  " \n       चालक दल (ti)\n",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.teal),
                ),
              ],
            ),
          ),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 1, color: Colors.grey.shade300),
            ),
            //color: Colors.grey[100],
            child: Row(
              children: <Widget>[
                const Text(
                  " \n   Version (Code):\n",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.teal),
                ),
                Text(
                  " \n             " + appVersionCode + "\n",
                  style: const TextStyle(fontSize: 15.0, color: Colors.teal),
                ),
              ],
            ),
          ),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 1, color: Colors.grey.shade300),
            ),
            //color: Colors.grey[100],
            child: Row(
              children: <Widget>[
                const Text(
                  " \n   Website:\n",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.teal),
                ),
                InkWell(
                  child: const Text(
                    " \n           ti.indianrail.gov.in\n",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.teal,
                    ),
                  ),
                  onTap: () {
                    url = "https://cms.indianrail.gov.in";
                    _launchURL(url);
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: const <Widget>[
                Text(
                  " \n Developed and Published by",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0,
                      color: Colors.teal),
                ),
                Text(
                  " Centre For Railway Information Systems",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.teal),
                ),
                Text(
                  "  (An Organization of the Ministry of Railways, Govt. of India)\n",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10.0,
                      color: Colors.teal),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
