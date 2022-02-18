

class InspMstrModel{

  bool      status  = false ;
  String    inspid   ="" ;
  String    userid   ="" ;
  String    examtype ="" ;
  String    strttime ="" ;
  String    endtime  ="" ;
  String    inspgpsstrtlocn  ="";
  String    inspgpsendlocn   ="";
  String    inspuserstrtlocn ="";
  String    inspuserendlocn  ="";
  String    footplactlocn    ="";
  String    examcmpl ="";
  String    inspmstrexist="";
  String    cinsplist="";
  String    inspcont="";

  InspMstrModel(
      this.status,
      this.inspid,
      this.userid,
      this.examtype,
      this.strttime,
      this.endtime,
      this.inspgpsstrtlocn,
      this.inspgpsendlocn,
      this.inspuserstrtlocn,
      this.inspuserendlocn,
      this.footplactlocn,
      this.examcmpl,
      this.inspmstrexist,
      this.cinsplist,
      this.inspcont);
}