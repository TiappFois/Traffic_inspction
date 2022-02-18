import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:ti/bl/login_bl.dart';
import 'package:ti/commonutils/api_call.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:ti/commonutils/no_connection.dart';
import 'package:ti/model/ExistingInspListModel.dart';
import 'package:ti/model/InspMstrModel.dart';
import 'package:ti/pages/SttnInsp/sttn_inspection.dart';

import 'package:ti/screens/apphome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info/package_info.dart';
//import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:ti/generated/l10n.dart';

import 'ti_constants.dart';

class TiUtilities {
  static final log = getLogger('TiUtilities');
  static bool loggedin = false;
  static const platform = MethodChannel('DownloadChannel');
  static bool loginflag = false;
  static int bbottom = 0;

  static TiUser user;
  static InspMstrModel inspmstr;
  static List<dynamic> dataOrganisation;
  static String version = "";
  static String versionCode = "";
  static Random random = Random();

  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  TiUtilities() {
    log.d("TiUtilities() called---");
  }

 static Future<Position> getUserGeoPosition() async {
    var geoPos = Position(latitude: 0.0, longitude: 0.0);
    print("In getprosition");
    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (locationServiceEnabled == null || !locationServiceEnabled) {
      log.d(locationServiceEnabled.toString() +
          ' : locationServiceEnabled Issue');
      print(locationServiceEnabled.toString() +
          ' : locationServiceEnabled Issue');
      locationServiceEnabled = await Geolocator.openLocationSettings();
    } else {
      LocationPermission locationPermission =
      await Geolocator.checkPermission();
      if (!(locationPermission == LocationPermission.whileInUse ||
          locationPermission == LocationPermission.always)) {
        log.d(locationPermission.toString() + ' : locationPermission Issue');
        print(locationPermission.toString() + ' : locationPermission Issue');
        await Geolocator.requestPermission();
      } else {
        try {
          print("geoPos1" + geoPos.toString());
          geoPos = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
              timeLimit: Duration(seconds: 5));
          log.d(geoPos);
          print("geoPos" + geoPos.toString());
        } catch (e, stackTrace) {
          print("in catch" + e.toString());
        }
      }
    }
    return geoPos;
  }

  static void showInSnackBar(BuildContext context, String value) {
    Widget snackbar = SnackBar(
      content: Text(value),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.redAccent[100],
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  static Future<bool> showOKDialog(BuildContext context, String msg) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return customAlertDialog(context, msg, false);
        });
  }

  static Future<bool> showOkDialogWithOkCancelAndReturnBool(
      BuildContext context, String msg) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return customAlertDialog(context, msg, true);
        });
  }

  static Future<String> showOkDialogWithOkCancel(BuildContext context, String msg) {
          return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.teal,
              title:  Text(msg,
                 style: new TextStyle(color: Colors.white, fontSize: 18),
                 textAlign: TextAlign.center,

          ),
          //  content:  Text(msg),
          actions: <Widget>[
          TextButton(
          onPressed: () => Navigator.pop(context, 'NO'),
          child:  Text('NO',
                        style: new TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                                  textAlign: TextAlign.center,
                             ),
          ),
          TextButton(
          onPressed: () => Navigator.pop(context, 'YES'),
          child:  Text('YES',
                      style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                      textAlign: TextAlign.center,
                      ),
          ),
          ],
          ));
  }

  static AppBar tiAppBar(BuildContext context, String title) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () =>  Navigator.pop(context),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.teal,
      title: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(alignment: Alignment.center, child: Text(title)),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(
                Icons.home,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/user_home', (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  static AppBar tiSttnInspListAppBar(BuildContext context, String title) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/user_home', (Route<dynamic> route) => false);
        },
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.teal,
      title: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(alignment: Alignment.center, child: Text(title)),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(
                Icons.home,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/user_home', (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }


  static Theme tiBottomNaviBar(BuildContext context, String link) {
    int index = 1;  //here invisible 2nd item selected (there are 3 items on bottom navi bar - 2nd one is hidden)
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child:  BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) { //setState((){
         // this.index = index; // icon not chnaging color on UI // you can do callback to see color change
        if (index == 2) {
          Navigator.pushNamed(context, link);
        }
        if (index == 0) {
          Navigator.pushNamed(context, '/sttnInspList');
        }else {

        }
         //});
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, ),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold ),
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label :  "List",

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_outlined, color: Colors.teal),
            label: '',

          ),

          new BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.lime,
              child: Icon(
                Icons.arrow_forward_outlined,
                color: Colors.teal,

              ),
            ),
            label: "Skip",


          ),
        ],

      ),
    );
  }


  static Future<String> callSttnInspEntryWebService(BuildContext context ,String urlInputString , String SttnInspType) async {
    //log.d(alpa);
    print('Inside Callservuce');
    var url= TiConstants.webServiceUrl +SttnInspType;
    print("urlInputString:" + urlInputString );

    print("url:" + url );

     final response = await http.post(Uri.parse(url),
        headers: TiConstants.headerInput,
        body: urlInputString,
        encoding: Encoding.getByName("utf-8"));

    print('jsonRes' + response.body);

    log.d("response code = " + response.statusCode.toString());

    if (response == null || response.statusCode != 200) {
      TiUtilities.showOKDialog(context, "Issue in saving data");
      throw new Exception(
          'HTTP request failed, statusCode: ${response?.statusCode}');
    } else {
      print('jsonRes' + response.body);

      var jsonResult = json.decode(response.body);

      log.d("json result = " + jsonResult.toString());

      TiUtilities.inspmstr.cinsplist = TiUtilities.inspmstr.cinsplist + jsonResult['registerNumb'].toString() ;
      log.d("TiUtilities.inspmstr.cinsplist 2 = " + TiUtilities.inspmstr.cinsplist);

      return 'Record Successfully Saved.';
    }
}

  static AlertDialog customAlertDialog(
      BuildContext context, String msg, bool cancelButton) {
    return AlertDialog(
      backgroundColor: Colors.teal,
      title: Text(
        'माल परिचालन सूचना प्रणाली (FOIS)',
        style: new TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              msg,
              style: new TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (cancelButton)
                  GestureDetector(
                    child: Text(
                      'CANCEL',
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  child: Text(
                    'OK',
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static versionCheck(context, bool checkNewVersion) async {
    //Get Current installed version of app
    log.d('Get Current installed version of app');
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    version = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    log.d('appName:' +
        appName +
        ' packageName:' +
        packageName +
        ' version: ' +
        version +
        ' versionCode: ' +
        versionCode);
    double currentVersion =
    double.parse(packageInfo.version.trim().replaceAll(".", ""));
    log.d(currentVersion);
    if (checkNewVersion) {
      try {
        double newVersion = 0.0;
        List versionDetail =
        await ApiCall.callGetPushedVersionDetailWebService();
        log.d(versionDetail);
        if (versionDetail.length == 2) {
          newVersion = double.parse(
              versionDetail[0].toString().trim().replaceAll(".", ""));
          log.d('newVersion: ' + newVersion.toString());
          if (newVersion > currentVersion) {
            showVersionDialog(context);
          }
        }
      } on Exception catch (exception) {
        // Fetch throttled.
        log.d(exception);
      } catch (exception) {
        log.d('Unable to fetch remote config. Cached or default values will be '
            'used');
      }
    }
  }

  static showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(btnLabel),
              onPressed: () => launchURL(TiConstants.APP_STORE_URL),
            ),
            TextButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
            : AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(btnLabel),
              onPressed: () => launchURL(TiConstants.PLAY_STORE_URL),
            ),
            TextButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

/*
  static getProgressDialog(ProgressDialog pr) {
    pr.style(
        message: 'Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 20.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));
    pr.show();
  }

  static stopProgress(ProgressDialog pr) {
    pr.hide().then((isHidden) {
      log.d(isHidden);
    });
  }
*/
  static setPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  static setLandscapeOrientation() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  static Widget attachDocsListView(
      BuildContext context, String attachDocsString) {
    var attachDocsArray = attachDocsString.split('~~');

    return ListView.separated(
        itemCount: attachDocsString != null ? attachDocsArray.length : 0,
        itemBuilder: (context, index) {
          String fileUrl = TiConstants.contextPath +
              attachDocsArray[index].split(',')[1].toString();
          String fileName = fileUrl.substring(fileUrl.lastIndexOf("/"));

          return Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        (index + 1).toString() + ". ",
                        style:
                        const TextStyle(color: Colors.white, fontSize: 17),
                      )
                    ],
                  ),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Dialog(
                              backgroundColor: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                  ),
                                  Text(
                                    "Loading",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ],
                              ),
                            );
                            openPdf(context, fileUrl, fileName);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  TiUtilities.ackAlert(
                                      context, fileUrl, fileName);
                                },
                                child: Text(
                                  attachDocsArray[index]
                                      .split(',')[1]
                                      .toString()
                                      .substring(attachDocsArray[index]
                                      .split(',')[1]
                                      .toString()
                                      .lastIndexOf('/') +
                                      1),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  TiUtilities.ackAlert(
                                      context, fileUrl, fileName);
                                },
                                child: Text(
                                  attachDocsArray[index]
                                      .split(',')[0]
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            ],
                          )))
                ],
              ));
        },
        separatorBuilder: (context, index) {
          return const Divider();
        });
  }

  static Widget corrigendumListView(
      BuildContext context, String attachCorriString) {
    var corriArray = attachCorriString.split(',');

    return ListView.separated(
        itemCount: attachCorriString != null ? corriArray.length : 0,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        (index + 1).toString() + ".    ",
                        style:
                        const TextStyle(color: Colors.white, fontSize: 17),
                      )
                    ],
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /* Text('Corrigendum ' + (index+1).toString(),
                            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                          Text(corriArray[index].split('#')[1].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 17),),*/
                          GestureDetector(
                            onTap: () {
                              /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WebViewInFlutter(url1: corriURL)));*/
                            },
                            child: Text(
                              'Corrigendum ' + (index + 1).toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WebViewInFlutter(url1: corriURL)));*/
                            },
                            child: Text(
                              corriArray[index].split('#')[1].toString(),
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ],
                      ))
                ],
              ));
        },
        separatorBuilder: (context, index) {
          return Divider();
        });
  }

  static void showDownloadProgress(received, total) {
    if (total != -1) {
      log.d((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  static Future<void> openPdf(
      BuildContext context, String fileUrl, String fileName) async {
    bool check = await checkconnection();
    if (check == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoConnection()));
    } else {
      launch(fileUrl);
    }
  }

  static Future<void> ackAlert(
      BuildContext context, String fileUrl, String fileName) async {
    if (Platform.isAndroid) {
      return showDialog(
          builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                height: 80,
                decoration: BoxDecoration(
                    color:
                    Colors.green, //new Color.fromRGBO(255, 0, 0, 0.0),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: 50,
                            onPressed: () {
                              TiUtilities.openPdf(
                                  context, fileUrl, fileName);
                            },
                            child: Column(
                              children: const <Widget>[
                                Icon(
                                  Icons.open_in_new,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                ),
                                Text(
                                  "Open",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                          ),
                          Container(
                            width: 1,
                            color: Colors.black,
                          ),
                          MaterialButton(
                            minWidth: 50,
                            onPressed: () async {
                              log.d('download pressed');
                              TiUtilities.download(
                                  fileUrl, fileName, context);
//                      setState(() {
//                        vis==true;
//                        index==-1;
//                      });
                            },
                            child: Column(
                              children: const <Widget>[
                                Icon(
                                  Icons.file_download,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                ),
                                Text(
                                  "Download",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ])),
          ),
          barrierDismissible: false,
          context: context);
    } else {
      TiUtilities.openPdf(context, fileUrl, fileName);
    }
  }

  static void download(
      String fileurl, String filename, BuildContext context) async {
    try {
      var input = filename + "#" + fileurl;
      log.d(context.toString());
      var downloadinp = <String, String>{"input": input};
      var res = await platform.invokeMethod("download", downloadinp);

      log.d("res download = " + res.toString());
    } on PlatformException catch (e) {
      log.d("Failed to get data from native : '${e.message}'.");
    }
  }

  static Future<bool> checkconnection() async {
    var connectivityresult;
    try {
      connectivityresult =
      await InternetAddress.lookup('tiapp.indianrail.gov.in');
      if (connectivityresult != null) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      log.d('internet not available');
      return false;
      //_scaffoldkey.currentState.showSnackBar(snackbar1);
    }
  }

  static Future<void> pushPage(
      BuildContext context, Widget Function() createPage) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return createPage();
    }));
  }

  static Future<void> pushPageWithNetworkCheck(
      BuildContext context, Widget Function() createPage) async {
    bool check = await checkconnection();
    if (check == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoConnection()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return createPage();
      }));
    }
  }

  static Future<void> pushNamedPage(
      BuildContext context, String namedPage) async {
    bool check = await checkconnection();
    if (check == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoConnection()));
    } else {
      log.d('pushNamedPage called $namedPage');
      Navigator.of(context).pushNamed(namedPage);
    }
  }

  static String convertStringToUTF8(String source) {
    String out;
    final latin1 = Latin1Codec();
    out = String.fromCharCodes(
        latin1.encode(String.fromCharCodes(utf8.encode(source))));
    return out;
  }

  static String convertUTF8ToString(String source) {
    String out;
    final latin1 = Latin1Codec();
    String temp = latin1.decode(Uint8List.fromList(source.codeUnits));
    out = utf8.decode(Uint8List.fromList(temp.codeUnits));
    out = Utf8Decoder().convert(Uint8List.fromList(out.codeUnits));
    return out;
  }

  static void callLogoutAction(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return customAlertDialog(context,
            "Press OK, if you want to LOGOUT from चालक दल (tiapp)?", true);
      },
    ).then((val) {
      log.d('avinesh');
      log.d(val);
      if (val) {
        LoginBl.logOut().then((logOutResult) {
          log.d('avinesh--$logOutResult');
          if (logOutResult == 'LOG_OUT_SUCCESS') {
            //ChalakdalUtilities.pushPage(context, () => AppHomePageForm());
            TiUtilities.pushPage(context, () => AppHome());
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/user_home', (Route<dynamic> route) => false);
          }
        });
      } else {}
    });
  }

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.teal,
                  children: <Widget>[
                    Center(
                      child: Column(children: const [
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    )
                  ]));
        });
  }

  static Future<ExistingInspListModel> CheckInspMstr() async{

    ExistingInspListModel Existinginspmstr = new ExistingInspListModel(false,TiUtilities.user.loginid,"0",[],[],[],[],[],[]);

    try {
      print("CheckInspMstr");

      Map<String, dynamic> urlinput = {
        "status": 0,
        "userid": TiUtilities.user.loginid,
        "inspcont":"" ,
        "startDates" : [],
        "locations": [],
        "gpslocations":[],
        "examtype":[],
        "inspIDs": [],
        "cinsplist":[]
      };

      //log.d(user.roleid);
      //log.d('Role Id in LoginBloc ' + user.roleid);
      print("INMyInspMstrCheck2");

      String urlInputString = json.encode(urlinput);

      log.d("urlInputStringLogin = " + urlInputString);
      var url= TiConstants.webServiceUrl +'CheckInspMstr';
      final response = await http.post(Uri.parse(
          url),
          headers: TiConstants.headerInput,
          body: urlInputString,
          encoding: Encoding.getByName("utf-8"));

      print('jsonRes' + response.body);

      var jsonResult = json.decode(response.body);

      log.d("json result = " + jsonResult.toString());
      log.d("response code = " + response.statusCode.toString());

      if (response.statusCode == 200) {
        print("Response200");

        Existinginspmstr = ExistingInspListModel(
              jsonResult['status'],
              jsonResult['userid'].toString(),
              jsonResult['inspcont'].toString(),
              jsonResult['startDates'],
              jsonResult['locations'],
              jsonResult['gpslocations'],
              jsonResult['examtype'],
              jsonResult['inspIDs'],
              jsonResult['cinsplist']
          );

      }
    }catch (e) {
      print("In exixtingUser Catch :" + e.toString());
      return Existinginspmstr;
    }
    return Existinginspmstr;

  }

  static Future<String> CreateInspMstr(
       String GPSStartLoc, String UserStartLoc, String InspType) async {

    InspMstrModel inspmstr;
    String inspmstrResult;

    try {

      print("INMyLogin" + GPSStartLoc + "  " + UserStartLoc + "  " + InspType);
      InspMstrModel inspmstrmodel;

      Map<String, dynamic> urlinput = {
        "status": 0,
        "inspid": "",
        "userid": TiUtilities.user.loginid,
        "examtype": InspType,
        "strttime": "",
        "endtime": "",
        "inspgpsstrtlocn": GPSStartLoc,
        "inspgpsendlocn": "",
        "inspuserstrtlocn": UserStartLoc,
        "inspuserendlocn": "",
        "footplactlocn": "",
        "examcmpl": "",
        "inspmstrexist":"",
        "cinsplist":"",
        "inspcont":""
      };

      //log.d(user.roleid);
      //log.d('Role Id in LoginBloc ' + user.roleid);
      print("INMyInspMstrCreation2");

      String urlInputString = json.encode(urlinput);

      log.d("urlInputStringLogin = " + urlInputString);
      var url= TiConstants.webServiceUrl +'CreateInspMstr';
      final response = await http.post(Uri.parse(
           url),
          headers: TiConstants.headerInput,
          body: urlInputString,
          encoding: Encoding.getByName("utf-8"));

      print('jsonRes' + response.body);

      var jsonResult = json.decode(response.body);

      print("Jsonresult:" + jsonResult['inspMstr']['inspid']);

      log.d("json result = " + jsonResult.toString());
      log.d("response code = " + response.statusCode.toString());

      if (response.statusCode == 200) {
        print("Response200");

        inspmstr = InspMstrModel(
            jsonResult['inspMstr']['status'],
            jsonResult['inspMstr']['inspid'].toString(),
            jsonResult['inspMstr']['userid'].toString(),
            jsonResult['inspMstr']['examtype'].toString(),
            jsonResult['inspMstr']['strttime'].toString(),
            jsonResult['inspMstr']['endtime'].toString(),
            jsonResult['inspMstr']['inspgpsstrtlocn'].toString(),
            jsonResult['inspMstr']['inspgpsendlocn'].toString(),
            jsonResult['inspMstr']['inspuserstrtlocn'].toString(),
            jsonResult['inspMstr']['inspuserendlocn'].toString(),
            jsonResult['inspMstr']['footplactlocn'].toString(),
            jsonResult['inspMstr']['examcmpl'].toString(),
            jsonResult['inspMstr']['inspmstrexist'].toString(),
            jsonResult['inspMstr']['cinsplist'].toString(),
            jsonResult['inspMstr']['inspcont'].toString()
        );

        setInspMstr(inspmstr);
        inspmstrResult = 'INSP_MSTR_SUCCESS';

      }
    }catch (e) {
      inspmstrResult = 'INSP_MSTR_CREATION_FAILURE';
    }
    return inspmstrResult;
  }

  static void setTiUser(TiUser param) {
    user = TiUser(param.loginid, param.fname, param.authlevel,
        param.designation, param.rlycode, param.roleid, param.loginFlag);
  }

  static void setInspMstr(InspMstrModel param) {
  inspmstr = InspMstrModel(param.status,
      param.inspid,
      param.userid,
      param.examtype,
      param.strttime,
      param.endtime ,
      param.inspgpsstrtlocn ,
      param.inspgpsendlocn  ,
      param.inspuserstrtlocn,
      param.inspuserendlocn ,
      param.footplactlocn   ,
      param.examcmpl,
      param.inspmstrexist,
      param.cinsplist,
      param.inspcont
  );
  }
}

