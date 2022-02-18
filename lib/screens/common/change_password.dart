import 'dart:core';

import 'package:ti/bl/login_bl.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:ti/commonutils/size_config.dart';
import 'package:ti/screens/apphome_screen.dart';
import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key key}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final log = getLogger('_ChangePasswordFormState');
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  double width, height, font, headingFont, cardFont;
  var padding;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final currentPasswordFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    width = SizeConfig.screenWidth;
    height = SizeConfig.screenHeight;
    padding = MediaQuery.of(context).padding;
    if (MediaQuery.of(context).orientation.toString() ==
        'Orientation.landscape') {
      font = 14;
      headingFont = font * 1.2;
    } else {
      font = 14;
      headingFont = font * 1.2;
    }

    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          title: Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 1.0)),
              Container(
                  /*   padding: const EdgeInsets.all(20.0),*/
                  alignment: Alignment.center,
                  child: const Text('    Change Password     ')),
              const Padding(padding: EdgeInsets.only(right: 15.0)),
            ],
          )),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //reverse: false,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottom),

            //margin: new EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              child: FormUI(context),
            ),
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    //context1 = context;
    //pr = new ProgressDialog(context);
    // super.dispose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Widget FormUI(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    TiUtilities.user.fname +
                        '(' +
                        TiUtilities.user.loginid +
                        ')',
                    style: TextStyle(color: Colors.teal, fontSize: font),
                    textAlign: TextAlign.end,
                  ),
                  Card(
                    elevation: 10.0,
                    shadowColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 0.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Current Password
                          //SizedBox(height: 30.0),

                          TextFormField(
                            style: style,
                            controller: currentPasswordController,
                            focusNode: currentPasswordFocusNode,
                            autovalidateMode: AutovalidateMode.disabled,
                            // ignore: missing_return
                            validator: (password) {
                              if (password.isEmpty) {
                                return ('Please Enter Current Password');
                              }
                              /*else if (password.length < 6 || password.length > 8) {
                                    return ('Please Enter Valid Current Password');
                                  }*/
                            },
                            onSaved: (value) {
                              //password = value;
                            },
                            onFieldSubmitted: (v) {
                              _changePasswordButtonPressed();
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
//                                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              hintText: "Current Password",
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // New Password
                          //SizedBox(height: 30.0),
                          TextFormField(
                            style: style,
                            controller: newPasswordController,
                            focusNode: newPasswordFocusNode,
                            autovalidateMode: AutovalidateMode.disabled,
                            // ignore: missing_return
                            validator: (password) {
                              if (password.isEmpty) {
                                return ('Please Enter New Password');
                              } else if (password.length < 6 ||
                                  password.length > 8) {
                                return ('Please Enter Valid New Password');
                              }
                            },
                            onSaved: (value) {
                              // password = value;
                            },
                            onFieldSubmitted: (v) {
                              _changePasswordButtonPressed();
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
//                                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              hintText: "New Password",
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // Confirm New Password
                          // SizedBox(height: 30.0),
                          TextFormField(
                            style: style,
                            controller: confirmPasswordController,
                            focusNode: confirmPasswordFocusNode,
                            autovalidateMode: AutovalidateMode.disabled,
                            // ignore: missing_return
                            validator: (password) {
                              if (password.isEmpty) {
                                return ('Please Enter Confirm Password');
                              } else if (password.length < 6 ||
                                  password.length > 8) {
                                return ('Please Enter Valid Confirm Password');
                              }
                            },
                            onSaved: (value) {
                              //password = value;
                            },
                            onFieldSubmitted: (v) {
                              _changePasswordButtonPressed();
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
//                                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              hintText: "Confirm New Password",
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [
                                      0.1,
                                      0.3,
                                      0.5,
                                      0.7,
                                      0.9
                                    ],
                                    colors: [
                                      Colors.teal.shade400,
                                      Colors.teal.shade400,
                                      Colors.teal.shade800,
                                      Colors.teal.shade400,
                                      Colors.teal.shade400,
                                    ]),
                              ),
                              child: MaterialButton(
                                minWidth: 250,
                                height: 20,
                                padding: const EdgeInsets.fromLTRB(
                                    25.0, 5.0, 25.0, 5.0),
                                onPressed: () {
                                  _changePasswordButtonPressed();
                                },
                                child: Text("Change Password",
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                  Text(
                    'Password Policy',
                    style: TextStyle(
                        fontSize: headingFont, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  const Text(
                      'A. Password cannot contain\n  1. User Name(complete)\n  2. Crew ID (any crew id of particular lobby)\n  3. User ID (Self) \n  4. Lobby Code \nB. Password cannot be same as previous password. \nC. Password must be Alphanumeric which contain at least one number and one character \nD. Password length must be minimum 6 digits. \nE. Password will not contain special character. \nF. Change in every 6 Months'),
                ],
              ),
            ),
          )
        ]);
  }
  //new Padding(padding: new EdgeInsets.all(0)),

  final snackbar = SnackBar(
    backgroundColor: Colors.redAccent[100],
    content: Container(
      child: const Text(
        'Invalid Credentials!',
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white),
      ),
    ),
  );

  final snackbar1 = SnackBar(
    backgroundColor: Colors.redAccent[100],
    content: Container(
      child: const Text(
        'Internet not available',
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white),
      ),
    ),
  );

  void _changePasswordButtonPressed() {
    log.d("_changePasswordButtonPressed() called");
    if (_formKey.currentState.validate()) {
      String message = _checkPassword(currentPasswordController.text,
          newPasswordController.text, confirmPasswordController.text);
      if (message == 'Valid Password') {
        _formKey.currentState.save();
        TiUtilities.showLoadingDialog(context, _keyLoader);
        LoginBl.changePassword(
                currentPasswordController.text, newPasswordController.text)
            .then((changePasswordResponseMessage) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

          log.d('avinesh--$changePasswordResponseMessage');
          if (changePasswordResponseMessage ==
              'Password Updated Successfully.') {
            TiUtilities.showOKDialog(context,
                    'Password Updated Successfully. Login with New Password.')
                .then((res) {
              LoginBl.logOut().then((logOutResult) {
                if (logOutResult == 'LOG_OUT_SUCCESS') {
                  TiUtilities.pushPage(context, () => AppHomePageForm());
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/user_home', (Route<dynamic> route) => false);
                }
              });
            });
          } else {
            TiUtilities.showOKDialog(context, changePasswordResponseMessage);
          }
        });
      } else {
        TiUtilities.showOKDialog(context, message);
      }
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String _checkPassword(
      String currentPassword, String newPassword, String confirmPassword) {
    log.d(newPassword);
    log.d(confirmPassword);
    final validCharacters = RegExp(
        r'^(?=.{8,20}$)(?=[^A-Za-z]*[A-Za-z])(?=[^0-9]*[0-9])(?:([\w\d*?!:;])\1?(?!\1))+$');
    if (validCharacters.hasMatch(newPassword)) {
      return 'Passwords must be 6-8 characters in length.At least one Alpha.At least one Numeric and Valid Characters, not repeated thrice.';
    } else if (newPassword != confirmPassword) {
      return "New Password and Confirm Password Must be Same";
    } else if (currentPassword == newPassword) {
      return 'Current Password and New Password must not be Same.';
    } else if (_fixValues(newPassword)) {
      return "PASSWORD CAN NOT CONTAIN VALUES LIKE - abc/xyz/123 !!";
    } else {
      return 'Valid Password';
    }
  }

  bool _fixValues(pass) {
    try {
      if (pass.toUpperCase().indexOf("ABC") >= 0) {
        return true;
      } else if (pass.toUpperCase().indexOf("XYZ") >= 0) {
        return true;
      } else if (pass.indexOf("123") >= 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return true;
    }
    //return true;
  }
}
