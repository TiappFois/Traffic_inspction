import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:ti/commonutils/mydatetime_picker.dart';
import 'package:ti/commonutils/size_config.dart';
import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/model/profileModel.dart';
import 'package:http/http.dart' as http;

class user_profiledetails extends StatefulWidget {
  // String userId;

  const user_profiledetails({Key key}) : super(key: key);

  @override
  _user_profiledetailsState createState() => _user_profiledetailsState();
}

class _user_profiledetailsState extends State<user_profiledetails> {
  final log = getLogger('user_profiledetails');
  var jsonResultList;

  String userId,

      userName,
      userMobile,
      userMailid,
      userDOB,
      userDOA,
      userDOJ,
      userHQ,
      userDvsn,
      userSection,
      userDesignation;
  ProfileModel profile = new ProfileModel();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedValue = "Select";
  TextEditingController usernameController = TextEditingController();
  TextEditingController usermobileController = TextEditingController();
  TextEditingController usermailIdController = TextEditingController();
  TextEditingController userDOBController = TextEditingController();
  TextEditingController userDOAController = TextEditingController();
  TextEditingController userDOJController = TextEditingController();
  TextEditingController userHQController = TextEditingController();
  TextEditingController userDvsnController = TextEditingController();

  TextEditingController userSectionController = TextEditingController();
  TextEditingController userDesignationController = TextEditingController();
  //TextEditingController systemTimeController = TextEditingController();
  double width, height, font, headingFont, homeIconAlign;
  var padding;
    //final date = FocusNode();
  final userNameControllerFocus = FocusNode();
  final userMobileControllerFocus = FocusNode();
  final usermailControllerFocus = FocusNode();
  final userDOBControllerFocus = FocusNode();
  final userDOAControllerFocus = FocusNode();
  final userDOJControllerFocus = FocusNode();

  final userHQControllerFocus = FocusNode();
  final userDvsnControllerFocus = FocusNode();
  final userSectionControllerFocus = FocusNode();
  final userDesignationControllerFocus = FocusNode();
  final regenStartControllerFocus = FocusNode();

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _loading = false;

  List<String> zoneList = [
    'Select',
    'CR',
    'ER',
    'EC',
    'ECO',
    'NC',
    'NE',
    'NF',
    'NR',
    'NW',
    'SC',
    'SE',
    'SEC',
    'SEC',
    'SR',
    'SW',
    'WC',
    'WR'
  ];
  List<String> zoneSubheadList = ['Select'];

  List<String> onZoneHeadChange(String zone) {
    log.d('onZoneHeadChange called $zone');
    List<String> list;
    if (zone == 'Select') {
      list = ['Select'];
    } else if (zone == 'CR') {
      list = ['Select', 'SUR', 'BSL', 'PUNE', 'BB', 'NGP'];
    } else if (zone == 'EC') {
      list = ['Select', 'DHN', 'SEE', 'SPJ', 'DNR'];
    } else if (zone == 'ER') {
      list = ['Select', 'SDAH', 'HWH', 'ASN', 'MLDT'];
    } else if (zone == 'NC') {
      list = ['Select', 'AGRA', 'ALD', 'JHS'];
    } else if (zone == 'NE') {
      list = ['Select', 'BSB', 'LJN', 'IZN'];
    } else if (zone == 'NF') {
      list = ['Select', 'LMG', 'RNY', 'APDJ', 'KIR'];
    } else if (zone == 'NR') {
      list = ['Select', 'DLI', 'MB', 'UMB', 'LKO', 'FZR'];
    } else if (zone == 'NW') {
      list = ['Select', 'BKN', 'JU', 'AII', 'GZB', 'JP'];
    } else if (zone == 'SE') {
      list = ['Select', 'CKP', 'KGP', 'ADRA', 'RNC'];
    } else if (zone == 'SC') {
      list = ['Select', 'HYB', 'GNT', 'BZA', 'SC', 'NED', 'GTL'];
    } else if (zone == 'SEC') {
      list = ['Select', 'BSP', 'NAG', 'R'];
    } else if (zone == 'SR') {
      list = [
        'Select',
        'DA',
        'PGT',
        'MDU',
        'TVC',
        'MAS',
        'TPG',
      ];
    } else if (zone == 'SW') {
      list = [
        'Select',
        'SBC',
        'UBL',
        'MYS',
      ];
    } else if (zone == 'WC') {
      list = [
        'Select',
        'BPL',
        'KOTA',
        'JBP',
      ];
    } else if (zone == 'WR') {
      list = ['Select', 'BRC', 'BVC', 'ADI', 'RTM', 'RJT', 'BCT'];
    } else if (zone == 'ER') {
      list = ['Select', 'ASN', 'HWH'];
    } else {
      list = ['Select'];
    }
    return list;
  }

