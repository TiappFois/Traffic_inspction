import 'dart:io';

class TrnSgnlFailureModel{
  List<String> sList1 = [] ;
  List ynList1 = [];
  List whyNoRsn = [];
  String rmrks1 = "" ;
  String registerNumb = "#2#" ;
  String inspID = "" ;
    String base64Image = null ;
  bool status  = false;


  TrnSgnlFailureModel(this.sList1,this.ynList1,this.whyNoRsn,this.rmrks1);

  /* static TrnSgnlFailureModel getData() {

    return TrnSgnlFailureModel([CheckBoxListModel('1.Speed Restriction info',false),
                               CheckBoxListModel('2.Message  Display  on Notice Board',false)
                              ],

     static void postData(TrnSgnlFailureModel dt) {
     print('Helo2');
     print(dt.cList[0].check);
     print(dt.rmrks);
     print('Helo4');
  } */


  Map<String, dynamic> toJson() => {

                                    "status" : status,
"sList1" : sList1,
                                    "ynList1": ynList1,
                                    "whyNoRsn":whyNoRsn,
                                    "rmrks1": rmrks1,
                                    "registerNumb":registerNumb,
                                    "inspID":inspID,
    "base64Image" : base64Image
  };

}
