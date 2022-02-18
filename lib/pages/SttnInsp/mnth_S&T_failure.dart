import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'dart:convert';
import 'Trn_Sgnl_Failure.dart';
import 'package:flutter/material.dart';
import 'package:ti/model/SttnInspModels/MnthS&TFailureModel.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';

import 'package:path_provider/path_provider.dart';

class MnthSTFailure extends StatefulWidget {
  @override
  _MnthSTFailureState createState() => _MnthSTFailureState();
}

class _MnthSTFailureState extends State<MnthSTFailure> {
  File imageFile = null ;

  final items = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  int gettingData = 0;
  static final log = getLogger('MonthSNTFailure');

  static MnthSTFailureModel MnthSTFailureMod;

  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {

    print("TiUtilities.inspmstr.cinsplist: " + TiUtilities.inspmstr.cinsplist);
    
    if (TiUtilities.inspmstr.cinsplist.contains('#4#')) {

      try {
        print("SgnlFailure data");

        //String urlInputString = json.encode(urlinput);
        String urlInputString = TiUtilities.inspmstr.inspid;

        log.d("urlInputStringSgnlFailure = " + urlInputString);
        var url= TiConstants.webServiceUrl +'getMnthSntFailRgtr';
        final response = await http.post(Uri.parse(
            url),
            headers: TiConstants.headerInputText,
            body: urlInputString,
            encoding: Encoding.getByName("utf-8"));

        print('jsonRes' + response.body);

        var jsonResult = json.decode(response.body);

        log.d("json result = " + jsonResult.toString());
        log.d("response code = " + response.statusCode.toString());

        if (response.statusCode == 200) {
          print("Response200");

          MnthSTFailureMod = new MnthSTFailureModel('JAN', jsonResult['ftype'], jsonResult['fcount'],jsonResult['rmrks1']);

          rmrkController.text = jsonResult['rmrks1'].toString();

          _ftypeController.text = jsonResult['ftype'].toString();

          _fcountController.text = jsonResult['fcount'].toString();

          print("Response204");
            if(jsonResult['base64Image']!= null && jsonResult['base64Image'].toString() != '') {

            Uint8List bytes = base64.decode(jsonResult['base64Image']);
            String dir = (await getApplicationDocumentsDirectory()).path;
            imageFile = File(
                "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
            await imageFile.writeAsBytes(bytes); }
            print("imageFile" );

        }
        else{
          TiUtilities.showOKDialog(context, "Issue in getting Data");
        }
      } catch (e) {
        print("Exception" + e);
        //  inspmstrResult = 'INSP_MSTR_CHECK_FAILURE';
      }
    }
    else{
      print ("In else of MNTH SNT Failure");

      MnthSTFailureMod = new MnthSTFailureModel('JAN', '', '','');

      rmrkController.text = '';

      _ftypeController.text = '';

      _fcountController.text = '';

      rmrkController.text = '';

    }

    setState(() {
      gettingData = 1;
      print("Pending:"+gettingData.toString());
    });

  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController rmrkController = TextEditingController();
  TextEditingController _ftypeController = TextEditingController();
  TextEditingController _fcountController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldkey,
        appBar: TiUtilities.tiAppBar(context, "Month wise S&T failures"),
        body:Builder(
            builder: (context) {
                if (gettingData == 0) {
                        return Container(
                        child: Center(
                        child: Text('Loading....'),
                     ),
                   );
                }
                else {
        return new SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        return FocusManager.instance.primaryFocus?.unfocus();
                        //CautionOrdRegModel.postData(data);
                      },
                      title: Text('Month',
                          style: TextStyle(
                              fontSize: 14
                          )
                      ),
                      trailing: DropdownButton<String>(
                        value: MnthSTFailureMod.month,
                        items: items.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem));
                        }).toList(),
                        onChanged: (newSelectedValue) {
                          setState(() {
                            MnthSTFailureMod.month =
                                newSelectedValue.toString();
                            print("MnthSTFailureMod.page:" +
                                MnthSTFailureMod.month);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        return FocusManager.instance.primaryFocus?.unfocus();
                        //CautionOrdRegModel.postData(data);
                      },
                      title: Text('Failure type :',
                          style: TextStyle(
                              fontSize: 14
                          )),
                      trailing: SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _ftypeController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9a-zA-Z ]"))
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: 'Remarks(if any)',

                            alignLabelWithHint: true,

                            //suffixIcon: Padding( padding: const EdgeInsets.fromLTRB(10, 20, 20, 90),
                            //  child: Icon(
                            //   Icons.speaker_notes_rounded,
                            //  color: Colors.teal,
                            //  ),
                            //          )
                          ),
                            onChanged: (val) {
                              MnthSTFailureMod.ftype = val;
                              print('MnthSTFailureMod.FType:' + MnthSTFailureMod.ftype);
                            }
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        return FocusManager.instance.primaryFocus?.unfocus();
                        //CautionOrdRegModel.postData(data);
                      },
                      title: Text('Failure Count :',
                          style: TextStyle(
                              fontSize: 14
                          )),
                      trailing: SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _fcountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: 'Remarks(if any)',

