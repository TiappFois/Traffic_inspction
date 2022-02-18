import 'dart:core';

import 'package:ti/bl/login_bl.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ti/generated/l10n.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({Key key}) : super(key: key);

  @override
  _LoginPageFormState createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final log = getLogger('LoginPageForm');
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  TextEditingController uidController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  final uid = FocusNode();
  final pwd = FocusNode();

  String userId, password;
  String userType = "IR";
  bool uType = false;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    uidController.dispose();
    pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [
                        0.1,
                        0.5,
                        0.7,
                        0.9
                      ],
                          colors: [
                        Colors.teal.shade800,
                        Colors.teal.shade600,
                        Colors.teal.shade300,
                        Colors.teal.shade100,
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //SizedBox(height: 20.0),
                                const Text('',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis),

                                SizedBox(height: 5.0),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(2.0)),
                                      Expanded(
                                        child: SizedBox(
                                          height: 35,
                                          width: 50.0,
                                          child: TextFormField(
                                            style: style,
                                            controller: uidController,
                                            keyboardType: TextInputType.text,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            focusNode: uid,
                                            // ignore: missing_return
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return ('Please enter valid User-ID');
                                              }
                                            },
                                            onSaved: (value) {
                                              userId = value;
                                            },
                                            textInputAction: TextInputAction.next,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(pwd);
                                            },
                                            decoration:  InputDecoration(
//                                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 1.0),
                                              hintText: S.of(context).EnterLoginID ,
                                              //"Enter Login ID",
                                              icon: Icon(
                                                Icons.account_circle,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                const SizedBox(height: 5.0),

                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      const Padding(padding: EdgeInsets.all(2.0)),
                                      Expanded(
                                        child: SizedBox(
                                          height: 35,
                                          width: 50.0,
                                          child: TextFormField(
                                            style: style,
                                            controller: pwdController,
                                            focusNode: pwd,
                                            //keyboardType: TextInputType.number,
                                            validator: (password) {
                                              if (password.isEmpty) {
                                                return (
                                                     S.of(context).PleaseEnterPassword
                                                   // 'Please Enter Password'
                                                );
                                              }
                                              /*else if (password.leng th < 6 ||
                                            password.length > 12) {
                                          return ('Please Enter Valid Password');
                                        }*/
                                            },
                                            onSaved: (value) {
                                              password = value;
                                            },

                                            onFieldSubmitted: (v) {
                                              _loginButtonPressed();
                                            },
                                            obscureText: true,
                                            decoration:  InputDecoration(
//                                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                              hintText: S.of(context).PleaseEnterPassword,
                                              //"Enter Password",
                                              icon: Icon(
                                                Icons.lock,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                const SizedBox(height: 5.0),

                                Row(
                                  children: [
                                    Checkbox(
                                        value: uType,
                                        onChanged: (bool value) {
                                          log.d("user type changed");
                                          setState(() {
                                            uType = value;
                                            if (uType) {
                                              userType = "TI";
                                            } else {
                                              userType = "IR";
                                            }
                                          });
                                        }),
                                    Text("TI",
                                        textAlign: TextAlign.center,
                                        style: style.copyWith(
                                            color: Colors.teal, fontSize: 18)),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
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
                                        _loginButtonPressed();
                                      },
                                      child: Text(S.of(context).Login,
                                          //"Login",
                                          textAlign: TextAlign.center,
                                          style: style.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                InkWell(
                                    child: RichText(
                                      text: TextSpan(
                                        text: S.of(context).Howto,
                                        //'How to ',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.teal[900],
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: ' '+ S.of(context).resetPassword,
                                              //'reset Password? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.teal[900],
                                              )),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      log.d("taped here in login");
                                    }),
                                const SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                )),
          )),
    );
    //////Bottom Navigation Bar//////////////
    // bottomNavigationBar: NavigationMenue.bottomnavigationbar(context),
    //),
    // );
  }

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

 /* void _loginButtonPressed() {
    log.d("_loginButtonPressed() called");
    if (_formKey.currentState.validate()) {
      log.d("_loginButtonPressed() 1");
      _formKey.currentState.save();
      TiUtilities.showLoadingDialog(context, _keyLoader);
      log.d("_loginButtonPressed() userType" + userType);
      log.d("_loginButtonPressed() userId" + userId);
      log.d("_loginButtonPressed() password" + password);
      //LoginBl.login(userType, userId, password).then((loginResult) {
      //     log.d('avinesh--$loginResult');
      //  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      //   if (loginResult == 'LOG_IN_SUCCESS') {


      Navigator.of(context).pushNamedAndRemoveUntil(
          '/user_home', (Route<dynamic> route) => false);
      //  } else {
      ////     log.d('In else');
//TiUtilities.showOkDialog(context, "Invalid Login ID/Password/TYPE");
      //  }
      //  });
      //Navigator.of(context).pushNamedAndRemoveUntil( '/user_home', (Route<dynamic> route) => false);
    }
  }
  */

  void _loginButtonPressed() {
    log.d("_loginButtonPressed() called");
    if (true) {
      _formKey.currentState.save();
      TiUtilities.showLoadingDialog(context, _keyLoader);

      //Navigator.of(context).pushNamedAndRemoveUntil('/user_home', (Route<dynamic> route) => false);


      LoginBl.login(userType, userId, password).then((loginResult) {
        log.d('avinesh--$loginResult');
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (loginResult == 'LOG_IN_SUCCESS') {
          Navigator.of(context).pushNamedAndRemoveUntil('/user_home', (Route<dynamic> route) => false);
        } else {
          log.d('In else');
          TiUtilities.showOKDialog(
              context, "Invalid Login ID/Password/TYPE");
        }
      } );

    }

  }

}
