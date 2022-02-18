import 'package:flutter/material.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/model/SttnInspModels/sttnInspModel.dart';
////import 'package:fois_mobileapp/Pages/home.dart';
//import
import 'package:ti/model/SttnInspModels/cautionOrdRegModel.dart';
import 'caution_or_reg.dart';
import 'package:ti/commonutils/ti_constants.dart';
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

class SttnPosition extends StatefulWidget {
  //const SttnPosition({Key? key}) : super(key: key);

  @override
  _SttnPositionState createState() => _SttnPositionState();
}

class _SttnPositionState extends State<SttnPosition> {

  Position _location = Position(latitude: 0.0, longitude: 0.0);
  String _nearestLobbies="";
  String _error;
  static final log = getLogger('StationLocationSetting');

  Future<void> _getLocation() async {
    List closestLobbyList =  new List();
    setState(() {
      _error = null;
    });
    try {
      final Position _locationResult = await TiUtilities
          .getUserGeoPosition();
      log.d('Fetching from service getClosestLobby');
      var jsonResult;
      print("Position : " + _locationResult.toString());
      Map<String, dynamic> urlinput = {
        "latitude": _locationResult.latitude,
        "longitude": _locationResult.longitude,
        "noOfStations": "5"
      };
      String urlInputString = json.encode(urlinput);
      var url = TiConstants.webServiceUrl + 'getClosestLobby';
      print("url: " + url);
      log.d("url = " + url);
      log.d("urlInputString = " + urlInputString);
      print("station: " + urlInputString);
       final response = await http.post(Uri.parse(url),
          headers: TiConstants.headerInput,
          body: urlInputString,
          encoding: Encoding.getByName("utf-8"));
       print("After postReq");
      try {
        print("After postReq2:" + response.body.toString());
        jsonResult = json.decode(response.body);
        log.d("response code = " + response.statusCode.toString());
        print("response code = " + response.statusCode.toString());
        if (response == null || response.statusCode != 200) {
          throw new Exception(
              'HTTP request failed, statusCode: ${response?.statusCode}');
        } else {
          log.d("json result = " + jsonResult.toString());
          print("json result = " + jsonResult.toString());
          setState(() {
            _location = _locationResult;
            if (jsonResult != null && jsonResult.length > 0) {
              jsonResult.forEach((element) =>
                  closestLobbyList.add(
                      element['zone'] +
                          '-' +
                          element['division'] +
                          '-' +
                          element['stationCode'] +
                          '-' +
                          element['stationName'] +
                          ' (' +
                          element['distance'] +
                          'Km)'));
            } else {
              closestLobbyList.add("NA");
            }
            log.d(closestLobbyList);
            print("closestLobbyList : " + closestLobbyList[0]);
            try {
              _nearestLobbies =
                  closestLobbyList[0] + '\n' + closestLobbyList[1] + '\n'
                      + closestLobbyList[2] + '\n' + closestLobbyList[3] + '\n' +
                      closestLobbyList[4];
            }catch(e){

            }
          });
        }
      }catch(e){
        print("Myexcetion"+ e.toString());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  TiUtilities.tiAppBar(context, "Current Position"),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("Current Loaction: " + '\n${_location.toString()}'),
              ElevatedButton(
                child: const Text('Get Location'),
                onPressed: _getLocation,
              )
            ],
          ),
        )
      ),
    );
  }
}
