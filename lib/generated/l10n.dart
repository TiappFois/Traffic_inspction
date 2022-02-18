// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `{lang, select, caution_or_reg {Caution Order Register}  trn_sgnl_failure {Train Signal  Failure Register} sgnl_failure {Signal  Failure Register} mnth_ST_failure {Month wise S&T failures} crank_hndl_reg {Crank Handle Registe} recon_discon_Reg {Connect & Recoonect memo register} bioData_Reg {Bio Data Register of operating staff} Station_Inspect_Reg {Station Inspection Register} Safty_meet_reg {Safety Meeting Register} Night_insp_reg {Night Inspection Register} over_time_reg {Overtime Register} accident_reg {Accident  Register}  staff_grv_reg {Staff Grievance Register} axle_counter_reg {Axle Counter Register}  fog_reg_griv {Fog Signal Register} dsl_dttn_reg {Diesel Detention Register}  Stbl_load_reg {Stabled Load register} Sick_vech_reg {Sick Vehicle register} emrg_cross_over_reg {Emergency Cross-over register} attendance_reg {Attendance  Register} Sttn_wrkg_rule_reg {Station Working Rule  Register} sttn_mstr_diary {Station Master Diary} Failure_Memo_book {Failure Memo book } Essen_Safet_Equip {Essential Safety Equipments} Rule_book_Manul {Rule book & Manuals} Safety_cir_Bulletin {Safety Circulars/ Safety Bulletins File} First_Aid_Box_Stret {First Aid Box & Stretcher} Pub_complnt_Book {Public Complaint Book} Panel_countr_Reg {Panel Counter Register} Power_traf_blck_reg {Power & Traffic Block register} Priv_Number_Book {Private Number Book} Point_Joint_insp_Reg {Point and Crossing Joint inspection Register} Miscellaneous {Miscellaneous} other {Miscellaneous}}`
  String sttnInspList(Object lang) {
    return Intl.select(
      lang,
      {
        'caution_or_reg': 'Caution Order Register',
        'trn_sgnl_failure': 'Train Signal  Failure Register',
        'sgnl_failure': 'Signal  Failure Register',
        'mnth_ST_failure': 'Month wise S&T failures',
        'crank_hndl_reg': 'Crank Handle Registe',
        'recon_discon_Reg': 'Connect & Recoonect memo register',
        'bioData_Reg': 'Bio Data Register of operating staff',
        'Station_Inspect_Reg': 'Station Inspection Register',
        'Safty_meet_reg': 'Safety Meeting Register',
        'Night_insp_reg': 'Night Inspection Register',
        'over_time_reg': 'Overtime Register',
        'accident_reg': 'Accident  Register',
        'staff_grv_reg': 'Staff Grievance Register',
        'axle_counter_reg': 'Axle Counter Register',
        'fog_reg_griv': 'Fog Signal Register',
        'dsl_dttn_reg': 'Diesel Detention Register',
        'Stbl_load_reg': 'Stabled Load register',
        'Sick_vech_reg': 'Sick Vehicle register',
        'emrg_cross_over_reg': 'Emergency Cross-over register',
        'attendance_reg': 'Attendance  Register',
        'Sttn_wrkg_rule_reg': 'Station Working Rule  Register',
        'sttn_mstr_diary': 'Station Master Diary',
        'Failure_Memo_book': 'Failure Memo book ',
        'Essen_Safet_Equip': 'Essential Safety Equipments',
        'Rule_book_Manul': 'Rule book & Manuals',
        'Safety_cir_Bulletin': 'Safety Circulars/ Safety Bulletins File',
        'First_Aid_Box_Stret': 'First Aid Box & Stretcher',
        'Pub_complnt_Book': 'Public Complaint Book',
        'Panel_countr_Reg': 'Panel Counter Register',
        'Power_traf_blck_reg': 'Power & Traffic Block register',
        'Priv_Number_Book': 'Private Number Book',
        'Point_Joint_insp_Reg': 'Point and Crossing Joint inspection Register',
        'Miscellaneous': 'Miscellaneous',
        'other': 'Miscellaneous',
      },
      name: 'sttnInspList',
      desc: '',
      args: [lang],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Helpdesk`
  String get Helpdesk {
    return Intl.message(
      'Helpdesk',
      name: 'Helpdesk',
      desc: '',
      args: [],
    );
  }

  /// `Enter Login ID`
  String get EnterLoginID {
    return Intl.message(
      'Enter Login ID',
      name: 'EnterLoginID',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Password`
  String get PleaseEnterPassword {
    return Intl.message(
      'Please Enter Password',
      name: 'PleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `How to`
  String get Howto {
    return Intl.message(
      'How to',
      name: 'Howto',
      desc: '',
      args: [],
    );
  }

  /// `reset Password?`
  String get resetPassword {
    return Intl.message(
      'reset Password?',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Station Inspection`
  String get sttnInspTitle {
    return Intl.message(
      'Station Inspection',
      name: 'sttnInspTitle',
      desc: '',
      args: [],
    );
  }

  /// `Caution Order Register`
  String get cautOrdTitle {
    return Intl.message(
      'Caution Order Register',
      name: 'cautOrdTitle',
      desc: '',
      args: [],
    );
  }

  /// `{accilistlang ,select , MaintofAcciReg {Proper maintenance of  Accident Register} Properdatafeeding {Proper data feeding in Register by SS/SM} PunishmentonEnquiry {Punishment on Enquiry} other {Miscellaneous}}`
  String accilistlang(Object accilistlang) {
    return Intl.select(
      accilistlang,
      {
        'MaintofAcciReg': 'Proper maintenance of  Accident Register',
        'Properdatafeeding': 'Proper data feeding in Register by SS/SM',
        'PunishmentonEnquiry': 'Punishment on Enquiry',
        'other': 'Miscellaneous',
      },
      name: 'accilistlang',
      desc: '',
      args: [accilistlang],
    );
  }

  /// `{attndListlang ,select, MainteAsperRoster {Maintenance of register As per Roster} Longabsentness {Long absentness /habitual sick with Action} OverwritingEra {Any Overwriting/Erasing} ClosingAttendreg {Closing of Attendance register by In charge} other{Miscellaneous}}`
  String attndListlang(Object attndListlang) {
    return Intl.select(
      attndListlang,
      {
        'MainteAsperRoster': 'Maintenance of register As per Roster',
        'Longabsentness': 'Long absentness /habitual sick with Action',
        'OverwritingEra': 'Any Overwriting/Erasing',
        'ClosingAttendreg': 'Closing of Attendance register by In charge',
        'other': 'Miscellaneous',
      },
      name: 'attndListlang',
      desc: '',
      args: [attndListlang],
    );
  }

  /// `{cautOrdListlang, select, SpeedRestrictioninfo {Speed Restriction info} MessageDisplayonNoticeBoard{Message  Display  on Notice Board} other {Miscellaneous}} `
  String cautOrdListlang(Object cautOrdListlang) {
    return Intl.select(
      cautOrdListlang,
      {
        'SpeedRestrictioninfo': 'Speed Restriction info',
        'MessageDisplayonNoticeBoard': 'Message  Display  on Notice Board',
        'other': 'Miscellaneous',
      },
      name: 'cautOrdListlang',
      desc: '',
      args: [cautOrdListlang],
    );
  }

  /// `{trnSgnlFaillang, select, CertionFirstPage{Certificate on First Page} IrregwithAdjstation{Irregularity with Adjoining station} FailureDesc{Failure Description} other{Miscellaneous}}`
  String trnSgnlFaillang(Object trnSgnlFaillang) {
    return Intl.select(
      trnSgnlFaillang,
      {
        'CertionFirstPage': 'Certificate on First Page',
        'IrregwithAdjstation': 'Irregularity with Adjoining station',
        'FailureDesc': 'Failure Description',
        'other': 'Miscellaneous',
      },
      name: 'trnSgnlFaillang',
      desc: '',
      args: [trnSgnlFaillang],
    );
  }

  /// `{sgnlFaillang, select, MonthlySumofFailbySS {Monthly Summary of Failures by SS} RelayRoomKeycheck{Relay Room Key check} DoubleLockofRelayRoom{Double Lock of Relay Room} RelayRoomHistory{Relay  Room History} ReasontoOpenRRoom{Reason to Open Relay Room by S&T} other{Miscellaneous}}`
  String sgnlFaillang(Object sgnlFaillang) {
    return Intl.select(
      sgnlFaillang,
      {
        'MonthlySumofFailbySS': 'Monthly Summary of Failures by SS',
        'RelayRoomKeycheck': 'Relay Room Key check',
        'DoubleLockofRelayRoom': 'Double Lock of Relay Room',
        'RelayRoomHistory': 'Relay  Room History',
        'ReasontoOpenRRoom': 'Reason to Open Relay Room by S&T',
        'other': 'Miscellaneous',
      },
      name: 'sgnlFaillang',
      desc: '',
      args: [sgnlFaillang],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}