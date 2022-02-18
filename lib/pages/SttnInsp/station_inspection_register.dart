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
import 'package:ti/model/SttnInspModels/station_inspection_registerModel.dart';
import 'package:ti/model/SttnInspModels/sttnInspDtlsList.dart';

import 'dart:convert';
import 'package:ti/model/SttnInspModels/cautionOrdRegModel.dart';
import 'Trn_Sgnl_Failure.dart';
import 'package:flutter/material.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/logger.dart';

class SttnInspReg extends StatefulWidget {
  @override
  _SttnInspRegState createState() => _SttnInspRegState();
}

class _SttnInspRegState extends State<SttnInspReg> {

  File imageFile = null ;

  List<String> selectedItemValue = [];

  List<bool> showText;
  int gettingData = 0;
  static final log = getLogger('SttnInspReg');

  static SttnInspRegModel sttnInspRegMod;

  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {

    print("TiUtilities.inspmstr.cinsplist: " + TiUtilities.inspmstr.cinsplist);
    if (TiUtilities.inspmstr.cinsplist.contains('#8#')) {

      try {
        print("SttnInspReg data");

        String urlInputString = TiUtilities.inspmstr.inspid;

        log.d("urlInputStringSttnInspReg = " + urlInputString);
        var url= TiConstants.webServiceUrl +'getSttnInspRgtr';
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
            jsonResult['ynList1'][2].toString() == 'NO' ? true : false,
            jsonResult['ynList1'][3].toString() == 'NO' ? true : false];

          print("Response201" + showText.toString());

          sttnInspRegMod = await new SttnInspRegModel(
              SttnInspDtlsList.getSttnInspRegList(), jsonResult['ynList1'],
              jsonResult['whyNoRsn'],
              jsonResult['rmrks1'].toString());

          for (int i = 0; i < 4; i++){
            selectedItemValue.add(jsonResult['ynList1'][i].toString());
          }

          for (int i = 0; i < 4; i++) whyNocontroller.add(TextEditingController());

          for (int i = 0; i < 4; i++){
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
      print ("In else of SttnInsp reg");

      showText = await [false, false, false,false];

      sttnInspRegMod = await new SttnInspRegModel(
          SttnInspDtlsList.getSttnInspRegList(), ['YES', 'YES','YES','YES'],
          ['', '','',''],
          '');

      for (int i = 0; i < 4; i++){
        selectedItemValue.add("YES");
      }

      for (int i = 0; i < 4; i++) whyNocontroller.add(TextEditingController());

      for (int i = 0; i < 4; i++){
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

  callbackDropDown(callBackController , selected , show ){
    setState(() {
      whyNocontroller = callBackController;
      selectedItemValue = selected;
      showText = show;
      print("Show:" + showText[0].toString());
      print('callBackController:' + sttnInspRegMod.ynList1[0]+ sttnInspRegMod.ynList1[1] + whyNocontroller[0].text + whyNocontroller[1].text) ;
    });
  }

  callbackCamera(imageF){
    setState(() {
      imageFile = imageF ;
      print('callback:' ) ;
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: new Scaffold(
        key: _scaffoldkey,
        appBar: TiUtilities.tiAppBar(context, "Station Inspection Register"),
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

        bottomNavigationBar: TiUtilities.tiBottomNaviBar(context, "/Safty_meet_reg"),


        floatingActionButton: FloatingActionButton.extended(

          onPressed: () async {

            String base64Image = null ;

            if (imageFile != null) {
              base64Image = base64Encode(imageFile.readAsBytesSync());
            //print
            String fileName = imageFile.path.split("/").last;
            log.d("fileName:" + fileName); }

            sttnInspRegMod.base64Image = base64Image;

            sttnInspRegMod.inspID = TiUtilities.inspmstr.inspid;

            if (_formKey.currentState.validate()) {
              TiUtilities.callSttnInspEntryWebService(context, json.encode(sttnInspRegMod.toJson()), "saveSttnInspRgtr").then((res) {
                if (res == 'Record Successfully Saved.') {
                  print('Record Successfully Saved.');
                  TiUtilities.showOKDialog(context, "Success!!")
                      .then((res1) {
                    Navigator.pushNamed(context, '/Safty_meet_reg');
                  });
                } else {
                  print('Problem in Sign On. Please Contact to Supervisor');
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
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: sttnInspRegMod.sList1.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 5.0, horizontal: 4.0),
              child: Tooltip(
                message: SttnInspDtlsList.getSttnInspRegListDtls()[index],
                child: Card(
                  child: dropdowncls(dropdowntextcallback: callbackDropDown,
                      slst: sttnInspRegMod.sList1,
                      ynlst: sttnInspRegMod.ynList1,
                      index: index,
                      selectedItem: selectedItemValue,
                      showTextField: showText,
                      whyNoCont: whyNocontroller,
                      whyNolst: sttnInspRegMod.whyNoRsn,
                      regiType: "sttninspreglang"),

                ),
              ),
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

                  ),
                  maxLines: 5,
                  onChanged: (val){
                    sttnInspRegMod.rmrks1 = val;
                    //print('cautionOrdMod.rmrks1:' + cautionOrdMod.rmrks1);
                  }
              )),
        ),

        SizedBox(height: 10.0),
        Center(
          child: CameraCls(cameraCallBack: callbackCamera,imageFile: imageFile),

        ),
        SizedBox(height: 40.0),

      ],
    );

  }

  Future<String> _callSaveCautionOrdRegWebService(
      SttnInspRegModel sttninspreg) async {
    //log.d(alpa);
    print('Inside Callservuce');
    String urlInputString = json.encode(sttninspreg.toJson());
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


    return 'Record Successfully Saved.';
  }
}
