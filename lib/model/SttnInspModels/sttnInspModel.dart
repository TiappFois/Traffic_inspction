import 'dart:io';
import '../CheckBoxList.dart';

class SttnInspectionModel {
  List<String> sIList = [];

  SttnInspectionModel(this.sIList);

  static List<String> getData() {
    List<String> sIList = [
      'Caution Order Register',
      'Train Signal  Failure Register',
      'Signal  Failure Register',
      'Month wise S&T failures',
      'Crank Handle Register',
      'Connect & Recoonect memo register',
      'Bio Data Register of operating staff',
      'Station Inspection Register',
      'Safety Meeting Register',
      'Night Inspection Register',
      'Overtime Register',
      'Accident  Register',
      'Staff Grievance Register',
      'Axle Counter Register',
      'Fog Signal Register',
      'Diesel Detention Register',
      'Stabled Load register',
      'Sick Vehicle register',
      'Emergency Cross-over register',
      'Attendance  Register',
      'Station Working Rule  Register',
      'Station Master Diary',
      'Failure Memo book',
      'Essential Safety Equipments',
      'Rule book & Manuals',
      'Safety Circulars/ Safety Bulletins File',
      'First Aid Box & Stretcher',
      'Public Complaint Book',
      'Panel Counter Register',
      'Power & Traffic Block register',
      'Private Number Book',
       'Point and Crossing Joint inspection Register',
      'Miscellaneous'
    ];
    return sIList;
  }

  static List<String> getLinks() {
    List<String> linksList = [
      'caution_or_reg',
      'trn_sgnl_failure',
      'sgnl_failure',
      'mnth_ST_failure',
      'crank_hndl_reg',
      'recon_discon_Reg',
      'bioData_Reg',
      'Station_Inspect_Reg',
      'Safty_meet_reg',
      'Night_insp_reg',
      'over_time_reg',
      'accident_reg',
      'staff_grv_reg',
      'axle_counter_reg',
      'fog_reg_griv',
      'dsl_dttn_reg',
      'Stbl_load_reg',
      'Sick_vech_reg',
      'emrg_cross_over_reg',
      'attendance_reg',
      'Sttn_wrkg_rule_reg',
      'sttn_mstr_diary',
      'Failure_Memo_book',
      'Essen_Safet_Equip',
      'Rule_book_Manul',
      'Safety_cir_Bulletin',
      'First_Aid_Box_Stret',
      'Pub_complnt_Book',
      'Panel_countr_Reg',
      'Power_traf_blck_reg',
      'Priv_Number_Book',
      'Point_Joint_insp_Reg',
      'Miscellaneous'
    ];
    return linksList;
  }
}
