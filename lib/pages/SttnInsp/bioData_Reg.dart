import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/model/SttnInspModels/sttnInspDtlsList.dart';
import 'package:ti/model/SttnInspModels/bio_data_Model.dart';
import 'package:flutter/material.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/cameracls.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:ti/commonutils/logger.dart';

class BioDataReg extends StatefulWidget {
  @override
  _BioDataRegState createState() => _BioDataRegState();
}

class _BioDataRegState extends State<BioDataReg> {
  final items = ['Overdue', 'Safety camp', 'Periodical medical examination'];
  //final YNitems = ['Yes', 'No'];
  //var selectedItemValue = 'Serial';
  final rmrk = FocusNode();
  var show = false;

  File imageFile = null ;

  List<String> selectedItemValue = [];

  List<bool> showText;
  int gettingData = 0;
  static final log = getLogger('BiodataReg');

  static BioDataRegModel BioDataRegMod;

  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {

    print("TiUtilities.inspmstr.cinsplist: " + TiUtilities.inspmstr.cinsplist);
    if (TiUtilities.inspmstr.cinsplist.contains('#7#')) {

      try {
        print("Biodata data");

        String urlInputString = TiUtilities.inspmstr.inspid;

        log.d("urlInputStringSgnlFailure = " + urlInputString);
        var url= TiConstants.webServiceUrl +'getBioDataRgtr';
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
            jsonResult['ynList1'][3].toString() == 'NO' ? true : false,
            jsonResult['ynList1'][4].toString() == 'NO' ? true : false,
            jsonResult['ynList1'][5].toString() == 'NO' ? true : false,
            jsonResult['ynList1'][6].toString() == 'NO' ? true : false,
            jsonResult['ynList1'][7].toString() == 'NO' ? true : false,
            jsonResult['ynList1'][8].toString() == 'NO' ? true : false];

          print("Response201" + showText.toString());

          BioDataRegMod = await new BioDataRegModel(
              SttnInspDtlsList.getBioDataList(), jsonResult['ynList1'],
              jsonResult['whyNoRsn'],
              jsonResult['rmrks1'].toString());

          for (int i = 0; i < 9; i++){
            selectedItemValue.add(jsonResult['ynList1'][i].toString());

          }

          for (int i = 0; i < 9; i++) whyNocontroller.add(TextEditingController());

          for (int i = 0; i < 9; i++){
            whyNocontroller[i].text = jsonResult['whyNoRsn'][i].toString();
          }

          rmrkController.text = jsonResult['rmrks1'].toString();

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
      print ("In else of BioData reg");

      showText = await [false, false, false,false, false, false,false, false, false];

      BioDataRegMod = await new BioDataRegModel(
          SttnInspDtlsList.getBioDataList(), ['YES', 'YES','YES','YES', 'YES','YES','YES', 'YES','YES'],
          ['', '','','', '','','', '',''],
          '');

      for (int i = 0; i < 9; i++){
        selectedItemValue.add("YES");
      }

      for (int i = 0; i < 9; i++) whyNocontroller.add(TextEditingController());

      for (int i = 0; i < 9; i++){
        whyNocontroller[i].text = '';
      }

      rmrkController.text = '';

      print("After remarks");
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
          BioDataRegMod.ynList1[0] +
          BioDataRegMod.ynList1[1] +
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
      child: new Scaffold(
        key: _scaffoldkey,
        appBar: TiUtilities.tiAppBar(
            context, "Bio-Data Register of operating staff"),
        body: Builder(
            builder: (context){
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

        bottomNavigationBar: TiUtilities.tiBottomNaviBar(context, "/Station_Inspect_Reg"),

        floatingActionButton: FloatingActionButton.extended(

          onPressed: () async {

            BioDataRegMod.inspID = TiUtilities.inspmstr.inspid;

            String base64Image = null ;

            if (imageFile != null) {
              base64Image = base64Encode(imageFile.readAsBytesSync());
            //print
            String fileName = imageFile.path.split("/").last;
            log.d("fileName:" + fileName); }

            BioDataRegMod.base64Image = base64Image;

            if (_formKey.currentState.validate()) {
              TiUtilities.callSttnInspEntryWebService(context, json.encode(BioDataRegMod.toJson()), "saveBioDataRgtr").then((res) {
                if (res == 'Record Successfully Saved.') {
                  print('Record Successfully Saved.');
                  TiUtilities.showOKDialog(context, "Success!!")
                      .then((res1) {
                    Navigator.pushNamed(context, '/Station_Inspect_Reg');
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
    return new Column(
      children: [
  /*
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    return FocusManager.instance.primaryFocus?.unfocus();
                    //CautionOrdRegModel.postData(data);
                  },
                  title: Text('Work type', style: TextStyle(fontSize: 14)),
                  trailing: SizedBox(
                    width: 220,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          //borderRadius : const BorderRadius.all(Radius.circular(4.0)),
                          borderSide: const BorderSide(color: Colors.teal),
                        ),
                      ),
                      value: BioDataRegMod.worktype,
                      items: items.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,
                                style: TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (newSelectedValue) {
                        setState(() {
                          BioDataRegMod.worktype =
                              newSelectedValue.toString();
                          print("BioDataRegMod.worktype:" +
                              BioDataRegMod.worktype);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        */

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: BioDataRegMod.sList1.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                child: Tooltip(
                  message: SttnInspDtlsList.getBioDataListDtls()[index],
                  child: Card(
                    child: dropdowncls(
                        dropdowntextcallback: callbackDropDown,
                        slst: BioDataRegMod.sList1,
                        ynlst: BioDataRegMod.ynList1,
                        index: index,
                        selectedItem: selectedItemValue,
                        showTextField: showText,
                        whyNoCont: whyNocontroller,
                        whyNolst: BioDataRegMod.whyNoRsn,
                        regiType: "biodatalang"),
                  ),
                ));
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
                  keyboardType: TextInputType.text,
                  focusNode: rmrk,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Remarks(if any)',

                    alignLabelWithHint: true,

                  ),
                  maxLines: 5,
                  onChanged: (val) {
                    BioDataRegMod.rmrks1 = val;
                    //print('TrnSgnlFailureMod.rmrks1:' + TrnSgnlFailureMod.rmrks1);
                  })),
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

  Future<String> _callSaveTrnSgnlFailureWebService(
      BioDataRegModel biodata) async {
    //log.d(alpa);
    print('Inside Callservuce');
    String urlInputString = json.encode(biodata.toJson());
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
