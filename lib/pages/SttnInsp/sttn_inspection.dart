import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ti/commonutils/ti_constants.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/model/SttnInspModels/sttnInspModel.dart';
import 'package:provider/src/provider.dart';
import 'package:ti/LanguageChangeProvider.dart';
import 'package:ti/LanguageChangeProvider.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:ti/commonutils/navigation_menu.dart';
import 'package:ti/generated/l10n.dart';

import 'package:ti/model/SttnInspModels/cautionOrdRegModel.dart';
import 'caution_or_reg.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class SttnInspection extends StatefulWidget {
  @override
  _SttnInspectionState createState() => _SttnInspectionState();
}

class _SttnInspectionState extends State<SttnInspection> {
  final items = ['item1', 'item2'];
  var selectedItemValue = [];
  var pageLinks = ['caution_or_reg', 'train_failure'];
  var links;

  Future<List<String>> getData() async {
    print("In get data .");

    //var data = await http.get(Uri.parse("http://172.16.4.58:8080/DemoService/webapi/demoservice/getIt4"));
    var data = await SttnInspectionModel.getData();
    print("In get data .2");
    print(data);

    links = await SttnInspectionModel.getLinks();

    print(data.length);
    return data;
  }

  /*  @override
  void initState() {
    TiUtilities.CheckInspMstr().then((CheckInspMstrResult) {
      print("SttnInsp#List#Updated");
      setState(() {
        print("SttnInsp#List#Updated2");
      });
    });

  } */
  //final List<String> entries = SttnInspectionModel.getData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: TiUtilities.tiSttnInspListAppBar(context,  S.of(context).sttnInspTitle),
          body: Container(
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text('Loading....'),
                    ),
                  );
                } else {

                  return SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: <Widget>[

                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              //   for(int i = 0;i < snapshot.data.length ; i++ ){
                              //      selectedItemValue.add("item1");
                              // }
                              String sttninsplang = links[index];
                              return Padding(
                                padding:  EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 4.0),
                                child: Card(
                                  child: ListTile(
                                    onTap: ()  {
                                      print('/caution_or_reg:::::' +
                                          snapshot.data[index] +
                                          links[index]);

                                           Navigator.pushNamed(context, '/' + links[index]).then((_) {
                                             // This block runs when you have returned back to the 1st Page from 2nd.
                                             setState(() {
                                              print("Setstate called"); // Call setState to refresh the page.
                                             });
                                           });

                                    },
                                    title: Text(  S.of(context).sttnInspList(sttninsplang),
                                        //snapshot.data[index],
                                        style: TextStyle(
                                            fontSize: 14
                                        ) ),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.teal,
                                      child: Icon(
                                        Icons.navigate_next_outlined,
                                        color: Colors.white,
                                      ),
                                    ),

                                  ),
                                  color: TiUtilities.inspmstr.cinsplist.contains('#'+(index+1).toString()+'#') ?  Colors.cyan[100] : Colors.grey[100],
                                ),
                              );
                            }
                            ),
                        Card(
                          child: Container(
                              child: TextFormField(
                                //controller: rmrkController,
                                      maxLength: 100,                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"))
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Any Other Observation',
                                     labelStyle: TextStyle(
                                       fontSize: 14
                                     ),
                                    alignLabelWithHint: true,

                                  ),
                                  maxLines: 7,
                                  onChanged: (val){
                                    // cautionOrdMod.rmrks1 = val;
                                    //print('cautionOrdMod.rmrks1:' + cautionOrdMod.rmrks1);
                                  }
                              )),
                        ),
                        Card(
                          child: ElevatedButton(
                            child: const Text('Final Submission'),
                            onPressed: (){
                              TiUtilities.showOkDialogWithOkCancel(context, "Are you sure you want to submit ?")
                                  .then((res1) async {
                                    print("RSULT:"+res1.toString());
                                    if(res1.toString()=='YES'){

                                    String urlInputString = TiUtilities.inspmstr.inspid;

                                    print("urlInputStringcautOrdget = " + urlInputString);
                                    var url= TiConstants.webServiceUrl +'finalSave';
                                    final response = await http.post(Uri.parse(url),
                                    headers: TiConstants.headerInputText,
                                    body: urlInputString,
                                    encoding: Encoding.getByName("utf-8"));

                                    print('jsonRes' + response.body);
                                    print("response code = " + response.statusCode.toString());

                                    if (response == null || response.statusCode != 200) {
                                      throw new Exception(
                                          'HTTP request failed, statusCode: ${response?.statusCode}');
                                    } else {
                                      print("json result----- = " + response.toString());
                                      Navigator.pushNamed(context, '/user_home');

                                    }

                                    }
                               // Navigator.pushNamed(context, '/user_home');
                              });
                            },

                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          )),
    );
  }
}

class SttnInsp {
  final int index;
  final String options;

  SttnInsp(this.index, this.options);
}
