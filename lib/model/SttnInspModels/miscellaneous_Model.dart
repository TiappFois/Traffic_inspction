import 'dart:io';

class MiscellaneousModel {
  List<String> sList1 = [] ;
  List ynList1 = [];
  List whyNoRsn = [];
  String rmrks1 = "" ;
  String registerNumb = "#33#" ;
  String inspID = "" ;
    String base64Image = null ;
  bool status  = false;

  MiscellaneousModel(this.sList1,this.ynList1,this.whyNoRsn,this.rmrks1);

  Map<String, dynamic> toJson() => { "status" : status,
"sList1" : sList1,
    "ynList1": ynList1,
    "whyNoRsn":whyNoRsn,
    "rmrks1": rmrks1,
    "registerNumb":registerNumb,
    "inspID":inspID,
    "base64Image" : base64Image
  };

}
