import 'package:logger/logger.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:ti/commonutils/ti_utilities.dart';

import 'package:ti/commonutils/navigation_menue.dart';
import 'package:ti/commonutils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/pages/SttnInsp/sttn_inspection.dart';
import 'package:ti/pages/SttnInsp/sttnPosition.dart';
import 'package:ti/screens/user_profile.dart';
import 'package:ti/screens/TILocation.dart';

class UserHomePageForm extends StatefulWidget {
  @override
  _UserHomePageFormState createState() => _UserHomePageFormState();
}

class _UserHomePageFormState extends State<UserHomePageForm> with SingleTickerProviderStateMixin{
  final log = getLogger('UserHomePageForm');

  Animation<Color> animation;
  AnimationController controller;

  Key key;
  final GlobalKey<ScaffoldState> _userHomeScaffoldKey =
  GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  double width, height;
  bool _isVisible = false;
  bool _isBlinkVisible = false;
  var CheckInspMstrResult;
  //CrewAvailabilityModel _availabilityModel = new CrewAvailabilityModel();
  var padding;

  @override
  void initState() {
    //requestForPermissions();
    TiUtilities.versionCheck(context, true);
    log.d("User-----");
    // log.d(TiUtilities.user.roleid + '===' + TiUtilities.user.authlevel);
    // if (TiUtilities.user.authlevel == 'TI')
    _isVisible = true;

    TiUtilities.CheckInspMstr().then((CheckInspMstrResult) {
      log.d('avinesh--CheckInspMstrResult:$CheckInspMstrResult');
      _isBlinkVisible = true;

      controller = AnimationController(
          duration: const Duration(milliseconds: 500), vsync: this);
      final CurvedAnimation curve =
      CurvedAnimation(parent: controller, curve: Curves.linear);
      animation =
          ColorTween(begin: Colors.white, end: Colors.blue).animate(curve);
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
        setState(() {});

      });
      controller.forward();

      setState(() {

      });

    });

    super.initState();
    //BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    controller.dispose();
    //BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    //log.d("BACK BUTTON!"); // Do some stuff.
    //_onBackButtonPressed();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    width = SizeConfig.screenWidth;
    height = SizeConfig.screenHeight;
    padding = MediaQuery.of(context).padding;

    return WillPopScope(
        onWillPop: () {
          NavigationMenue.onBackButtonPressed(context);
          return Future(() => false);
        },
        child: Scaffold(
          key: _userHomeScaffoldKey,
          resizeToAvoidBottomInset: false,

          body: ListView(
            children: <Widget>[
              //  if (TiUtilities.user.roleid == 'TI')
              TiHomeUI(context)

              // IrZoneDivLobbyHomeUi(context)

              //{loginid: MDLIENGG, fStationInspectionForm: DEPT ENGG USER, authlevel: ABNRUSER, rlycode: DLI, roleid: ENGG}}
              //{loginid: MDLIALL, fStationInspectionForm: ALL ABNORMALITY USER, authlevel: ABNRUSER, rlycode: DLI, roleid: ALL}}
            ],
          ),
          //////Bottom Navigation Bar//////////////
          //////Bottom Navigation Bar//////////////
          //bottomNavigationBar: NavigationMenue.bottomnavigationbar(context)
        ));
  }

