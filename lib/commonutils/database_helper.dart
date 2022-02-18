import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;

import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:ti/commonutils/user.dart';

class DatabaseHelper {
  static final log = getLogger('DatabaseHelper');
//----------------------------------------Changes by Gurmeet begins-------------------------
  static const _databaseName = "tiFlite.db";
  static const _databaseVersion = 1;

  //TABLE-1 Version Control
  static const String TABLE_NAME_1 = "VersionControl";
  static const String Tbl1_Col1_Date = "Date";
  static const String Tbl1_Col2_UpdateFlag =
      "UpdateFlag"; //0 - Not Needed   // 1 - Needed  // 2 - Not Necessary(Update Later)
  static const String Tbl1_Col3_LatestVersion = "LatestVersion";

//TABLE-2 Login User

  static const String TABLE_NAME_2 = "LoginUser";
  static const String Tbl2_Col1_LoginId = "LoginId";
  static const String Tbl2_Col2_Fname = "Fname";
  static const String Tbl2_Col3_Mobile = "Mobile";
  static const String Tbl2_Col4_userDesg = "userDesg";
  static const String Tbl2_Col5_usrHQ = "usrHQ";
  static const String Tbl2_Col6_usrType = "usrType";
  static const String Tbl2_col7_userDvsn = "userDvsn";


  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $TABLE_NAME_1 (
            $Tbl1_Col1_Date TEXT NOT NULL,
            $Tbl1_Col2_UpdateFlag TEXT NOT NULL,
            $Tbl1_Col3_LatestVersion TEXT NOT NULL
          )
          ''');


    await db.execute('''
          CREATE TABLE $TABLE_NAME_2 (
            $Tbl2_Col1_LoginId TEXT NOT NULL,
            $Tbl2_Col2_Fname,
            $Tbl2_Col3_Mobile,
            $Tbl2_Col4_userDesg,
            $Tbl2_Col5_usrHQ,
            $Tbl2_Col6_usrType,
            $Tbl2_col7_userDvsn
          )
          ''');
  }

  //***************LOGIN USER FUNCTIONS START*******************************************************************************
  Future<bool> isSignedIn() async {
    Database db = await instance.database;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME_2'));
    if (count > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<TiUser> getCurrentUser() async {
    Database db = await instance.database;
    List<dynamic> tblResult = await db.query(TABLE_NAME_2);

    TiUser tiUser = TiUser(
        tblResult[0]['LoginId'].toString(),
        tblResult[0]['Fname'].toString(),
        tblResult[0]['Mobile'].toStrig(),
        tblResult[0]['userDesg'].toString(),
        tblResult[0]['usrHQ'].toString(),
        tblResult[0]['usrType'].toString(),
        tblResult[0]['userDvsn'].toString(),
        );

    log.d('id ddd bdfdfd  ' + tblResult[0]['userDesg'].toString());
    return tiUser;
  }

  Future<TiUser> callLoginWebService(
      String userType, String userId, String password) async {
    String info = "";
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      log.d('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
      info = 'Android $release (SDK $sdkInt), $manufacturer $model';
    }
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      log.d('$systemName $version, $name $model');
      // iOS 13.1, iPhone 11 Pro Max iPhone
      //iOS 13.5, iPhone SE (2nd generation) iPhone
      info = '$systemName $version, $name $model';
    }
    TiUser tiUser;
    var jsonResult;
    TiUtilities.versionCheck(context, false);
    userType = userType +
        '@' +
        info +
        ' <= ' +
        TiUtilities.version +
        ' (' +
        TiUtilities.versionCode +
        ')';
    log.d('Function called ' +
        userId.toString() +
        "---" +
        password.toString() +
        "---" +
        userType.toString());
    //JSON VALUES FOR POST PARAM
    Map<String, dynamic> urlinput = {
      "strUserid": userId,
      "strPassword": password,
      //"logintype": userType,
      //"pay_month": ""
    };

    log.d("urlInputStringLogin1 = " + urlinput.toString());

    String urlInputString = json.encode(urlinput);

    log.d("urlInputStringLogin2 = " + urlInputString);

    var url= TiConstants.webServiceUrl +'CheckLogin';

    final response = await http.post(Uri.parse(url),
        headers: TiConstants.headerInput,
        body: urlInputString,
        encoding: Encoding.getByName("utf-8"));

    print('jsonRes' + response.body);

    jsonResult = json.decode(response.body);

    print("Jsonresult:"+jsonResult['loginuser']['userId']);

    final loginstatus = User.fromJson(jsonResult['loginuser']);
    log.d('22 33311 lOGIN' + jsonResult.toString());
    log.d('22 33311 lOGIN 2' + loginstatus.username);

    //return loginstatus.status;
    if (response.statusCode == 200) {
      log.d('inside resposn code 200' + jsonResult.toString());
      //    log.d(jsonResult['status'].toString() == 'LOG_IN_SUCCESS');
      if (loginstatus.status == 'LOG_IN_SUCCESS') {
        log.d('inside LOG_IN_SUCCESS');
        //{isSuccess: true, loginIfoVO: {loginid: rtm0037, fname: S M RIZVI, usreMail: Chief Loco Inspector, usrLocn: RTM , usrType: LI}}
        //{isSuccess: true, loginIfoVO: {loginid: avinesh, fname: AVINESH, authlevel: CRIS, usrLocn: CRIS, usrType: IR}}
        //String loginid, fname, authlevel, usreMail, usrLocn, usrType, loginFlag;

      tiUser = TiUser(
          loginstatus.userId,
          loginstatus.username,
          loginstatus.userMob,
          loginstatus.userDesgn,
          loginstatus.userHQ,
          loginstatus.userType,
          loginstatus.userDvsn
          );
    }

      log.d('AFTER  TIUSER');
      saveUserLoginDtls(tiUser);
      log.d('Role Id ' + tiUser.userType);

      return tiUser;
    }
  }

  Future<int> saveUserLoginDtls(TiUser tiUser) async {
    log.d("save function called");
    await deleteLoginUser();
    log.d("AWAIT function called");

    Map<String, dynamic> row = {
      DatabaseHelper.Tbl2_Col1_LoginId: tiUser.loginid ,//== null ? '' : tiUser.loginid,
      DatabaseHelper.Tbl2_Col2_Fname: tiUser.fname ,//== null ? '' : tiUser.fname ,
      DatabaseHelper.Tbl2_Col3_Mobile: tiUser.userMob ,//== null ? '' : tiUser.userMob ,
      DatabaseHelper.Tbl2_Col4_userDesg: tiUser.userDesgn ,//== null ? '' : tiUser.userDesgn ,
      DatabaseHelper.Tbl2_Col5_usrHQ: tiUser.userHQ ,//== null ? '' : tiUser.userHQ ,
      DatabaseHelper.Tbl2_Col6_usrType: tiUser.userType ,//== null ? '' : tiUser.userType ,
      DatabaseHelper.Tbl2_col7_userDvsn: tiUser.userDvsn //== null ? '' : tiUser.userDvsn
    };

    log.d("save function called 0" + row.toString());

    log.d("save function called 1");
    int id = await insertLoginUser(row);
    log.d("save function called 2");
    log.d("Id after insertion = " + id.toString());
  }

  Future<int> insertLoginUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(TABLE_NAME_2, row);
  }

  Future<int> deleteLoginUser() async {
    log.d('DatabaseHelper deleteLoginUser() called');
    Database db = await instance.database;
    log.d('DatabaseHelper deleteLoginUser() called 2');
    return await db.delete(TABLE_NAME_2);
  }

//***************LOGIN USER FUNCTIONS END*******************************************************************************

  Future<int> rowCountVersionDtls() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME_1'));
  }

  Future<List<Map<String, dynamic>>> fetchVersionDtls() async {
    Database db = await instance.database;
    return await db.query(TABLE_NAME_1);
  }

  Future<int> insertVersionDtls(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(TABLE_NAME_1, row);
  }

  Future<int> deleteVersionDtls(int id) async {
    Database db = await instance.database;
    return await db.delete(TABLE_NAME_1);
  }

  Future<int> updateVersionDtls(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(TABLE_NAME_1, row);
  }
}