                            alignLabelWithHint: true,

                            //suffixIcon: Padding( padding: const EdgeInsets.fromLTRB(10, 20, 20, 90),
                            //  child: Icon(
                            //   Icons.speaker_notes_rounded,
                            //  color: Colors.teal,
                            //  ),
                            //          )
                          ),
                            onChanged: (val) {
                              MnthSTFailureMod.fcount = val;
                              //print('TrnSgnlFailureMod.rmrks1:' + TrnSgnlFailureMod.rmrks1);
                            }
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: TextFormField(
                          controller: rmrkController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Remarks(if any)',

                            alignLabelWithHint: true,

                            //suffixIcon: Padding( padding: const EdgeInsets.fromLTRB(10, 20, 20, 90),
                            //  child: Icon(
                            //   Icons.speaker_notes_rounded,
                            //  color: Colors.teal,
                            //  ),
                            //          )
                          ),
                          maxLines: 5,
                          onChanged: (val) {
                            MnthSTFailureMod.rmrks1 = val;
                            //print('TrnSgnlFailureMod.rmrks1:' + TrnSgnlFailureMod.rmrks1);
                          }
                          )),
                ),

                /*     Container(
                  child: ButtonTheme(
                   // minWidth: width / 3,
                    child: MaterialButton(
                      onPressed: () async {

                        _callSaveCautionOrdRegWebService(
                               widget.cautionOrdMod)
                              .then((res) {
                            Navigator.of(context,
                                rootNavigator: true)
                                .pop();
                            if (res == 'Record Successfully Saved.') {
                              print('Record Successfully Saved.');
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/home',
                                        (Route<dynamic> route) => false);

                            } else {

                                 print('Problem in Sign On. Please Contact to Supervisor');
                            }
                          });

                      },
                      textColor: Colors.white,
                      color: Colors.teal,
                      child: Text(
                        "Save",
                        style: TextStyle(
                             fontWeight: FontWeight.bold),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                )  */
              ],
            ),
          ),
        );
            }
            }
        ),
        bottomNavigationBar: TiUtilities.tiBottomNaviBar(context, "/crank_hndl_reg"),


        floatingActionButton: FloatingActionButton.extended(

          onPressed: () async {

            MnthSTFailureMod.inspID = TiUtilities.inspmstr.inspid;

            String base64Image = null ;

            if (imageFile != null) {
              base64Image = base64Encode(imageFile.readAsBytesSync());
            //print
            String fileName = imageFile.path.split("/").last;
            log.d("fileName:" + fileName); }

            MnthSTFailureMod.base64Image = base64Image;

            if (_formKey.currentState.validate()) {
              _callSaveMnthSTFailureWebService(MnthSTFailureMod).then((res) {
                if (res == 'Record Successfully Saved.') {
                  print('Record Successfully Saved.');
                  TiUtilities.showOKDialog(context, "Success!!")
                      .then((res1) {
                    Navigator.pushNamed(context, '/crank_hndl_reg');
                  });
                } else {
                  print(
                      'Problem in Sign On. Please Contact to Supervisor');
                }
              });
            }
          },
          icon: Icon(Icons.save_outlined,
            color: Colors.teal,
          ),
          label: Text('Save & Next',
            style: TextStyle(
                color: Colors.teal
            ),
          ),
          backgroundColor: Colors.lime,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future<String> _callSaveMnthSTFailureWebService(
      MnthSTFailureModel MnthSTFailure) async {

    print('Inside _callSaveMnthSTFailureWebService' );

    MnthSTFailure.inspID = TiUtilities.inspmstr.inspid;

    String urlInputString = json.encode(MnthSTFailure.toJson());

    print("urlInputString:" + urlInputString);
    var url= TiConstants.webServiceUrl +'saveMnthSntFailRgtr';
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
      log.d("json result----- = " + response.toString());

      return 'Record Successfully Saved.';
    }

  }
}