//LI HOME
// {isSuccess: true, loginIfoVO: {loginid: RTM0037, fStationInspectionForm: S M RIZVI, designation: Chief Loco Inspector, rlycode: RTM , roleid: LI}}

  Widget TiHomeUI(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('Good Morning'), // Always visible
              if (_isBlinkVisible) Text(' Mr ABC'),
              Material(
                elevation: 8,
                child: Container(
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      gradient: LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.orange,
                            Colors.indigo
                          ]
                      )
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0
                    ),
                    onPressed: () {

                    },
                    child: Text('Blink Animation'),
                  ),
                ),
              ),// Only visible if condition is true
            ],
          ),

          SingleChildScrollView(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 2, color: Colors.orange),
              ),
              shadowColor: Colors.teal,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(5.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                      Container(
                        height: height / 5,
                        width: width / 5,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      child: Image.asset(
                                        'assets/counselling_icon.webp',
                                        width: 35,
                                        height: 35,
                                        color: Colors.orange,
                                      )),
                                  Padding(padding: EdgeInsets.all(5.0)),
                                  Container(
                                    child: Text(
                                      'Station \n Inspection',
                                      style:
                                      Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                bool check =
                                true; //await TiUtilities.checkconnection();
                                if (!check)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Container()));
                                else {

                                  log.d('avinesh--InElse CheckInspMstrResult:$CheckInspMstrResult');

                                  if (CheckInspMstrResult == 'INSP_MSTR_CHECK_FAILURE') {
                                    TiUtilities.showOKDialog(context, CheckInspMstrResult);

                                  } else if(CheckInspMstrResult == 'EXIST'){
                                    log.d('In else if');

                                    TiUtilities.pushPage(context, () => SttnInspection());

                                  }else{
                                    TiUtilities.pushPage(context, () => TILocation());
                                  }


                                  // TiUtilities.pushPage(
                                  //     context, () => SttnPosition());
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: height / 5,
                        width: width / 5,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      child: Image.asset(
                                        'assets/grading_icon.webp',
                                        width: 30,
                                        height: 30,
                                        color: Colors.orange,
                                      )),
                                  Padding(padding: EdgeInsets.all(5.0)),
                                  Container(
                                    child: Text('Night\n Inspection',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                /*_userHomeScaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Presently there is no auction scheduled!"),duration: const Duration(seconds: 1),
                                            backgroundColor: Colors.redAccent[100],));*/
                                TiUtilities.pushPage(
                                    context, () => NightInscpectionForm());
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height / 5,
                        width: width / 5,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      child: Image.asset(
                                        'assets/abnormality_icon.webp',
                                        width: 40,
                                        height: 40,
                                        color: Colors.orange,
                                      )),
                                  Padding(padding: EdgeInsets.all(5.0)),
                                  Container(
                                    child: Text('Casual \n Inspection',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                TiUtilities.pushPage(
                                    context, () => CasualInspection());
                                /*_userHomeScaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Presently there is no auction scheduled!"),duration: const Duration(seconds: 1),
                                            backgroundColor: Colors.redAccent[100],));*/
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 2, color: Colors.orange),
            ),
            shadowColor: Colors.teal,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5.0)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: height / 5,
                      width: width / 5,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Image.asset(
                                      'assets/limovement_icon.png',
                                      width: 30,
                                      height: 30,
                                      color: Colors.orange,
                                    )),
                                Padding(padding: EdgeInsets.all(5.0)),
                                Container(
                                  child: Text('Gate\nInspection',
                                      style:
                                      Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            onTap: () async {
                              log.d("calling to functn");
                              TiUtilities.pushPage(
                                  context, () => GateInspection());
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height / 5,
                      width: width / 5,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Image.asset(
                                      'assets/footplate_icon.png',
                                      width: 30,
                                      height: 30,
                                      color: Colors.orange,
                                    )),
                                Padding(padding: EdgeInsets.all(5.0)),
                                Container(
                                  child: Text('Footplate\n Inspection',
                                      style:
                                      Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            onTap: () {
                              TiUtilities.pushPage(
                                  context, () => TiFootplateInspection());
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height / 5,
                      width: width / 5,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Image.asset(
                                      'assets/lpattributes_icon.png',
                                      width: 30,
                                      height: 30,
                                      color: Colors.orange,
                                    )),
                                Padding(padding: EdgeInsets.all(5.0)),
                                Container(
                                  child: Text('Ambush \n Check',
                                      style:
                                      Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            onTap: () async {
                              log.d("calling tp functn");
                              TiUtilities.pushPage(
                                  context, () => TiAmbushCheck());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 2, color: Colors.orange),
            ),
            shadowColor: Colors.teal,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5.0)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: height / 5,
                      width: width / 5,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Image.asset(
                                      'assets/edoc_home.png',
                                      width: 30,
                                      height: 30,
                                    )),
                                Padding(padding: EdgeInsets.all(5.0)),
                                Container(
                                  child: Text('MIS\n Reports',
                                      style:
                                      Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            onTap: () async {
                              TiUtilities.pushPage(context, () => MisReports());
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height / 5,
                      width: width / 5,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Image.asset(
                                      'assets/banned_firms.png',
                                      width: 30,
                                      height: 30,
                                    )),
                                Padding(padding: EdgeInsets.all(5.0)),
                                Container(
                                  child: Text('user\n Profile',
                                      style:
                                      Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                            onTap: () async {
                              TiUtilities.pushPage(
                                  context, () => user_profiledetails());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showInputDialog(BuildContext context, String suburbanOrMainline) {
    TextEditingController toSttnController = TextEditingController();
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return //new _SystemPadding(child:
          AlertDialog(
            title: Text(
              'Enter SignOff ',
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    style: TextStyle(fontSize: 14),
                    controller: toSttnController,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                    ],
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'SignOff ', hintText: 'eg. NDLS'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context, 'CANCEL');
                  }),
              FlatButton(
                  child: const Text('SAVE'),
                  onPressed: () {
                    /* CrewSignOnOffBl.callSaveSignOffStationWebService(
                          toSttnController.text, suburbanOrMainline)
                      .then((resultMsg) {
                    log.d('avinesh--$resultMsg');
                    Navigator.pop(context, resultMsg);
                  }); */
                  })
            ],
            // ),
          );
      },
    ).then((val) {
      if (val != 'CANCEL') TiUtilities.showOKDialog(context, val);
    });
  }

  Future<void> requestForPermissions() async {
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.locationWhenInUse,
    //   Permission.storage,
    // ].request();
    //  final status = statuses[Permission.locationWhenInUse];
    //final status = await permission.request();
    // log.d(status.toString());
  }
}

class StationInspectionForm extends StatefulWidget {
  StationInspectionForm({Key key}) : super(key: key);

  @override
  _StationInspectionFormState createState() => _StationInspectionFormState();
}

class _StationInspectionFormState extends State<StationInspectionForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NightInscpectionForm extends StatefulWidget {
  NightInscpectionForm({Key key}) : super(key: key);

  @override
  _NightInscpectionFormState createState() => _NightInscpectionFormState();
}

class _NightInscpectionFormState extends State<NightInscpectionForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CasualInspection extends StatefulWidget {
  CasualInspection({Key key}) : super(key: key);

  @override
  _CasualInspectionState createState() => _CasualInspectionState();
}

class _CasualInspectionState extends State<CasualInspection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TiFootplateInspection extends StatefulWidget {
  TiFootplateInspection({Key key}) : super(key: key);

  @override
  _TiFootplateInspectionState createState() => _TiFootplateInspectionState();
}

class _TiFootplateInspectionState extends State<TiFootplateInspection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TiAmbushCheck extends StatefulWidget {
  TiAmbushCheck({Key key}) : super(key: key);

  @override
  _TiAmbushCheckState createState() => _TiAmbushCheckState();
}

class _TiAmbushCheckState extends State<TiAmbushCheck> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MisReports extends StatefulWidget {
  MisReports({Key key}) : super(key: key);

  @override
  _MisReportsState createState() => _MisReportsState();
}

class _MisReportsState extends State<MisReports> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GateInspection extends StatefulWidget {
  GateInspection({Key key}) : super(key: key);

  @override
  _GateInspectionState createState() => _GateInspectionState();
}

class _GateInspectionState extends State<GateInspection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;
  _SystemPadding({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      //padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
