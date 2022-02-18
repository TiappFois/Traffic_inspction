import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/model/TILocationModel.dart';
import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/size_config.dart';

import 'dart:convert';

import 'package:ti/commonutils/size_config.dart';
//import 'package:cms/graph/alertDetailGraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:ti/commonutils/ti_constants.dart';

import 'package:ti/commonutils/logger.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:ti/pages/SttnInsp/sttn_inspection.dart';

class TILocation extends StatefulWidget {

  @override
  _TILocationState createState() => _TILocationState();
}

class _TILocationState extends State<TILocation> {

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  Position _location = Position(latitude: 0.0, longitude: 0.0);

  String _error;
  static final log = getLogger('StationLocationSetting');

  @override
  void initState() {

    super.initState();
    setState(() {

     // _getLocation();

    });

  }

    Future<void> _getLocation() async {

    print("After init");

    TiUtilities.showLoadingIndicator(context, "Please wait");

    try {
      Position _locationResult =  await TiUtilities.getUserGeoPosition();

       setState(() {
        _location = _locationResult;
        print("in setstate" + _locationResult.toString());

      });

     if(!(_locationResult == Position(latitude: 0.0, longitude: 0.0)))
     {
      if (closestLobbyList == null || closestLobbyList.length == 0) {
        log.d('Fetching from service getClosestLobby');
        var jsonResult;
        print("Position : " + _locationResult.toString());
        Map<String, dynamic> urlinput = {
          "latitude": _locationResult.latitude,
          "longitude": _locationResult.longitude,

        };
        String urlInputString = json.encode(urlinput);
        //var url = TiConstants.webServiceUrl + 'getClosestLobby';
        var url = TiConstants.webServiceUrl + 'GetGPSLocn';
        //var url = "http://172.16.4.58:7101/TIWebService-TrafficInspectionRest-context-root/resources/TiAppService/GetGPSLocn";

        log.d("url = " + url);
        log.d("urlInputString = " + urlInputString);


        final response = await http.post(Uri.parse(url),
            headers: TiConstants.headerInput,
            body: urlInputString,
            encoding: Encoding.getByName("utf-8"));

        Navigator.of(context).pop();

        try {
          print("After postReq2:" + response.body.toString());
          jsonResult = json.decode(response.body);
          log.d("response code = " + response.statusCode.toString());

          if (response == null || response.statusCode != 200) {
            throw new Exception(
                'HTTP request failed, statusCode: ${response?.statusCode}');
          } else {
            log.d("json result Location = " + jsonResult.toString());

            //  setState(() {
            _location = _locationResult;

            if (jsonResult != null && jsonResult.length > 0) {
              for (var i = 0; i < jsonResult['gpsSttnsList'].length; i++) {
                closestLobbyList.add(jsonResult['gpsSttnsList'][i].toString());
              }
            } else {
              closestLobbyList.add("NA");
            }
            log.d("closestLobbyList : " + closestLobbyList.toString());
          }
        } catch (e) {
          print("Myexcetion" + e.toString());
        }
      }
    }

      setState(() {
        _location = _locationResult;
        print("in setstate" + _locationResult.toString());
      });

    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  List<String> inspSubTypeItems = [
    'Detail Inspection', 'Night Inspection', 'Casual Inspection', 'Ambush Inspection'
  ];

  List<String> closestLobbyList =  [];

  String selectedGPS;

  TILocModel TILocMod = new TILocModel('', '', 'Detail Inspection');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    TextEditingController _UserStrtLocController = TextEditingController();
    _UserStrtLocController.text = TILocMod.UserLoc;

    return
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
        appBar: TiUtilities.tiAppBar(context, "Set Up Your Location"),
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: ConstrainedBox(
                          constraints:  BoxConstraints.tightFor(),
                          child: ElevatedButton(
                                child: const Text('Get Loc',
                                style: TextStyle(fontSize: 11),),
                                onPressed: _getLocation,

                            ),
                        ),

                        trailing:  SizedBox(
                            width: (SizeConfig.screenWidth) * 5/9,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text('${_location.toString()}',
                                style: TextStyle(fontSize: 10)),
                            )),
                      ),
                      ListTile(
                        //title: Text(''),
                        title:Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(

                            height: (SizeConfig.screenHeight)/10,

                            child: InputDecorator(
                              decoration: const InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(color: Colors.teal),
                                  ),
                                  border: OutlineInputBorder()),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: selectedGPS,
                                  items: closestLobbyList.map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem,
                                            style: TextStyle(
                                                  fontSize: 8
                                            )
                                        ));
                                  }).toList(),
                                  onChanged: (newSelectedValue) {
                                    setState(() {
                                      selectedGPS = newSelectedValue;
                                      this.TILocMod.GPSLoc =
                                          newSelectedValue.toString();
                                      print("TILocMod.GPSLoc:" +
                                          TILocMod.GPSLoc);
                                    });
                                  },

                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),


              ),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        return FocusManager.instance.primaryFocus?.unfocus();
                        //CautionOrdRegModel.postData(data);
                      },
                      title:   Text('User Location :',
                          style: TextStyle(
                              fontSize: 11,
                            fontWeight: FontWeight.bold
                          )),
                      trailing:  SizedBox(
                        width: (SizeConfig.screenWidth) * 5/9,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextFormField(
                            controller: _UserStrtLocController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z ]"))
                            ],
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(color: Colors.teal),
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Location',
                              labelStyle: TextStyle(
                                  color: Colors.teal,

                              ),

                              alignLabelWithHint: true,
                             ),
                            validator: (String value){
                              if(value.isEmpty){
                                return "Please Enter the Location";
                              }
                              return null;

                            },
                            onChanged: (newValue){
                              TILocMod.UserLoc = newValue ;
                            },

                            ),
                        ),
                      ),
                      ),
                  ),
                ),

             Card(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ListTile(
                      title:   Text('Inspection Subtype :',
                          style: TextStyle(
                              fontSize: 11,
                               fontWeight: FontWeight.bold
                          )),
                      trailing:  SizedBox(
                        width: (SizeConfig.screenWidth) * 5/9,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: const BorderSide(color: Colors.teal),
                                ),
                                border: OutlineInputBorder()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: TILocMod.InspSubType,
                                items: inspSubTypeItems.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem,
                                          style: TextStyle(
                                              fontSize: 11
                                          )
                                      ));
                                }).toList(),
                                onChanged: (newSelectedValue) {
                                  setState(() {
                                    this.TILocMod.InspSubType =
                                        newSelectedValue.toString();
                                    print("TILocMod.InspSubType:" +
                                        TILocMod.InspSubType);
                                  });
                                },

                              ),
                            ),
                          ),
                        ),
                      )
                    ),
               ),
             ),
                SizedBox(
                  height: 40,
                ),
                Center(
                   child: ElevatedButton(
                      child: const Text('Next'),
                      onPressed: (){
                        if (_formKey.currentState.validate()) {

                        var inspSubType = '';

                        if (TILocMod.InspSubType == 'Detail Inspection' )
                           inspSubType = 'D';
                        if (TILocMod.InspSubType == 'Night Inspection' )
                           inspSubType = 'N';
                        if (TILocMod.InspSubType == 'Casual Inspection' )
                          inspSubType = 'C';
                        if (TILocMod.InspSubType == 'Ambush Inspection' )
                          inspSubType = 'A';


                        TiUtilities.CreateInspMstr(TILocMod.GPSLoc, TILocMod.UserLoc, inspSubType).then((CreateInspMstrResult) {
                          log.d('avinesh--$CreateInspMstrResult');
                          //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                          if (CreateInspMstrResult == 'INSP_MSTR_SUCCESS') {

                            Navigator.pushNamed(context, '/sttnInspList');
                          } else {
                            log.d('In else');
                            TiUtilities.showOKDialog(
                                context, CreateInspMstrResult);
                          }
                        } );
                        }
                      },
                    )
                )

              ],
            ),
          ),
        ),
    ),
      );
  }
}
