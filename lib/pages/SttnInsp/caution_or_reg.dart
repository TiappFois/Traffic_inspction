import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ti/commonutils/cameracls.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'dart:convert';
import 'package:ti/model/SttnInspModels/cautionOrdRegModel.dart';
import 'package:ti/model/SttnInspModels/sttnInspDtlsList.dart';
import 'Trn_Sgnl_Failure.dart';
import 'package:flutter/material.dart';
import 'package:ti/commonutils/logger.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/generated/l10n.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:speech_to_text/speech_to_text.dart' as stt;
class CautionOrdReg extends StatefulWidget {
  @override
  _CautionOrdRegState createState() => _CautionOrdRegState();


}

class _CautionOrdRegState extends State<CautionOrdReg> {


  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  File imageFile = null ;
  List<String> selectedItemValue = [];
  List<bool> showText;
  int gettingData = 0;
  static final log = getLogger('CautionOrder');

  static CautionOrdRegModel cautionOrdMod ;

  @override
  initState() {
    super.initState();
    _speech = stt.SpeechToText();
    getData();
  }

  Future<void> getData() async {
  print("TiUtilities.inspmstr.cinsplist: " + TiUtilities.inspmstr.cinsplist);
    if (TiUtilities.inspmstr.cinsplist.contains('#1#')) {
      String cautOrdResult;
      try {
        print("cautOrdget data");

        //String urlInputString = json.encode(urlinput);
        String urlInputString = TiUtilities.inspmstr.inspid;

        log.d("urlInputStringcautOrdget = " + urlInputString);
        var url= TiConstants.webServiceUrl +'getcautionord';
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
                      jsonResult['ynList1'][1].toString() == 'NO' ? true : false];
          print("Response201" + showText.toString());

          cautionOrdMod = await new CautionOrdRegModel(
              SttnInspDtlsList.getCautionList(), jsonResult['ynList1'],
              jsonResult['whyNoRsn'],
              jsonResult['rmrks1'].toString());

          selectedItemValue.add(jsonResult['ynList1'][0].toString());
          selectedItemValue.add(jsonResult['ynList1'][1].toString());

          for (int i = 0; i < 2; i++) whyNocontroller.add(TextEditingController());
          whyNocontroller[0].text = jsonResult['whyNoRsn'][0].toString();
          whyNocontroller[1].text = jsonResult['whyNoRsn'][1].toString();

          rmrkController.text = jsonResult['rmrks1'].toString();

          print("Response204:imageFile 1:");

          if(jsonResult['base64Image']!= null && jsonResult['base64Image'].toString() != '') {

            Uint8List bytes = base64.decode(jsonResult['base64Image']);
            String dir = (await getApplicationDocumentsDirectory()).path;
            imageFile = File(
                "$dir/" + DateTime
                    .now()
                    .millisecondsSinceEpoch
                    .toString() + ".png");
            await imageFile.writeAsBytes(bytes);
          }

          print("imageFile" );

        }
      } catch (e) {
        print("Exception" + e);
        //  inspmstrResult = 'INSP_MSTR_CHECK_FAILURE';
      }
    }
    else{
      print ("In else of caution Ord");

        showText = await [false, false];

        cautionOrdMod = await new CautionOrdRegModel(
            SttnInspDtlsList.getCautionList(), ['SELECT', 'SELECT'],
            ['', ''],
            '');
        selectedItemValue.add("SELECT");
        selectedItemValue.add("SELECT");

        for (int i = 0; i < 2; i++) whyNocontroller.add(TextEditingController());
        whyNocontroller[0].text = '';
        whyNocontroller[1].text = '';
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

  callbackDropDown(callBackController , selected , show ){
    setState(() {
      whyNocontroller = callBackController;
      //selectedItemValue = selected;
      showText = show;
      //print("Show:" + showText[0].toString());
      print('callBackController:' + cautionOrdMod.ynList1[0]+ cautionOrdMod.ynList1[1] + cautionOrdMod.whyNoRsn[0] + cautionOrdMod.whyNoRsn[1]  ) ;

    });
  }

  callbackCamera(imageF){
    setState(() {
      imageFile = imageF ;
      print('callbackimage:' ) ;
    });
  }


  @override
  Widget build(BuildContext context) {

   // for (int i = 0; i < 2; i++) {
   //   selectedItemValue.add("YES");
   // }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: new Scaffold(
        key: _scaffoldkey,
        appBar: TiUtilities.tiAppBar(context,  S.of(context).cautOrdTitle),
        body: Builder(

          builder: (BuildContext context) {
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
        bottomNavigationBar: TiUtilities.tiBottomNaviBar(context, "/trn_sgnl_failure"),

        floatingActionButton: FloatingActionButton.extended(

            onPressed: () async {
              int selectedCount = 0 ;
              for(var i = 0 ; i < cautionOrdMod.ynList1.length ; i++){
                if(cautionOrdMod.ynList1[i] != "SELECT"){
                  selectedCount = 1 ;
                }
                else
                  cautionOrdMod.ynList1[i] = '';

              }
              if(selectedCount == 0){
                TiUtilities.showOKDialog(context, "Please Select Atleast One Option");
              }
              else{

            cautionOrdMod.inspID = TiUtilities.inspmstr.inspid;

            String base64Image = null;

            if (imageFile != null) {
              base64Image = base64Encode(imageFile.readAsBytesSync());
              //print
              String fileName = imageFile.path.split("/").last;
              log.d("fileName:" + fileName);
            }

            cautionOrdMod.base64Image = base64Image;

            if (_formKey.currentState.validate()) {
              TiUtilities.callSttnInspEntryWebService(context, json.encode(cautionOrdMod.toJson()), "savecautionord").then((res) {
                if (res == 'Record Successfully Saved.') {
                  print('Record Successfully Saved.');
                  TiUtilities.showOKDialog(context, "Success!!")
                      .then((res1) {
                    Navigator.pushNamed(context, '/trn_sgnl_failure');
                  });
                } else {
                  print(
                      'Problem in Sign On. Please Contact to Supervisor');
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
          itemCount: cautionOrdMod.sList1.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 5.0, horizontal: 4.0),
              child: Tooltip(
                message: SttnInspDtlsList.getCautionListDtls()[index],
                child: Card(
                  child: dropdowncls(dropdowntextcallback: callbackDropDown,slst: cautionOrdMod.sList1,ynlst: cautionOrdMod.ynList1,index: index,selectedItem: selectedItemValue, showTextField: showText,whyNoCont: whyNocontroller,whyNolst: cautionOrdMod.whyNoRsn ,regiType: "cautOrdListlang",),

                ),
              ),
            );
          },
        ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [  SizedBox(
          height: 2.0,
        ),
        Expanded(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: TextFormField(
                controller: rmrkController,
                                      maxLength: 100,                inputFormatters: [
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
                  cautionOrdMod.rmrks1 = val;
                  //print('cautionOrdMod.rmrks1:' + cautionOrdMod.rmrks1);
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
          child: CameraCls(cameraCallBack: callbackCamera,imageFile: imageFile),

        ),
        SizedBox(height: 40.0),

     /*   Container(
          child: ButtonTheme(
            minWidth: 200,
            height: 50,
            child: MaterialButton(
              onPressed: () async {
           if (_formKey.currentState.validate()) {
             _callSaveCautionOrdRegWebService(cautionOrdMod)
                 .then((res) {
               if (res == 'Record Successfully Saved.') {
                 print('Record Successfully Saved.');
                 TiUtilities.showOKDialog(context, "Success!!")
                     .then((res1) {
                   Navigator.pushNamed(context, '/trn_sgnl_failure');
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
        )
        */
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
            cautionOrdMod.rmrks1= rmrkController.text;
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

  Future<String> _callSaveCautionOrdRegWebService(
      CautionOrdRegModel cautOrdReg) async {

    print('Inside Callservuce');

    cautOrdReg.inspID = TiUtilities.inspmstr.inspid;

      String base64Image = null;

    if (imageFile != null) { {
      base64Image = base64Encode(imageFile.readAsBytesSync());
      //print
      String fileName = imageFile.path
          .split("/")
          .last;
      log.d("fileName:" + fileName); }
    }

    cautOrdReg.base64Image = base64Image;

    String urlInputString = json.encode(cautOrdReg.toJson());

    print("urlInputString:" + urlInputString);

      //var data = await http.get(Uri.parse("http://172.16.4.58:7101/TIWebService-TrafficInspectionRest-context-root/resources/ti/myfunc"));
    var url= TiConstants.webServiceUrl +'myfunc';
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

       print('jsonRes' + response.body);

       var jsonResult = json.decode(response.body);

       log.d("json result = " + jsonResult.toString());

       TiUtilities.inspmstr.cinsplist = TiUtilities.inspmstr.cinsplist + jsonResult['registerNumb'].toString() ;
       log.d("TiUtilities.inspmstr.cinsplist 2 = " + TiUtilities.inspmstr.cinsplist);

      return 'Record Successfully Saved.';
    }

  }
}
