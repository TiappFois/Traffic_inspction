import 'dart:async';
import 'dart:convert';

import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'database_helper.dart';

class ApiCall {
  static final log = getLogger('ApiCall');
  static final dbHelper = DatabaseHelper.instance;

  static Future<List> fetchLiMovementStatus(int year, int month) async {
    Map<String, dynamic> urlinput = {
      "paramList": [
        "" + TiUtilities.user.loginid.toUpperCase() + "",
        "$month",
        "$year"
      ]
    };
    String urlInputString = json.encode(urlinput);
    var url = TiConstants.webServiceUrl + 'getLiMovementDetailsMonthly';
    log.d(url);
    log.d(urlInputString);

    final response = await http.post(Uri.parse(url),
        headers: TiConstants.headerInput,
        body: urlInputString,
        encoding: Encoding.getByName("utf-8"));
    log.d('aaaaaaaa ' + response.body);

    // Use the compute function to run parseResults in a separate isolate
    return compute(parseResults, response.body);
  }

// A function that will convert a response body into a List<Result>
  static List parseResults(String responseBody) {
    // var jsonResult = json.decode(responseBody);

    //log.d("json resultdasdasdas = " + jsonResult.toString());
    log.d("1");
    // log.d(responseBody);
    var parsedJson = json.decode(responseBody);

    //log.d(parsedJson['liMovementVOsResponse']);
    parsedJson = parsedJson['liMovementVOsResponse'];

    log.d("${parsedJson.runtimeType} : $parsedJson");
    final List parsedList = parsedJson;
    return parsedList;
  }

  static Future<List> callGetPushedVersionDetailWebService() async {
    List list = [];
    try {
      log.d('Fetching from service  callGetPushedVersionDetailWebService');
      var jsonResult;
      Map<String, dynamic> urlinput = {};
      String urlInputString = json.encode(urlinput);
      var url = TiConstants.webServiceUrl + 'getPushedVersionDetail';
      log.d("url = " + url);
      log.d("urlInputString = " + urlInputString);
      final response = await http.post(Uri.parse(url),
          headers: TiConstants.headerInput,
          body: urlInputString,
          encoding: Encoding.getByName("utf-8"));
      jsonResult = json.decode(response.body);
      log.d("response code = " + response.statusCode.toString());
      if (response == null || response.statusCode != 200) {
        throw Exception(
            'HTTP request failed, statusCode: ${response.statusCode}');
      } else {
        log.d("json result = " + jsonResult.toString());
        if (jsonResult != null) {
          list = jsonResult['vosList'];
        } else {
          list.add('NA');
        }
      }
    } catch (e) {
      log.d(e);
    }
    return list;
  }
}
