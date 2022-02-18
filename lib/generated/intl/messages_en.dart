// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(accilistlang) => "${Intl.select(accilistlang, {'MaintofAcciReg': 'Proper maintenance of  Accident Register', 'Properdatafeeding': 'Proper data feeding in Register by SS/SM', 'PunishmentonEnquiry': 'Punishment on Enquiry', 'other': 'Miscellaneous', })}";

  static m1(attndListlang) => "${Intl.select(attndListlang, {'MainteAsperRoster': 'Maintenance of register As per Roster', 'Longabsentness': 'Long absentness /habitual sick with Action', 'OverwritingEra': 'Any Overwriting/Erasing', 'ClosingAttendreg': 'Closing of Attendance register by In charge', 'other': 'Miscellaneous', })}";

  static m2(cautOrdListlang) => "${Intl.select(cautOrdListlang, {'SpeedRestrictioninfo': 'Speed Restriction info', 'MessageDisplayonNoticeBoard': 'Message  Display  on Notice Board', 'other': 'Miscellaneous', })}";

  static m3(sgnlFaillang) => "${Intl.select(sgnlFaillang, {'MonthlySumofFailbySS': 'Monthly Summary of Failures by SS', 'RelayRoomKeycheck': 'Relay Room Key check', 'DoubleLockofRelayRoom': 'Double Lock of Relay Room', 'RelayRoomHistory': 'Relay  Room History', 'ReasontoOpenRRoom': 'Reason to Open Relay Room by S&T', 'other': 'Miscellaneous', })}";

  static m4(lang) => "${Intl.select(lang, {'caution_or_reg': 'Caution Order Register', 'trn_sgnl_failure': 'Train Signal  Failure Register', 'sgnl_failure': 'Signal  Failure Register', 'mnth_ST_failure': 'Month wise S&T failures', 'crank_hndl_reg': 'Crank Handle Registe', 'recon_discon_Reg': 'Connect & Recoonect memo register', 'bioData_Reg': 'Bio Data Register of operating staff', 'Station_Inspect_Reg': 'Station Inspection Register', 'Safty_meet_reg': 'Safety Meeting Register', 'Night_insp_reg': 'Night Inspection Register', 'over_time_reg': 'Overtime Register', 'accident_reg': 'Accident  Register', 'staff_grv_reg': 'Staff Grievance Register', 'axle_counter_reg': 'Axle Counter Register', 'fog_reg_griv': 'Fog Signal Register', 'dsl_dttn_reg': 'Diesel Detention Register', 'Stbl_load_reg': 'Stabled Load register', 'Sick_vech_reg': 'Sick Vehicle register', 'emrg_cross_over_reg': 'Emergency Cross-over register', 'attendance_reg': 'Attendance  Register', 'Sttn_wrkg_rule_reg': 'Station Working Rule  Register', 'sttn_mstr_diary': 'Station Master Diary', 'Failure_Memo_book': 'Failure Memo book ', 'Essen_Safet_Equip': 'Essential Safety Equipments', 'Rule_book_Manul': 'Rule book & Manuals', 'Safety_cir_Bulletin': 'Safety Circulars/ Safety Bulletins File', 'First_Aid_Box_Stret': 'First Aid Box & Stretcher', 'Pub_complnt_Book': 'Public Complaint Book', 'Panel_countr_Reg': 'Panel Counter Register', 'Power_traf_blck_reg': 'Power & Traffic Block register', 'Priv_Number_Book': 'Private Number Book', 'Point_Joint_insp_Reg': 'Point and Crossing Joint inspection Register', 'Miscellaneous': 'Miscellaneous', 'other': 'Miscellaneous', })}";

  static m5(trnSgnlFaillang) => "${Intl.select(trnSgnlFaillang, {'CertionFirstPage': 'Certificate on First Page', 'IrregwithAdjstation': 'Irregularity with Adjoining station', 'FailureDesc': 'Failure Description', 'other': 'Miscellaneous', })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "EnterLoginID" : MessageLookupByLibrary.simpleMessage("Enter Login ID"),
    "Helpdesk" : MessageLookupByLibrary.simpleMessage("Helpdesk"),
    "Home" : MessageLookupByLibrary.simpleMessage("Home"),
    "Howto" : MessageLookupByLibrary.simpleMessage("How to"),
    "Login" : MessageLookupByLibrary.simpleMessage("Login"),
    "PleaseEnterPassword" : MessageLookupByLibrary.simpleMessage("Please Enter Password"),
    "accilistlang" : m0,
    "attndListlang" : m1,
    "cautOrdListlang" : m2,
    "cautOrdTitle" : MessageLookupByLibrary.simpleMessage("Caution Order Register"),
    "resetPassword" : MessageLookupByLibrary.simpleMessage("reset Password?"),
    "sgnlFaillang" : m3,
    "sttnInspList" : m4,
    "sttnInspTitle" : MessageLookupByLibrary.simpleMessage("Station Inspection"),
    "trnSgnlFaillang" : m5,
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome")
  };
}
