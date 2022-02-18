import 'dart:io';

class MnthSTFailureModel{
  String month = "" ;
  String ftype = "" ;
  String fcount = "" ;
  String rmrks1 = "" ;
  String registerNumb = "#4#" ;
  String inspID = "" ;
    String base64Image = null ;
  bool status  = false;

  MnthSTFailureModel(this.month,this.ftype,this.fcount,this.rmrks1);

  /* static MnthSTFailureModel getData() {

    return MnthSTFailureModel([CheckBoxListModel('1.Speed Restriction info',false),
                               CheckBoxListModel('2.Message  Display  on Notice Board',false)
                              ],

     static void postData(MnthSTFailureModel dt) {
     print('Helo2');
     print(dt.cList[0].check);
     print(dt.rmrks);
     print('Helo4');
  } */

  Map<String, dynamic> toJson() => {"status" : status,
    "month" : month,
    "ftype": ftype,
    "fcount":fcount,
    "rmrks1": rmrks1,
    "registerNumb":registerNumb,
    "inspID":inspID,
    "base64Image" : base64Image
  };

}
