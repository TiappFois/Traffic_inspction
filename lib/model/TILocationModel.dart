import 'dart:io';

class TILocModel{
  String GPSLoc = "" ;
  String UserLoc = "" ;
  String InspSubType = "" ;

  TILocModel(this.GPSLoc,this.UserLoc,this.InspSubType);

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

  Map<String, dynamic> toJson() => {

  };


}

