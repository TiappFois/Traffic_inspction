import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import 'size_config.dart';
//import 'package:cms/graph/alertDetailGraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import 'ti_constants.dart';
import 'ti_utilities.dart';
import 'logger.dart';


class LocationSettings extends StatefulWidget {
  const LocationSettings({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LocationSettingsState createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {
  final log = getLogger('AboutUs');
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  double width, height;
  var padding;

  @override
  Widget build(BuildContext context) {
    width = SizeConfig.screenWidth;
    height = SizeConfig.screenHeight;
    padding = MediaQuery.of(context).padding;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      appBar: TiUtilities.tiAppBar(context, "App Location Setting"),
      body: Builder(
        builder: (context) => new SingleChildScrollView(
          //padding: const EdgeInsets.symmetric(horizontal: 5.0),
          reverse: true,
          child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: new Container(
                //margin: new EdgeInsets.all(15.0),
                child: new Form(
                  child: FormUI(context),
                ),
              )),
        ),
      ),
    );
  }

  Widget FormUI(BuildContext context) {
    return new Card(
      color: Colors.orange,
      child: new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Expanded(
                    child: new Card(
                      color: Colors.teal,
                      child: Text(
                        "\n    चालक दल (CMS)\n    Crew Management System                 \n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          //),

          new Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 1, color: Colors.grey[300]),
            ),
            //color: Colors.grey[100],
            child: new Row(
              children: <Widget>[
                PermissionStatusWidget(),
              ],
            ),
          ),
          new Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 1, color: Colors.grey[300]),
            ),
            //color: Colors.grey[100],
            child: new Row(
              children: <Widget>[
                ServiceEnabledWidget(),
              ],
            ),
          ),
          new Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 1, color: Colors.grey[300]),
            ),
            //color: Colors.grey[100],
            child: new Row(
              children: <Widget>[
                GetLocationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PermissionStatusWidget extends StatefulWidget {
  const PermissionStatusWidget({Key key}) : super(key: key);

  @override
  _PermissionStatusState createState() => _PermissionStatusState();
}

class _PermissionStatusState extends State<PermissionStatusWidget> {
  LocationPermission _permissionGranted;

  Future<void> _checkPermissions() async {
    final LocationPermission permissionGrantedResult =
    await Geolocator.checkPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (!(_permissionGranted == LocationPermission.always ||
        _permissionGranted == LocationPermission.whileInUse)) {
      final LocationPermission permissionRequestedResult =
      await Geolocator.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       Text(
         'Permission status: \n${_permissionGranted ?? "unknown"}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 42),
              child: ElevatedButton(
                child: const Text('Check'),
                onPressed: _checkPermissions,
              ),
            ),
            ElevatedButton(
              child: const Text('Request'),
              onPressed: (_permissionGranted == LocationPermission.always ||
                  _permissionGranted == LocationPermission.whileInUse)
                  ? null
                  : _requestPermission,
            )
          ],
        )
      ],
    );
  }
}

class ServiceEnabledWidget extends StatefulWidget {
  const ServiceEnabledWidget({Key key}) : super(key: key);

  @override
  _ServiceEnabledState createState() => _ServiceEnabledState();
}

class _ServiceEnabledState extends State<ServiceEnabledWidget> {
  bool _serviceEnabled;

  Future<void> _checkService() async {
    final bool serviceEnabledResult = await Geolocator.isLocationServiceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabledResult;
    });
  }

  Future<void> _requestService() async {
    if (_serviceEnabled == null || !_serviceEnabled) {
      final bool serviceRequestedResult = await Geolocator.openLocationSettings();
      setState(() {
        _serviceEnabled = serviceRequestedResult;
      });
      if (!serviceRequestedResult) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Service enabled: ${_serviceEnabled ?? "unknown"}',
            style: Theme.of(context).textTheme.bodyText1),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 42),
              child: ElevatedButton(
                child: const Text('Check'),
                onPressed: _checkService,
              ),
            ),
            ElevatedButton(
              child: const Text('Request'),
              onPressed: _serviceEnabled == true ? null : _requestService,
            )
          ],
        )
      ],
    );
  }
}

class GetLocationWidget extends StatefulWidget {
  const GetLocationWidget({Key key}) : super(key: key);

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocationWidget> {
  Position _location = Position(latitude: 0.0, longitude: 0.0);
  String _nearestLobbies="";
  String _error;
  static final log = getLogger('LocationSetting');

  Future<void> _getLocation() async {
    List closestLobbyList =  new List();
    setState(() {
      _error = null;
    });
    try {
    //  final Position _locationResult = await TiUtilities
    //     .getUserGeoPosition();
      log.d('Fetching from service getClosestLobby');
      var jsonResult;
      Map<String, dynamic> urlinput = {
      //  "latitude": _locationResult.latitude,
      //  "longitude": _locationResult.longitude,
        "noOfStations": "5"
      };
      String urlInputString = json.encode(urlinput);
      var url = /*TiUtilities.webServiceUrl + */'getClosestLobby';
      log.d("url = " + url);
      log.d("urlInputString = " + urlInputString);
      final response = await http.post(Uri.parse(url),
          //headers: TiUtilities.headerInput,
          body: urlInputString,
          encoding: Encoding.getByName("utf-8"));
      try {
        jsonResult = json.decode(response.body);
        log.d("response code = " + response.statusCode.toString());
        if (response == null || response.statusCode != 200) {
          throw new Exception(
              'HTTP request failed, statusCode: ${response?.statusCode}');
        } else {
          log.d("json result = " + jsonResult.toString());
          setState(() {
            //_location = _locationResult;
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
        print(e);
      }

    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       Text(
         'Location: ' + (_error ?? '\n${_location.toString().replaceAll(', ', '\n') ?? "unknown"}'),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          children: <Widget>[
            ElevatedButton(
              child: const Text('Get Location'),
              onPressed: _getLocation,
            )
          ],
        ),
        Text(
          'Closest Lobbies: \n' + (_error ?? '${_nearestLobbies ?? "unknown"}'),
          style: TextStyle(fontSize: 12),
          maxLines: 6,
        ),
      ],
    );
  }
}