  @override
  void initState() {
    log.d("RAJESH initState1");

    super.initState();
    log.d("RAJESH initState3");

    setState(() {
      //zoneSubheadList = onZoneHeadChange(profile.userHQ);
     // log.d("RAJESH initState1" + zoneSubheadList.toString());

      //List<String> onZoneHeadChange(String zone)
      log.d("RAJESH initState3");

      getProfileData();
      log.d("RAJESH initState4");
    });
  }

  @override
  _onClear() {
    setState(() {
      _formKey.currentState.reset();
      _autoValidate = AutovalidateMode.disabled;
      usernameController.text = "";
      usermobileController.text = "";
      usermailIdController.text = "";
     // userDOAController.text = "";
      //userDOJController.text = "";
     // userDOBController.text = "";
      userHQController.text = "";
      userDvsnController.text = "";
      userSectionController.text = "";
     // userDesignationController.text = "";
    });
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }

  void dispose() {
    super.dispose();
    usernameController.dispose();
    usermobileController.dispose();
    usermailIdController.dispose();
    userDOAController.dispose();
    userDOJController.dispose();
    userDOBController.dispose();
    userHQController.dispose();
    userDvsnController.dispose();
    userSectionController.dispose();
    userDesignationController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 8),
        lastDate: DateTime(2022));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    width = SizeConfig.screenWidth;
    height = SizeConfig.screenHeight;
    padding = MediaQuery.of(context).padding;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    if (MediaQuery.of(context).orientation.toString() ==
        'Orientation.landscape') {
      font = 14;
      headingFont = font * 1.2;
    } else {
      font = 14;
      headingFont = font * 1.2;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      appBar: TiUtilities.tiAppBar(
          context, "User Profile  (" + TiUtilities.user.loginid + ')'),
      body: Builder(
          builder: (context) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: Container(
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate,
                  child: _loading
                      ? SizedBox(
                    height: height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : FormUI(context),
                ),
              ),
            ),
          )),
    );
  }

  Widget FormUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(0)),
        Text(
          "Name",
          style: new TextStyle(color: Colors.teal, fontSize: 10),
          textAlign: TextAlign.end,
        ),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              //height: 50,
              width: 50.0,
              child: TextFormField(

                // maxLength: 50,
                style: TextStyle(fontSize: font),
                controller: usernameController,

                textCapitalization: TextCapitalization.characters,
                // readOnly: true,
                validator: (String value){
                  if(value.isEmpty)
                    return "Please Enter Your Name";

                  if (value.length < 3)
                    return 'Name must be more than 2 charater';

                  return null;

                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  LengthLimitingTextInputFormatter(20),
                ],

                onSaved: (String val) {
                  profile.userName = val;
                },
                //controller: myController,

                //maxLength: 25,
                //maxLengthEnforced: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Your Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter Your Name',

                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: font,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              ////height: 50,
              width: 50.0,
              child: TextFormField(
                //maxLength: 50,
                style: TextStyle(fontSize: font),
                controller: usermobileController,
                // readOnly: true,
                validator: (String value){
                  //if(value.isEmpty)
                   // return "Please Enter Your Name";

                  if (value.length < 10)
                    return 'Please Enter Valid Mobile Number';

                  return null;

                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.phone,
                onSaved: (String val) {
                  profile.userMobile = val;
                },
                //controller: myController,

                //maxLength: 25,
                //maxLengthEnforced: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Your Mobile',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter Mobile No.',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: font,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              ////height: 50,
              width: 50.0,
              child: TextFormField(
                // maxLength: 50,
                style: TextStyle(fontSize: font),
                controller: userDesignationController,
                // readOnly: true,
                validator: (String value){
                  if(value.isEmpty)
                    return "Please Enter Your Designation";

                  //if (value.length < 3)
                   // return 'Name must be more than 2 charater';

                  return null;

                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  LengthLimitingTextInputFormatter(20),
                ],

                onSaved: (String val) {
                  profile.userDesignation = val;
                },
                //controller: myController,

                //maxLength: 25,
                //maxLengthEnforced: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Your Designation',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter Your Designation',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: font,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // SizedBox(width: 10.0),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              //height: 50,
              width: 50.0,
              child: TextFormField(
                style: TextStyle(fontSize: font),
                controller: usermailIdController,
                // readOnly: true,
                validator: (String value){
                  Pattern pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      r"{0,253}[a-zA-Z0-9])?)*$";
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(value) || value == null)
                    return 'Enter a valid email address';
                  else
                    return null;

                },
                inputFormatters: [

                  LengthLimitingTextInputFormatter(20),
                ],

                onSaved: (String val) {
                  profile.userMailid = val;
                },
                keyboardType: TextInputType.emailAddress,
                //controller: myController,

                //maxLength: 25,
                //maxLengthEnforced: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Your Mailid',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter Your Mailid',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: font,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          //SizedBox(width: 10.0),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              //height: 50,
              width: 50.0,
              child: TextFormField(
                style: TextStyle(fontSize: font),
                controller: userDOBController,
                focusNode: userDOBControllerFocus,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                // readOnly: true,
                validator: (String value){
                  if(value.isEmpty)
                    return "Please Enter Your D.O.B";

                  //if (value.length < 3)
                  // return 'Name must be more than 2 charater';

                  return null;

                },

                onSaved: (String val) {
                  profile.userDOB = val;
                },
                //controller: myController,

                //maxLength: 25,
                //maxLengthEnforced: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: TextStyle(height: 0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      size: 30,
                      color: Colors.teal,
                    ),
                    onPressed: () async {
                      userDOBController.text =
                      await MyDateTimePicker.myDatePicker(context);
                      FocusScope.of(context)
                          .requestFocus(userDOJControllerFocus);
                    },
                  ),
                  contentPadding: new EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Select DOB ',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Date of Birth',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: headingFont,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          //  SizedBox(width: 10.0),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              //height: 50,
              width: 50.0,
              child: TextFormField(
                style: TextStyle(fontSize: font),
                controller: userDOJController,
                focusNode: userDOJControllerFocus,
                readOnly: true,
                keyboardType: TextInputType.datetime,

                validator: (String value){
                  if(value.isEmpty)
                    return "Please Enter Your Joining Date";

                  //if (value.length < 3)
                  // return 'Name must be more than 2 charater';

                  return null;

                },
                onSaved: (String val) {
                  profile.userDOJ = val;
                },
                //controller: myController,

                //maxLength: 25,
                //maxLengthEnforced: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: TextStyle(height: 0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      size: 30,
                      color: Colors.teal,
                    ),
                    onPressed: () async {
                      userDOJController.text =
                      await MyDateTimePicker.myDatePicker(context);
                      FocusScope.of(context)
                          .requestFocus(userDOJControllerFocus);
                    },
                  ),
                  contentPadding: new EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Select DOJ ',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Joing Date',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: headingFont,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              //height: 50,
              width: 50.0,
              child: TextFormField(
                style: TextStyle(fontSize: font),
                controller: userDOAController,
                focusNode: userDOAControllerFocus,
                keyboardType: TextInputType.datetime,
                readOnly: true,

                validator: (String value){
                  if(value.isEmpty)
                    return "Please Enter Your Appointment Date";

                  //if (value.length < 3)
                  // return 'Name must be more than 2 charater';

                  return null;

                },
                onSaved: (String val) {
                  profile.userDOA = val;
                },
                //controller: myController,

                //maxLength: 25,
                //maxLengthEnforced: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: TextStyle(height: 0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      size: 30,
                      color: Colors.teal,
                    ),
                    onPressed: () async {
                      userDOAController.text =
                      await MyDateTimePicker.myDatePicker(context);
                      FocusScope.of(context)
                          .requestFocus(userDOAControllerFocus);
                    },
                  ),
                  contentPadding: new EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Select DOA ',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Appointment Date',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: headingFont,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              //height: 50,
              width: 50.0,
              child: DropdownButtonFormField(
                //  maxLength: 50,
                isDense: true,
                isExpanded: true,
                style: TextStyle(fontSize: font),
                validator: (args) {
                  if (args == null || args == 'Select') {
                    return '';
                  }
                },
                // readOnly: true,

                onSaved: (String val) {
                  log.d("inside call of HQ");
                   profile.userHQ = val;
                },
                //controller: myController,
                //maxLength: 25,
                //maxLengthEnforced: true,
                // textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Select  HQ',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter HQ Name',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: headingFont,
                      fontWeight: FontWeight.bold),
                ),
                items: zoneList.map((String item) {
                  return new DropdownMenuItem<String>(
                      child: Text(item,
                          style: new TextStyle(
                              color: Colors.teal, fontSize: font)),
                      value: item);
                }).toList(),
                value: userHQ,
                onChanged: (newValue) {
                  log.d('nm' + newValue);
                  setState(() {
                    profile.userHQ = newValue;
                    // _reportAbnormalityModel.abnormalityHead = newValue;
                    // _reportAbnormalityModel.abnormalitySubhead = "Select";
                    zoneSubheadList = onZoneHeadChange(newValue);
                    userDvsn = 'Select' ;
                    log.d("zoneSubheadList" + zoneSubheadList.toString());
                    //  _isButtonDisabled = true;
                  });
                },
              ),
            ),
          ),
          //SizedBox(width: 10.0),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              //height: 50,
              width: 50.0,
              child: DropdownButtonFormField(
                isDense: true,
                isExpanded: true,
                validator: (args) {
                  if (args == null || args == 'Select') {
                    return '';
                  }
                },
            onSaved: (String val) {
            log.d("inside call of userDvsn"+val);
            profile.userDvsn = val;
            },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Your Divsion',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter Divsion Code',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: font,
                      fontWeight: FontWeight.bold),
                ),
                items: zoneSubheadList.map((String item) {
                  return new DropdownMenuItem<String>(
                      child: Text(item,
                          style: new TextStyle(
                              color: Colors.teal, fontSize: font)),
                      value: item);
                }).toList(),
                value: userDvsn,
                onChanged: (newValue) {
                  log.d('Divsion selected  value :' + newValue);
                  setState(() {
                          userDvsn = newValue; // _reportAbnormalityModel.abnormalitySubhead = newValue;
                          profile.userDvsn = newValue;
                  });
                },
              ),
            ),
          ),
          // SizedBox(width: 10.0),
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          Expanded(
            child: Container(
              //height: 50,
              width: 50.0,
              child: TextFormField(
                //   maxLength: 50,
                style: TextStyle(fontSize: 10),
                controller: userSectionController,
                validator: (String value){
                  if(value.isEmpty)
                    return "Please Enter the Section";

                  if (value.length < 3)
                   return 'Section must be more than 2 charater';

                  return null;

                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  LengthLimitingTextInputFormatter(10),
                ],
                onSaved: (String val) {
                  log.d("Section on saved called :"+val);
                  profile.userSection = val;
                    log.d("Section on saved called :"+ profile.userSection);
                },
                //controller: myController,

                //maxLength: 25,
                //maxLengthEnforced: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 5, 2, 5),
                  filled: true,
                  hintText: 'Your Section',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Enter Section Name',
                  labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: font,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // SizedBox(width: 10.0),
        ]),
        SizedBox(height: 10.0),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  //elevation: 4,
                  //color: Colors.green,
                  minWidth: width / 3,
                  child: MaterialButton(
                    onPressed: () => _onClear(),
                    textColor: Colors.white,
                    color: Colors.teal,
                    child: Text(
                      "Reset",
                      style: TextStyle(
                          fontSize: font, fontWeight: FontWeight.bold),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: width / 3,
                  child: MaterialButton(
                    onPressed: () async {
                      log.d(DateFormat('dd-MM-yyyy HH:mm')
                          .format(DateTime.now()));

                      _formKey.currentState.save();

                      if (_formKey.currentState.validate()) {
                        setProfileData().then((res) {
                          log.d("res+"+res.toString());
                          if (res == "Record Successfully Saved.") {
                            print('Record Successfully Saved.');
                            TiUtilities.showOKDialog(context, "User Profile Saved Successfully!!")
                                .then((res1) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/user_home', (Route<dynamic> route) => false);
                            });
                          } else {
                            print('Problem in Sign On. Please Contact to Supervisor');
                          }
                        });
                      }

                      //   _liFootplateRecordModel.liId =
                      // profile.userId = TiUtilities.user.loginid;
                      //   res = _callCounsellingWebService(counsellingModel);
                    },
                    textColor: Colors.white,
                    color: Colors.teal,
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize: font, fontWeight: FontWeight.bold),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<String> setProfileData() async {
    log.d('Inserting data  from service  CreateProfile');
    var url = TiConstants.webServiceUrl + 'CreateProfile';
    Map<String, dynamic> urlinput = {
      "userId": TiUtilities.user.loginid,
      "userName": profile.userName,
      "userMobile": profile.userMobile,
      "userMailid": profile.userMailid,
      "userDOA": profile.userDOA,
      "userDOJ": profile.userDOJ,
      "userDOB": profile.userDOB,
      "userHQ": profile.userHQ,
      "userDvsn": profile.userDvsn,
      "userSection": profile.userSection,
      "userDesignation": profile.userDesignation
    };
    String urlInputString = json.encode(urlinput);

    log.d("url setProfileData  = " + url);
    log.d("urlInputString setProfileData =  " + urlInputString);

    final responseSubmittedprofile = await http.post(Uri.parse(url),
        headers: TiConstants.headerInput,
        body: urlInputString,
        encoding: Encoding.getByName("utf-8"));


   // setState(() {
     // profile = ProfileModel.fromJson(jsonResultList);
      log.d("SINHA111S" + profile.userSection);
      log.d("SINHA111" + profile.userDvsn);
      log.d("responseSubmittedprofile.statusCode" + responseSubmittedprofile.statusCode.toString());

    if (responseSubmittedprofile == null || responseSubmittedprofile.statusCode != 200) {
      throw new Exception(
          'HTTP request failed, statusCode: ${responseSubmittedprofile?.statusCode}');
    } else {

      jsonResultList = json.decode(responseSubmittedprofile.body);
      //profile = ProfileModel.fromJson(jsonResultList);
      log.d("INTO SET STATE 111U1"+jsonResultList.toString());

      return 'Record Successfully Saved.';
    }


/*
      //userId = profile.userId == "" ? "NA" : profile.userId;
      userMobile = profile.userMobile == "" ? "NA" : profile.userMobile;
      userMailid = profile.userMailid == "" ? "NA" : profile.userMailid;
      userDOB = profile.userDOB == "" ? "NA" : profile.userDOB;
      userDOA = profile.userDOA == "" ? "NA" : profile.userDOA;
      userDOJ = profile.userDOJ == "" ? "NA" : profile.userDOJ;
      userHQ = profile.userHQ == "" ? "NA" : profile.userHQ;
      userDvsn = profile.userDvsn == "" ? "NA" : profile.userDvsn;
      userSection = profile.userSection == "" ? "NA" : profile.userSection;
      userDesignation = profile.userDesignation == "" ? "NA" : profile.userDesignation;  */

   // });
  }

  void getProfileData() async {
    log.d('Fetching from service getProfileData');
    log.d("urlInputString = " + TiUtilities.user.loginid);
    var url = TiConstants.webServiceUrl + 'getProfileData';
    Map<String, dynamic> urlinput = {"strUserid": TiUtilities.user.loginid};
    log.d("urlInputString  getProfileData = " + url);
    String urlInputString = json.encode(urlinput);

    log.d("url  getProfileData = " + url);
    log.d("urlInputString  getProfileData = " + urlInputString);

    final responseSubmittedprofile = await http.post(Uri.parse(url),
        headers: TiConstants.headerInput,
        body: urlInputString,
        encoding: Encoding.getByName("utf-8"));
    log.d("AFTER R  getProfileData WEBSERVICE = ");

    //jsonResult = json.decode(response.body);

    // log.d("json result = " + jsonResult.toString());
    //log.d("response code = " + jsonResult.statusCode);

    //final loginstatus = User.fromJson(jsonResult);
    setState(() {
      log.d("INTO SET STATE");

      jsonResultList = json.decode(responseSubmittedprofile.body);
      log.d("INTO SET STATE 1");

      profile = ProfileModel.fromJson(jsonResultList);
      log.d("SINHA" + profile.userDesignation);

      usernameController.text = profile.userName;
      //log.d("userMob *" + userMob.toString());

      usermobileController.text = profile.userMobile;
      usermailIdController.text = profile.userMailid;
      userDOAController.text = profile.userDOA;
      userDOJController.text = profile.userDOJ;
      userDOBController.text = profile.userDOB;
      userHQController.text = profile.userHQ;

      userHQ = profile.userHQ;

      zoneSubheadList = onZoneHeadChange(profile.userHQ);

      userDvsnController.text = profile.userDvsn;

      userDvsn = profile.userDvsn;

      userSectionController.text = profile.userSection;
      userDesignationController.text = profile.userDesignation;
      log.d("userSection *" + profile.userSection);

    });
  }
}