class TiUser {
  String loginid, fname, authlevel, designation, rlycode, roleid, loginFlag;
  TiUser(this.loginid, this.fname, this.authlevel, this.designation,
      this.rlycode, this.roleid, this.loginFlag);
}


class dropdowncls extends StatefulWidget {

  List<String> slst ;
  List ynlst ;
  List whyNolst ;

  int index ;

  List<String> selectedItem ;

  List<TextEditingController> whyNoCont;

  List<bool> showTextField ;

  final Function dropdowntextcallback;

  String regiType = "" ;

  dropdowncls({Key key ,this.dropdowntextcallback ,this.slst ,this.ynlst ,this.index ,this.selectedItem ,this.showTextField,this.whyNoCont,this.whyNolst ,this.regiType}) : super(key: key);

  @override
  _dropdownclsState createState() => _dropdownclsState();
}

class _dropdownclsState extends State<dropdowncls> {


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          onTap: () {
            return FocusManager.instance.primaryFocus
                ?.unfocus();
            //CautionOrdRegModel.postData(data);
          },

          title: Text(
                      (() {
                      // your code here
                      if(widget.regiType == 'cautOrdListlang') return S.of(context).cautOrdListlang(widget.slst[widget.index]);
                      if(widget.regiType == 'trnSgnlFaillang') return S.of(context).trnSgnlFaillang(widget.slst[widget.index]);
                      if(widget.regiType == 'sgnlFaillang') return S.of(context).sgnlFaillang(widget.slst[widget.index]);

                      return widget.slst[widget.index];
                      }()),
           // widget.slst[widget.index],
            style: TextStyle(
                fontSize: 14
            ),),
          trailing: SizedBox(
            width: 100,

            child:  DropdownButtonFormField(
              decoration: const InputDecoration(

                enabledBorder: OutlineInputBorder(
                  //borderRadius : const BorderRadius.all(Radius.circular(4.0)),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
              ),
              value: widget.selectedItem[widget.index].toString(),
              items:  _dropDownItem(),
              onChanged: (newSelectedValue) {
                // setState(() async {
                widget.selectedItem[widget.index] =
                    newSelectedValue.toString();
                widget.ynlst[widget.index] = newSelectedValue.toString();
                print("TrnSgnlFailureModdddd.:" + widget.index.toString() + widget.ynlst[widget.index]);
                if(newSelectedValue.toString() == 'NO'){
                  widget.showTextField[widget.index] = true;
                  print("_showTextField:"  + widget.showTextField[widget.index].toString());
                  //show = true;
                }
                else{
                  widget.whyNolst[widget.index] = '';
                  widget.whyNoCont[widget.index].text = '';
                  widget.showTextField[widget.index] = false;

                  print("_showTextField:" + widget.showTextField[widget.index].toString() );

                }
                widget.dropdowntextcallback(widget.whyNoCont ,widget.selectedItem, widget.showTextField);
                // });

              },

            ),
          ),
        ),
        Visibility(
            visible: widget.showTextField[widget.index],
            child: Container(
              child: SizedBox(
                //width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: widget.whyNoCont[widget.index],

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[0-9a-zA-Z ]"))
                    ],
                    onChanged: (newValue) {
                      // setState(() async {

                      widget.whyNolst[widget.index] = newValue.toString();
                      widget.dropdowntextcallback(widget.whyNoCont ,widget.selectedItem, widget.showTextField);
                      },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Please mention Reason',
                      labelStyle: TextStyle(
                          fontSize: 12,
                           color: Colors.black45
                      ),

                      alignLabelWithHint: true,
                     // errorText: isReasonEmpty[widget.index] ? 'Please enter a Username' : null

                      //suffixIcon: Padding( padding: const EdgeInsets.fromLTRB(10, 20, 20, 90),
                      //  child: Icon(
                      //   Icons.speaker_notes_rounded,
                      //  color: Colors.teal,
                      //  ),
                      //          )
                    ),
                    validator: (String value){
                      if(value.isEmpty){
                         return "Please Enter the reason";
                      }
                      return null;

                    },
                    onSaved: (String reason){
                      print("Onsaved");
                    },
                  ),
                ),
              ),
            )
        ),
      ],
    );
  }

  static List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = ["NO", "YES"];
    return ddl
        .map((value) => DropdownMenuItem(
      value: value,
      child: Text(value),
    ))
        .toList();
  }
}
