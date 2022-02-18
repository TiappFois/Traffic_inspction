class SttnInspDtlsList {

  static List<String> getAcciList() {
    List<String> acciList = [
      'Proper maintenance of  Accident Register',
      'Proper data feeding in Register by SS/SM',
      'Punishment on Enquiry'
    ];
    return acciList;
  }

  static List<String> getAcciListDtls() {
    List<String> acciListDtls = [
      'Whether the accident register is up to date and contain all relevant particulars of accident?',
      'Whether all the columns of accident register are filled by station Master/Station Superintendent in charge?',
      'Whether punishment column of this register is filled as and when enquiry is completed?',
    ];
    return acciListDtls;
  }
  ////
  static List<String> getAttndList() {
    List<String> acciList = [
      'Maintenance of register As per Roster',
      'Long absentness /habitual sick with Action',
      'Any Overwriting/Erasing ',
      'Closing of Attendance register by In charge'
    ];
    return acciList;
  }

  static List<String> getAttndListDtls() {
    List<String> attndListDtls = [
      'Whether this register is properly maintained as per roster?',
      'Whether cases of long absentees and habitual sick are pointed out and suitable actions taken on them?',
      'Whether over writing/erasing etc. are being made?',
      'Attendance Register closing is done or not by in charge.',
    ];
    return attndListDtls;
  }
///////////////
  static List<String> getAxleList() {
    List<String> axleList = [
      'Reset number record with SM',
      'S&T staff  Signature for failure Maintenance'
    ];
    return axleList;
  }

  static List<String> getAxleListDtls() {
    List<String> axleListDtls = [
      'Whether resetting number is recorded in this register with the signature of the station master (SM)?',
      'Whether Signal and Telecommunication (S&T staff put his signature before attending axle counter failures?'
    ];
    return axleListDtls;
  }
/////////////////////
  static List<String> getBioDataList() {
    List<String> bioDataList = [
      'Name of Staff',
      'Date of Birth',
      'Date of Appointment',
      'Date of Posting at Station',
      'Date of Safety Course',
      'Date of Safety Course Due',
      'Bio data Chart',
      'Work Type',
      'Staff Competency Certificates'
    ];
    return bioDataList;
  }

  static List<String> getBioDataListDtls() {
    List<String> bioDataListDtls = [
      'Details 11',
      'Details 22',
      'Details 3e',
      'Details 112',
      'Details 223',
      'Details 35',
      'Details 117',
      'Details 229',
      'Details 30'
    ];
    return bioDataListDtls;
  }
//////////////

  static List<String> getCautionList() {
    List<String> cautionList = ['SpeedRestrictioninfo',
                                'MessageDisplayonNoticeBoard'];
    return cautionList;
  }

  static List<String> getCautionListDtls() {
    List<String> cautionListDtls = [
      'Message of speed restrictions imposed and cancelled are correctly endorsed '+
      'by the station master and repeated to the controller and Notice station '+
      'properly or not',
      'Whether each message while being repeated to the notice station, sectional '+
      'controller bear the time of receipt/dispatch along with private numbers and '+
      'name of staff receiving/dispatch the message or not'
    ];
    return cautionListDtls;
  }
  //////////////////

  static List<String> getCrankList() {
    List<String> crankList = ['Locking of Motor Point and Key with SM',
      'Locking of Crank Handle if Not in Use' ,
      'Crank Handle Entry with SM and ESM signature'];
    return crankList;
  }

  static List<String> getcrankListDtls() {
    List<String> crankListDtls = [
      'Whether motor point machine covers are locked properly and keys kept with SM on duty?',
      'Whether crank handle is in locked condition when not in use?',
      'Whether for each use of crank handle is correctly entered with signature of Station Master & ESM? '
    ];
    return crankListDtls;
  }////////////////

  static List<String> getDieselList() {
    List<String> dieselList = [
      'Record of working of Diesel engine by SS/SM',
      'Efficient Utilization of engine'
    ];
    return dieselList;
  }

  static List<String> getDieselListDtls() {
    List<String> dieselListDtls = [
      'Whether all particulars regarding working of engine is recorded in this register by the Station Master correctly?',
      'Whether the entries in this register are indicating that engine is being utilized efficiently?'
    ];
    return dieselListDtls;
  }//////////////////////////////

  static List<String> getEmerCrossList() {
    List<String> emerCrossList = [
      'Regular test for emergency cross over',
      'Exchange of Private number to Switch/Cabin Man',
      'Proper testing records '
    ];
    return emerCrossList;
  }

  static List<String> getEmerCrossListDtls() {
    List<String> emerCrossListDtls = [
      'Whether emergency cross over is tested regularly?',
      'When points are operated from end cabins, whether Station Master exchanges private numbers with Switch man/Cabin Man to this effect?',
      'Whether all the particulars of testing are recorded in this register correctly?'
    ];
    return emerCrossListDtls;
  }///////////////////////////////

  static List<String> getEssnSafeList() {
    List<String> essnSafeList = [
      'Availability of Safety instrument in Office of SM',
      'Working condition of Equipments'
    ];
    return essnSafeList;
  }

  static List<String> getEssnSafeListDtls() {
    List<String> essnSafeListDtls = [
      'The Essential Safety Equipments kept in the office of Station Master or in the Power Cabin are as per Station Working Rules.',
      'Whether all equipment’s are in proper working order or not?'
    ];
    return essnSafeListDtls;
  }
  //////////////////////////////////////

  static List<String> getFailMemoList() {
    List<String> failMemoList = [
      'Prompt Issue of gear /signal in case of Failure',
      'Acknowledgement from S&T staff on record foil',
      'Cross check with Failure register',
      'Cross check with Connect and Disconnect  memos',
      'To Check defective signal for Irregularities'
    ];
    return failMemoList;
  }

  static List<String> getFailMemoListDtls() {
    List<String> failMemoListDtls = [
      'Whether in case of any failure of gear or signals; it is issued promptly to the S&T official?',
      'Whether the acknowledgment of the S&T staff is obtained on the record foil?',
      'Whether it is cross checked with failure register?',
      'Whether it is cross checked with disconnection / reconnection memos ?',
       'Whether it is cross checked with authority to pass defective signal to find out irregularities?'

    ];
    return failMemoListDtls;
  }
  ////////////////////////
  static List<String> getFirstAidList() {
    List<String> firstAidList = [
      'Availability of Medicine as per Prescribed list ',
      'Record of  treatment  in Injury Card',
      'Working condition of Stretcher',
      'Display of Qualified First Aid staff'
    ];
    return firstAidList;
  }

  static List<String> getFirstAidListDtls() {
    List<String>firstAidListDtls = [
      'Whether the medicines and other materials are in conformity with the prescribed list',
      'Whether the particulars regarding the treatment are recoded in the injury card, in case of any use or not',
      'Whether stretcher available is in working order or not',
      'List of qualified first aid staff is displayed or not'
    ];
    return firstAidListDtls;
  }
  /////////////////////////////////
  static List<String> getfogSgnlList() {
    List<String> fogSgnlList = [
      'Maintenance of Part 1-4',
      'Signalman  Assurance by SS/SM',
      'Knowledge about Detonator to Staff',
      'Testing of Detonator',
      'Sufficient stock of Detonator'
    ];
    return fogSgnlList;
  }

  static List<String> getfogSgnlListDtls() {
    List<String> fogSgnlListDtls = [
      'Whether part-I, part- II, part-III, and part- IV of the register are maintained properly?',
      'Whether assurance of the fog signalman is taken periodically by Station Master?',
      'Whether knowledge of the staff regarding the use of detonator is satisfactory?',
      'Whether particulars of used and testing of detonators are available in part (iv) of the register?',
      'Whether the stock of detonators is sufficient to meet the requirement?'
    ];
    return fogSgnlListDtls;
  }
  //////////////////////
  static List<String> getMiscList() {
    List<String> miscList = [
      'Availability of Fire extinguisher refill and expiry date',
      'Display of List of Nearby Hospital',
      'Record of particular about Hot Axle register',
      'Acknowledgment of staff for  safety counselling  ',
      'Reconciliation of Station Clock at 16 hours  with Section controller'
    ];
    return miscList;
  }

  static List<String> getmiscListDtls() {
    List<String> miscListDtls = [
      'Availability of Fire extinguisher refill and expiry date',
      'Display of List of Nearby Hospital',
      'Record of particular about Hot Axle register',
      'Acknowledgment of staff for  safety counselling  ',
      'Reconciliation of Station Clock at 16 hours  with Section controller'
    ];
    return miscListDtls;
  }
  //////////////////////////
  static List<String> getMnthSnTList() {
    List<String> mnthSnTList = [
      'Name of Staff',
      'Date of Birth',
      'Date of Appointment',
      'Date of Posting at Station',
      'Date of Safety Course',
      'Date of Safety Course Due',
      'Bio data Chart',
      'Monthly Summary',
      'Staff Competency Certificates'
    ];
    return mnthSnTList;
  }

  static List<String> getMnthSnTListDtls() {
    List<String> mnthSnTListDtls = [
      'Name of Staff',
      'Date of Birth',
      'Date of Appointment',
      'Date of Posting at Station',
      'Date of Safety Course',
      'Date of Safety Course Due',
      'Bio data Chart',
      'Monthly Summary',
      'Staff Competency Certificates'
    ];
    return mnthSnTListDtls;
  }
  //////////////////////////
  static List<String> getNghtList() {
    List<String> nghtList = [
      'Four Night Inspection by SS/SM  in a Month',
      'Night Inspection conducted once in a Week',
      'Night Inspection by SS as quotas',
      'Night Inspection by 00:00 -04:00 hours',
      'Raising of any Irregularities by SS'
    ];
    return nghtList;
  }

  static List<String> getNghtListDtls() {
    List<String> nghtListDtls = [
      'Are four night inspections conducted monthly by Station Master/Station Superintendent in charge and detail particulars of night inspection are entered in it or not',
      'Whether night inspection is conducted once in a week or not',
      'Whether night inspection is conducted by SS as quotas',
      'Whether night inspection is conducted for 00:00 -04:00 hours',
      'Whether Irregularities raised by SS or not'
    ];
    return nghtListDtls;
  }
  /////////////////////
  static List<String> getOverTimeList() {
    List<String> overTimeList =  ['Maintenance of OT register by SM',
      'Reason for OT',
    'Time Register'];
    return overTimeList;
  }

  static List<String> getOverTimeListDtls() {
    List<String> overTimeListDtls =  ['It the Staff Overtime Register is maintained properly for the additional duty against duty roster done by Station Master is entered in it or not.',

    'Whether reasons for regular over time working are analyzed and suitable action taken or not?',
      'Time Register'

    ];
    return overTimeListDtls;
  }

  //////////////////////////
  static List<String> getPanelCounterList() {
    List<String> panelCounterList = ['Matching of counter reading with counter register '];
    return panelCounterList;
  }

  static List<String> getPanelCounterListDtls() {
    List<String> panelCounterListDtls = [
      'Are all the counter reading is matching with entries in  counter register or not'
    ];
    return panelCounterListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getPointCrossList() {
    List<String> pointCrossList = [
      'Joint Point and Crossing Inspection date',
      'Compliance by S&T and ENGG.',
      'Misc Inspection',
      'Staff Counselled',
      'Irregularities Noticed',
      'Working of SM/TNC/Pointsmen'
    ];
    return pointCrossList;
  }

  static List<String> getPointCrossListDtls() {
    List<String> pointCrossListDtls = [
      'Joint Point and Crossing Inspection date',
      'Compliance by S&T and ENGG.',
      'Misc Inspection',
      'Staff Counselled',
      'Irregularities Noticed',
      'Working of SM/TNC/Pointsmen'
    ];
    return pointCrossListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getPowerTrafficList() {
    List<String> powerTrafficList = ['Proper Maintenance of traffic block register'];
    return powerTrafficList;
  }

  static List<String> getPowerTrafficListDtls() {
    List<String> powerTrafficListDtls = ['Are all the entries in traffic block register are properly maintain or not'];
    return powerTrafficListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getPrivateNumbList() {
    List<String> privateNumbList = [
      'Maintenance of  Private number',
      'Recording Reason for private number ',
      'Cancellation of Balance private number by End of Day'
    ];
    return privateNumbList;
  }

  static List<String> getPrivateNumbListDtls() {
    List<String> privateNumbListDtls = [
      'Is the private number book is properly maintain.',
      'Purpose for which private no used is properly recorded or not',
      'Balance private numbers in the columns at the end of the day are canceled or not.'
    ];
    return privateNumbListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getPublicCompList() {
    List<String> publicCompList = ['Maintenance of public complaint book ',
      'Punishment on Enquiry'];
    return publicCompList;
  }

  static List<String> getPublicCompListDtls() {
    List<String> publicCompListDtls = ['Whether public complaint book properly maintained or not ',
      'Punishment on Enquiry'];
    return publicCompListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getReconDisconList() {
    List<String> reconDisconList = [
      'Memo Register with SM on Duty',
      'Signal Gear Maintenance Record  with SM on Duty',
      'Verification of  Entry in Connect/ Disconnect Memo',
      'Authorization of Memo by Maintenance staff indicating points /Singal affected',
      'Memo Pasting in Register serially'
    ];
    return reconDisconList;
  }

  static List<String> getReconDisconListDtls() {
    List<String> reconDisconListDtls = [
      'Is the register is kept in the office of the Station Master on duty or not',
      'When any signal or signals gear required to be maintained by S&T officials, they give information to the Station Master on duty, who made entries in it after exchanging private numbers with concerned adjoining stations/cabins where available and obtains permission from sectional control.',
      'Whether all entries are filled correctly in Disconnection/ Reconnection memo? ',
      'Whether memos are issued by an authorized maintenance staff, on the proper form indicating the points/Signals to be affected? ',
      'Are the memos pasted, separately in a register and serially numbered month wise?'
    ];
    return reconDisconListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getRuleBookList() {
    List<String> ruleBookList = [
      'Availability of all rule book and Manual',
      'Pasting of latest Correction Slips',
      'Acknowledgment of Staff for Amendment slips'
    ];
    return ruleBookList;
  }

  static List<String> getRuleBookListDtls() {
    List<String> ruleBookListDtls = [
      'Whether all rule books and manuals regarding train operation are available',
      'Whether all rule books and manuals regarding train operation are pasted with latest correction slips or not',
      'Whether acknowledgment of staff is obtained for amendment slips issued in these books or not',

    ];
    return ruleBookListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getSafetyCircularList() {
    List<String> safetyCircularList = [
      'Availability of all Safety circular and bulletins',
      'Acknowledgment from Staff',
      'Explanation of circulars to Staff',
      'Display of Safety Poster / charts in SM office/Cabins'
    ];
    return safetyCircularList;
  }

  static List<String> getSafetyCircularListDtls() {
    List<String> safetyCircularListDtls = [
      'Whether safety circulars/bulletins are regularly received and filed properly and acknowledgment of staff obtained or not ',
      'Whether acknowledgment of staff obtained or not ',
      'Whether these circulars are being read and explained to staff?',
      'Whether safety poster and charts are displayed inside SMS office/ cabins.'
    ];
    return safetyCircularListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getSafetyMeetingList() {
    List<String> safetyMeetingList = [
      'Meeting on Scheduled Days by Staff',
      'Identification of Absent Staff',
      'Acknowledgement of Staff  for Meeting'
    ];
    return safetyMeetingList;
  }

  static List<String> getSafetyMeetingListDtls() {
    List<String> safetyMeetingListDtls = [
      'Whether meetings are regularly held on the nominated days and attended by staff of all branches connected with train operations?',
      'Whether staff persistently absenting from such meetings are identified and counseled?',
      'Whether acknowledgment of staff attending the safety meetings is obtained?'
    ];
    return safetyMeetingListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getSignalFailList() {
    List<String> signalFailList = [
      'MonthlySumofFailbySS',
      'RelayRoomKeycheck',
      'DoubleLockofRelayRoom',
      'RelayRoomHistory',
      'ReasontoOpenRRoom'
    ];
    return signalFailList;
  }

  static List<String> getSignalFailListDtls() {
    List<String> signalFailListDtls = [
      'Whether summary of failures is made out monthly by SS after last entry of the month or not',
      'Whether Relay Room Key Register is properly maintained and Kept in the office of the Station Master (SM) on duty.',
      'Is the Relay room is double lock or not',
      'Whether the transactions of every opening and closing of the relay room are entered in the register and properly signed by SM on duty and S&T staff?',
      'Whether the purpose of keys taken by S&T staff clearly mentioned by the S&T staff?'
    ];
    return signalFailListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getSickVehicleList() {
    List<String> sickVehicleList = [
      'Record of Sick detached Vehicle',
      'Prompt Attention by Carriage and Wagon Staff',
      'After Fit Clearance by Carriage and Wagon staff'
    ];
    return sickVehicleList;
  }

  static List<String> getSickVehicleListDtls() {
    List<String> sickVehicleListDtls = [
      'Whether the particulars of all the sick vehicles detached at the station are recorded correctly?',
      'Whether Carriage and Wagon staff attends the defects promptly?',
      'Whether the vehicles are cleared promptly after these are made fit by the Carriage and Wagon staff?'
    ];
    return sickVehicleListDtls;
  }
//////////////////////////

  //////////////////////////
  static List<String> getStableLoadList() {
    List<String> stableLoadList = [
      'Use of Safety chains and skids for Stable Load',
      'Private No. Exchange between SM cabin Crew',
      'Action for Early Clearance'
    ];
    return stableLoadList;
  }

  static List<String> getStableLoadListDtls() {
    List<String> stableLoadListDtls = [
      'Whether vehicles are secured properly by using safety chains, skids, hand brakes?',
      'Whether private numbers are exchanged shift wise between Station Master and Cabin In charge and recorded properly with Red ink in case of running line?',
      'Whether suitable actions are taken for early clearance?'
    ];
    return stableLoadListDtls;
  }
//////////////////////////
  //////////////////////////
  static List<String> getStaffGrievList() {
    List<String> staffGrievList = [
      'Record of Grievance',
      'Record of Welfare officer visit',
      'Suitable Action taken by WO'
    ];
    return staffGrievList;
  }

  static List<String> getStaffGrievListDtls() {
    List<String> staffGrievListDtls = [
      'Whether grievance of staff regarding leave, wages, increment and payment of overtime arrears are properly recorded?',
      'Whether the welfare inspector visits the station regularly and takes note of grievances of the staff?',
      'Are suitable actions taken on the grievances recorded in the register?'
    ];
    return staffGrievListDtls;
  }
//////////////////////////
  //////////////////////////
  static List<String> getSttnInspRegList() {
    List<String> sttnInspRegList = ['Follow up Action  Recorded  on Previous Inspection by SM',
      'Noticed Irregularities Highlighted by TI',
      'Provision of separate Inspection Register for Officers and supervisors',
      'Acknowledgement of Inspection Report by All  Staff'];
    return sttnInspRegList;
  }

  static List<String> getSttnInspRegListDtls() {
    List<String> sttnInspRegListDtls = ['Whether follow up action is recorded against each item of previous inspections by SM? ',
      'Whether irregularities noticed are highlighted by the inspecting official',
      'Are different inspection registers maintained separately for officers & supervisors? ',
      'Whether all staff concerned have gone through the inspection reports and acknowledged them? '];
    return sttnInspRegListDtls;
  }
//////////////////////////
  //////////////////////////
  static List<String> getSttnMasterList() {
    List<String> sttnMasterList = [
      'Pages are in serial order',
      'Hand over Taken over ',
      'Entry of Line position Stable Load ',
      'Entry of Traffic   power block',
      'Last Private number used'
    ];
    return sttnMasterList;
  }

  static List<String> getSttnMasterListDtls() {
    List<String> sttnMasterListDtls = [
      'Whether pages are serially numbered?',
      'Whether handing over & taking over of charge is properly done and relevant entries are made in the register?',
      'Whether line position, stabled loads are recorded ',
      'Whether entry of Traffic power block done?',
      'Whether last Private number used recoded'
    ];
    return sttnMasterListDtls;
  }
//////////////////////////
  //////////////////////////
  static List<String> getSttnWrkngRuleList() {
    List<String> sttnWrkngRuleList = [
      'Record of rule change date, Last date of revision',
      'Availability of station working Diagram',
      'Conformity of SWR  in Actual Lay out '
    ];
    return sttnWrkngRuleList;
  }

  static List<String> getSttnWrkngRuleListDtls() {
    List<String> sttnWrkngRuleListDtls = [
      'Whether date of issue and date brought into force: last date of revision, number of correction slips issued after the last revision and validity are correct or not',
      'Whether Station Working Rule Diagram of station is available in the Station Working Rules',
      'Whether Station Working Rule Diagram of station confirms to the actual lay out?'
    ];
    return sttnWrkngRuleListDtls;
  }
//////////////////////////
  //////////////////////////
  static List<String> getTrnSgnlFailList() {
    List<String> trnSgnlFailList = [
      'CertionFirstPage',
      'IrregwithAdjstation',
      'FailureDesc'
    ];
    return trnSgnlFailList;
  }

  static List<String> getTrnSgnlFailListDtls() {
    List<String> trnSgnlFailListDtls = [
      'Certificate given on first page or not',
      'Any irregularities find during checking entries cross checked with adjoining stations',
      'Train number and description found correct or not'
    ];
    return trnSgnlFailListDtls;
  }
//////////////////////////



}
