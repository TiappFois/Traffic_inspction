import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ti/commonutils/cameracls.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/model/SttnInspModels/sttnInspDtlsList.dart';
import 'package:ti/model/SttnInspModels/stabled_load_register_model.dart';
import 'package:flutter/material.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class StableLoadRegister extends StatefulWidget {
  const StableLoadRegister({Key key}) : super(key: key);

  @override
  _StableLoadRegisterState createState() => _StableLoadRegisterState();
}

class _StableLoadRegisterState extends State<StableLoadRegister> {
  File imageFile = null ;
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  List<String> selectedItemValue = [];

  List<bool> showText;
  int gettingData = 0;
  static final log = getLogger('AccidentReg');

  static StableLoadRegisterModel stblModel;

  @override
  initState() {
    super.initState();
    _speech = stt.SpeechToText();
    getData();
  }

  Future<void> getData() async {

    print("TiUtilities.inspmstr.cinsplist: " + TiUtilities.inspmstr.cinsplist);
    if (TiUtilities.inspmstr.cinsplist.contains('#17#')) {

      try {
        print("StableLoad data");

        String urlInputString = TiUtilities.inspmstr.inspid;

        log.d("urlInputStringSgnlFailure = " + urlInputString);
        var url= TiConstants.webServiceUrl +'getStbLLoadRgtr';
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

                    for(var i = 0 ; i < jsonResult['ynList1'].length ; i++){
            jsonResult['ynList1'][i] =  jsonResult['ynList1'][i] == '' ? 'SELECT' : jsonResult['ynList1'][i] ;
          }

          showText =  await [jsonResult['ynList1'][0].toString() == 'NO' ? true : false,
            jsonResult['ynList1'][1].toString() == 'NO' ? true : false,
            jsonResult['ynList1'][2].toString() == 'NO' ? true : false];

          print("Response201" + showText.toString());

          stblModel = await new StableLoadRegisterModel(
              SttnInspDtlsList.getStableLoadList(), jsonResult['ynList1'],
              jsonResult['whyNoRsn'],
              jsonResult['rmrks1'].toString());

          for (int i = 0; i < 3; i++){
            selectedItemValue.add(jsonResult['ynList1'][i].toString());

          }

          for (int i = 0; i < 3; i++) whyNocontroller.add(TextEditingController());

          for (int i = 0; i < 3; i++){
            whyNocontroller[i].text = jsonResult['whyNoRsn'][i].toString();
          }

          rmrkController.text = jsonResult['rmrks1'].toString();

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
      print ("In else of Stable Load reg");

      showText = await [false, false, false];

      stblModel = await new StableLoadRegisterModel(
          SttnInspDtlsList.getStableLoadList(), ['SELECT', 'SELECT','SELECT'],
          ['', '',''],
          '');

      for (int i = 0; i < 3; i++){
        selectedItemValue.add("SELECT");
      }

      for (int i = 0; i < 3; i++) whyNocontroller.add(TextEditingController());

      for (int i = 0; i < 3; i++){
        whyNocontroller[i].text = '';
      }

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

  callbackDropDown(callBackController, selected, show) {
    setState(() {
      whyNocontroller = callBackController;
      selectedItemValue = selected;
      showText = show;
      print("Show:" + showText[0].toString());
      print('callBackController:' +
          stblModel.ynList1[0] +
          stblModel.ynList1[1] +
          whyNocontroller[0].text +
          whyNocontroller[1].text);
    });
  }

  callbackCamera(imageF) {
    setState(() {
      imageFile = imageF;
      print('callback:');
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldkey,
        appBar: TiUtilities.tiAppBar(context, "Stable Load Register"),
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
          );}}
        ),

        bottomNavigationBar: TiUtilities.tiBottomNaviBar(context, "/Sick_vech_reg"),


        floatingActionButton: FloatingActionButton.extended(

            onPressed: () async {
              int selectedCount = 0 ;
              for(var i = 0 ; i < stblModel.ynList1.length ; i++){
                if(stblModel.ynList1[i] != "SELECT"){
                  selectedCount = 1 ;
                }
                else
                  stblModel.ynList1[i] = '';

              }
              if(selectedCount == 0){
                TiUtilities.showOKDialog(context, "Please Select Atleast One Option");
              }
              else {
                String base64Image = null;

                if (imageFile != null) {
                  base64Image = base64Encode(imageFile.readAsBytesSync());
                  //print
                  String fileName = imageFile.path
                      .split("/")
                      .last;
                  log.d("fileName:" + fileName);
                }

                stblModel.base64Image = base64Image;

                stblModel.inspID = TiUtilities.inspmstr.inspid;

                if (_formKey.currentState.validate()) {
                  TiUtilities.callSttnInspEntryWebService(
                      context, json.encode(stblModel.toJson()),
                      "saveStbLLoadRgtr").then((res) {
                    if (res == 'Record Successfully Saved.') {
                      print('Record Successfully Saved.');
                      TiUtilities.showOKDialog(context, "Success!!")
                          .then((res1) {
                        Navigator.pushNamed(context, '/Sick_vech_reg');
                      });
                    } else {
                      print('Problem in Sign On. Please Contact to Supervisor');
                    }
                  });
                }
              } },
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
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: stblModel.sList1.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
              child: Tooltip(
                message: SttnInspDtlsList.getStableLoadListDtls()[index],
                child: Card(
                  child: dropdowncls(
                      dropdowntextcallback: callbackDropDown,
                      slst: stblModel.sList1,
                      ynlst: stblModel.ynList1,
                      index: index,
                      selectedItem: selectedItemValue,
                      showTextField: showText,
                      whyNoCont: whyNocontroller,
                      whyNolst: stblModel.whyNoRsn,
                      regiType: "stableloadreglang"),
                ),
              ),
            );
          },
        ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [SizedBox(
          height: 2.0,
        ),
      Expanded(
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: TextFormField(
                  controller: rmrkController,
                                      maxLength: 100,                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Remarks(if any)',

                    alignLabelWithHint: true,

                  ),
                  maxLines: 5,
                  onChanged: (val) {
                    stblModel.rmrks1 = val;
                    //print('stblModel.rmrks1:' + stblModel.rmrks1);
    })),
    )),
    new IconButton(
    onPressed: _listen,
    icon: Icon(_isListening ? Icons.mic : Icons.mic_none,
    color: Colors.black)),
    ],
    ),
        SizedBox(height: 10.0),
        Center(
          child: CameraCls(
              cameraCallBack: callbackCamera, imageFile: imageFile),
        ),
        SizedBox(height: 40.0),

      ],
    );
  }
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            rmrkController.text = val.recognizedWords;
            stblModel.rmrks1= rmrkController.text;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  Future<String> _callSaveStableLoadRegisterWebService(
      StableLoadRegisterModel cautOrdReg) async {
    //log.d(alpa);
    print('Inside Callservuce');
    String urlInputString = json.encode(cautOrdReg.toJson());
    print("urlInputString:" + urlInputString);
    // var url =
    //    ChalakdalConstants.webServiceUrl + 'saveAlpColpFpAttributesRecord';
    //log.d("url = " + url);
    //log.d("urlInputString = " + urlInputString);
    Map<String, String> headerInput = {
      "Accept": "*/*",
      "Content-Type": "application/json"

      //"application/x-www-form-urlencoded"
    };

    // var data = await http.get(Uri.parse("http://172.16.4.58:8080/DemoService/webapi/demoservice/SttnInspPost"));

    /*  final response = await http.post(Uri.parse("http://172.16.4.58:8080/DemoService/webapi/demoservice/SttnInspPost"),
        headers: headerInput,
        body: urlInputString,
        encoding: Encoding.getByName("utf-8"));

   */

    //log.d("response code = " + response.statusCode.toString());
    //var jsonRes;
    //jsonRes = json.decode(response.body);

    //print('jsonRes' + response.body);
    //log.d("response code = " + response.statusCode.toString());
    /* if (response == null || response.statusCode != 200) {
      throw new Exception(
          'HTTP request failed, statusCode: ${response?.statusCode}');
    } else {
      log.d("json result----- = " + jsonRes.toString());
      return jsonRes['vosList'][0].toString();
    }  */
    return 'Record Successfully Saved.';
  }
}
