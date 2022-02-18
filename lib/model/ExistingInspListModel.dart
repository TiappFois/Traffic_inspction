class ExistingInspListModel {

  bool   status  = false;
  String    userid   = "" ;
  String    inspcont="";
  List startDates = [];
  List locations = [];
  List gpslocations = [];
  List examtype = [];
  List inspIDs = [];
  List cinsplist = [];


  ExistingInspListModel(this.status,this.userid,this.inspcont,this.startDates,this.locations,this.gpslocations,this.examtype,this.inspIDs,this.cinsplist);

  Map<String, dynamic> toJson() => { "status" : status,
    "userid" : userid ,
    "inspcont" : inspcont ,
    "startDates" : startDates,
    "locations": locations,
    "gpslocations":gpslocations,
    "examtype":examtype,
    "inspIDs" : inspIDs,
    "cinsplist":cinsplist
  };

}