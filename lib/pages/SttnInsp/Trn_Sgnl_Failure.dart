import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'dart:convert';
import 'package:ti/model/SttnInspModels/TrnSgnlFailureModel.dart';
import 'package:ti/model/SttnInspModels/sttnInspDtlsList.dart';

import 'Trn_sgnl_failure.dart';
import 'package:flutter/material.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/cameracls.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:ti/commonutils/logger.dart';

class TrnSgnlFailure extends StatefulWidget {
  @override
  _TrnSgnlFailureState createState() => _TrnSgnlFailureState();
}

class _TrnSgnlFailureState extends State<TrnSgnlFailure> {
  final items = ['Serial', 'Non-Serial'];
  //var show = false ;
  File imageFile = null ;

  List<String> selectedItemValue = [];

  List<bool> showText;
  int gettingData = 0;
  static final log = getLogger('TrnSgnlFailure');

  static TrnSgnlFailureModel trnSgnlFailureModel;

  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {

    print("TiUtilities.inspmstr.cinsplist: " + TiUtilities.inspmstr.cinsplist);
    if (TiUtilities.inspmstr.cinsplist.contains('#2#')) {

      try {
        print("trnSgnlFailure data");

        //String urlInputString = json.encode(urlinput);
        String urlInputString = TiUtilities.inspmstr.inspid;

        log.d("urlInputStringcautOrdget = " + urlInputString);
        var url= TiConstants.webServiceUrl +'gettrnsgnlfailure';
        final response = await http.post(Uri.parse(
           url),
            headers: TiConstants.headerInputText,
            body: urlInputString,
            encoding: Encoding.getByName("utf-8"));

        print('jsonRes' + response.body);

        var jsonResult = json.decode(response.body);

        print("Jsonresult:" + jsonResult['ynList1'].toString());

        print("Jsonresult 0:" + jsonResult['ynList1'][0].toString());

        log.d("json result = " + jsonResult.toString());
        log.d("response code = " + response.statusCode.toString());

        if (response.statusCode == 200) {
          print("Response200");

          showText =  await [jsonResult['ynList1'][0].toString() == 'NO' ? true : false,
                             jsonResult['ynList1'][1].toString() == 'NO' ? true : false,
                             jsonResult['ynList1'][2].toString() == 'NO' ? true : false];

          print("Response201" + showText.toString());

          trnSgnlFailureModel = await new TrnSgnlFailureModel(
              SttnInspDtlsList.getTrnSgnlFailList(), jsonResult['ynList1'],
              jsonResult['whyNoRsn'],
              jsonResult['rmrks1'].toString());

          selectedItemValue.add(jsonResult['ynList1'][0].toString());
          selectedItemValue.add(jsonResult['ynList1'][1].toString());
          selectedItemValue.add(jsonResult['ynList1'][2].toString());

          for (int i = 0; i < 3; i++) whyNocontroller.add(TextEditingController());
          whyNocontroller[0].text = jsonResult['whyNoRsn'][0].toString();
          whyNocontroller[1].text = jsonResult['whyNoRsn'][1].toString();
          whyNocontroller[2].text = jsonResult['whyNoRsn'][2].toString();

          rmrkController.text = jsonResult['rmrks1'].toString();

          print("Response204");
          if(jsonResult['base64Image']!= null && jsonResult['base64Image'].toString() != '') {

            Uint8List bytes = base64.decode(jsonResult['base64Image']);
          String dir = (await getApplicationDocumentsDirectory()).path;
          imageFile = File(
              "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
          await imageFile.writeAsBytes(bytes); }
          print("imageFile" );
          /*  inspmstr = InspMstrModel(
              jsonResult['inspMstr']['status'],
              jsonResult['inspMstr']['inspid'].toString(),
              jsonResult['inspMstr']['userid'].toString(),
              jsonResult['inspMstr']['examtype'].toString(),
              jsonResult['inspMstr']['strttime'].toString(),
              jsonResult['inspMstr']['endtime'].toString(),
              jsonResult['inspMstr']['inspgpsstrtlocn'].toString(),
              jsonResult['inspMstr']['inspgpsendlocn'].toString(),
              jsonResult['inspMstr']['inspuserstrtlocn'].toString(),
              jsonResult['inspMstr']['inspuserendlocn'].toString(),
              jsonResult['inspMstr']['footplactlocn'].toString(),
              jsonResult['inspMstr']['examcmpl'].toString(),
              jsonResult['inspMstr']['inspmstrexist'].toString(),
              jsonResult['inspMstr']['cinsplist'].toString()
          );

          setInspMstr(inspmstr);
          inspmstrResult = jsonResult['inspMstr']['inspmstrexist'].toString(); */

        }
      } catch (e) {
        print("Exception" + e);
        //  inspmstrResult = 'INSP_MSTR_CHECK_FAILURE';
      }
    }
    else{
      print ("In else of trn Sgnl Failure");

      showText = await [false, false, false];

      trnSgnlFailureModel = await new TrnSgnlFailureModel(
          SttnInspDtlsList.getTrnSgnlFailList(), ['YES', 'YES','YES'],
          ['', '',''],
          '');
      selectedItemValue.add("YES");
      selectedItemValue.add("YES");
      selectedItemValue.add("YES");

      for (int i = 0; i < 3; i++) whyNocontroller.add(TextEditingController());
      whyNocontroller[0].text = '';
      whyNocontroller[1].text = '';
      whyNocontroller[2].text = '';
      rmrkController.text = '';

    }

    setState(() {
      gettingData = 1;
      print("Pending:"+gettingData.toString());
    });

  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<TextEditingController> whyNocontroller = [];

  TextEditingController rmrkController = TextEditingController();

  callbackDropDown(callBackController , selected , show){
    setState(() {
      whyNocontroller = callBackController;
      //selectedItemValue = selected;
      showText = show;
     // print("Show:" + showText[0].toString());
       print('callBackController:' + trnSgnlFailureModel.ynList1[0]+ trnSgnlFailureModel.ynList1[1] + whyNocontroller[0].text + whyNocontroller[1].text) ;
    });
  }

  callbackCamera(imageF){
    setState(() {
      imageFile = imageF ;
      print('callback:' ) ;
    });
  }

  String page;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: new Scaffold(
      key: _scaffoldkey,
        appBar: TiUtilities.tiAppBar(context, "Train Signal  Failure Register"),
        body: Builder(

          builder: (context) {
            if (gettingData == 0) {
              return Container(
                child: Center(
                  child: Text('Loading....'),
                ),
              );
            } else {
              return new SingleChildScrollView(
                reverse: true,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: FormUI(context),
                ),
              );

            }
          }
       ),
        bottomNavigationBar: TiUtilities.tiBottomNaviBar(context, "/sgnl_failure"),


        floatingActionButton: FloatingActionButton.extended(

          onPressed: () async {

            String base64Image = null ;

            if (imageFile != null) {
              base64Image = base64Encode(imageFile.readAsBytesSync());
            //print
            String fileName = imageFile.path.split("/").last;
            log.d("fileName:" + fileName); }

            trnSgnlFailureModel.base64Image = base64Image;

            trnSgnlFailureModel.inspID = TiUtilities.inspmstr.inspid;

            if (_formKey.currentState.validate()) {
              TiUtilities.callSttnInspEntryWebService(context, json.encode(trnSgnlFailureModel.toJson()), "savetrnsgnlfailure").then((res) {
                if (res == 'Record Successfully Saved.') {
                  print('Record Successfully Saved.');
                  TiUtilities.showOKDialog(context, "Success!!")
                      .then((res1) {
                    Navigator.pushNamed(context, '/sgnl_failure');
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

  Widget FormUI(BuildContext context) {
    return new Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    return FocusManager.instance.primaryFocus?.unfocus();
                    //CautionOrdRegModel.postData(data);
                  },
                  title: Text('Page',
                      style: TextStyle(
                      fontSize: 14
                  )),
                  trailing: SizedBox(
                    width: 150,

                    child:  DropdownButtonFormField<String>(
                      decoration: const InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          //borderRadius : const BorderRadius.all(Radius.circular(4.0)),
                          borderSide: const BorderSide(color: Colors.teal),
                        ),
                      ),
                      value: page,
                      items: items.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem)
                        );
                      }).toList(),
                      onChanged: (newSelectedValue) {
                        setState(() {
                          page = newSelectedValue.toString();
                          print("TrnSgnlFailureMod.page:" + page);

                        });
                      },

                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: trnSgnlFailureModel.sList1.length,
          itemBuilder: (BuildContext context, int index) {

            return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 5.0, horizontal: 4.0),
                child: Tooltip(
                  message: SttnInspDtlsList.getTrnSgnlFailListDtls()[index],
                  child: Card(
                    child: dropdowncls(dropdowntextcallback: callbackDropDown,
                        slst: trnSgnlFailureModel.sList1,
                        ynlst: trnSgnlFailureModel.ynList1,
                        index: index,selectedItem: selectedItemValue,
                        showTextField: showText,
                        whyNoCont: whyNocontroller,
                        whyNolst: trnSgnlFailureModel.whyNoRsn,
                        regiType: "trnSgnlFaillang"),


                    /*  Column(
                            children: [
                              ListTile(
                                  onTap: () {
                                    return FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    //CautionOrdRegModel.postData(data);
                                  },
                                  title: Text(TrnSgnlFailureMod.sList1[index]),
                                  trailing: getDropdownlst(TrnSgnlFailureMod.sList1 , index ) ,

                                  SizedBox(
                                    width: 150,

                                    child:  DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(

                                        enabledBorder: OutlineInputBorder(
                                          //borderRadius : const BorderRadius.all(Radius.circular(4.0)),
                                          borderSide: const BorderSide(color: Colors.teal),
                                        ),
                                      ),
                                      value: selectedItemValue[index].toString(),
                                      items:  _dropDownItem(),
                                      onChanged: (newSelectedValue) {
                                        setState(() {
                                          selectedItemValue[index] =
                                              newSelectedValue.toString();
                                          TrnSgnlFailureMod.ynList1[index] = newSelectedValue.toString();
                                          print("TrnSgnlFailureModdddd.:" + index.toString() + TrnSgnlFailureMod.ynList1[index]);
                                           if(newSelectedValue.toString() == 'NO'){
                                              _showTextField[index] = true;
                                              print("_showTextField:"  + _showTextField[index].toString());
                                              show = true;
                                           }
                                          else{
                                            _showTextField[index] = false;
                                            print("_showTextField:" + _showTextField[index].toString() );

                                           }

                                        });
                                      },

                                    ),
                                  ),

                         ),
                           Visibility(
                            visible: _showTextField[index],
                            child: Container(
                            child: SizedBox(
                            //width: 200,
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                controller: _whyNocontroller[index],
                                inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                RegExp("[0-9a-zA-Z]"))
                                ],
                                decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Please mention Reason',

                                alignLabelWithHint: true,

                                //suffixIcon: Padding( padding: const EdgeInsets.fromLTRB(10, 20, 20, 90),
                                //  child: Icon(
                                //   Icons.speaker_notes_rounded,
                                //  color: Colors.teal,
                                //  ),
                                //          )
                                             ),
                                         ),
                              ),
                            ),
                                  ),
                                )
                              ),
                            ],
                          ),  */
                  ),
                )
            );
          },
        ),
        SizedBox(
          height: 2.0,
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
                onChanged: (val){
                  trnSgnlFailureModel.rmrks1 = val;
                  //print('TrnSgnlFailureMod.rmrks1:' + TrnSgnlFailureMod.rmrks1);
                }

              )),
        ),

        SizedBox(height: 10.0),
        Center(
          child: CameraCls(cameraCallBack: callbackCamera,imageFile: imageFile),
          /* Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 70,
                                child: _previewImage(),
                              ),
                            ],
                          ),
                          onTap: () async {
                            _openPreviewDialogBox();
                          },
                        ),
                        Container(
                          child: GestureDetector(
                            child: Column(
                              children: <Widget>[
                                new Container(
                                    child: Image.asset(
                                      'assets/camera_icon.png',
                                      width: 90,
                                      height: 70,
                                    )),
                              ],
                            ),
                            onTap: () async {
                              _optionsDialogBox();
                            },
                          ),
                        )
                      ],
                    ),
                  ), */
        ),
        SizedBox(height: 40.0),

      /*  Container(
          child: ButtonTheme(
            minWidth: 200,
            height: 50,
            child: MaterialButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                _callSaveTrnSgnlFailureWebService(trnSgnlFailureModel)
                    .then((res) {
                  if (res == 'Record Successfully Saved.') {
                    print('Record Successfully Saved.');
                    TiUtilities.showOKDialog(context, "Success!!")
                        .then((res1) {
                      Navigator.pushNamed(context, '/sgnl_failure');
                    });
                  } else {
                    print(
                        'Problem in Sign On. Please Contact to Supervisor');
                  }
                });
                }
              },
              textColor: Colors.white,
              color: Colors.teal,
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.save_outlined),
                  Text(
                    "Save & Next",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      */

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
    );
  }

  Future<String> _callSaveTrnSgnlFailureWebService(
      TrnSgnlFailureModel trnsgnlfailure) async {
    //log.d(alpa);
    print('Inside Callservuce');

    trnSgnlFailureModel.inspID = TiUtilities.inspmstr.inspid;

    String urlInputString = json.encode(trnsgnlfailure.toJson());

    print("urlInputString:" + urlInputString);

    // var data = await http.get(Uri.parse("http://172.16.4.58:8080/DemoService/webapi/demoservice/SttnInspPost"));
    var url= TiConstants.webServiceUrl +'savetrnsgnlfailure';
      final response = await http.post(Uri.parse(url),
        headers: TiConstants.headerInput,
        body: urlInputString,
        encoding: Encoding.getByName("utf-8"));

    print('jsonRes' + response.body);

    log.d("response code = " + response.statusCode.toString());

    if (response == null || response.statusCode != 200) {
      throw new Exception(
          'HTTP request failed, statusCode: ${response?.statusCode}');
    } else {
      log.d("json result----- = " + response.toString());
      return 'Record Successfully Saved.';
    }

  }


}

