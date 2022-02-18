import 'dart:io';

import 'package:provider/provider.dart';
import 'package:ti/LanguageChangeProvider.dart';
import 'package:ti/commonutils/size_config.dart';
import 'package:ti/pages/SttnInsp/First_aid_box_Stretcher.dart';
import 'package:ti/pages/SttnInsp/Miscellaneous.dart';
import 'package:ti/pages/SttnInsp/connect_recon_Reg.dart';
import 'package:ti/pages/SttnInsp/Trn_Sgnl_Failure.dart';
import 'package:ti/pages/SttnInsp/accident_register.dart';
import 'package:ti/pages/SttnInsp/attendance_register.dart';
import 'package:ti/pages/SttnInsp/axle_counter.dart';
import 'package:ti/pages/SttnInsp/bioData_Reg.dart';
import 'package:ti/pages/SttnInsp/caution_or_reg.dart';
import 'package:ti/pages/SttnInsp/crank_Hndl_Reg.dart';
import 'package:ti/pages/SttnInsp/diesel_detention_Reg.dart';
import 'package:ti/pages/SttnInsp/emergency_crossover_register.dart';
import 'package:ti/pages/SttnInsp/essential_safety_equipment.dart';
import 'package:ti/pages/SttnInsp/failure_memo_book.dart';
import 'package:ti/pages/SttnInsp/fog_signal_register.dart';
import 'package:ti/pages/SttnInsp/mnth_S&T_failure.dart';
import 'package:ti/pages/SttnInsp/night_inspection_register.dart';
import 'package:ti/pages/SttnInsp/over_time_register.dart';
import 'package:ti/pages/SttnInsp/panel_counter_register.dart';
import 'package:ti/pages/SttnInsp/point_cross_joint_insp_regr.dart';
import 'package:ti/pages/SttnInsp/power_traffic_block_register.dart';
import 'package:ti/pages/SttnInsp/private_number_book.dart';
import 'package:ti/pages/SttnInsp/public_complaint_box.dart';
import 'package:ti/pages/SttnInsp/rule_book_manual_register.dart';
import 'package:ti/pages/SttnInsp/safety_circular_bulletin.dart';
import 'package:ti/pages/SttnInsp/safety_meeting_register.dart';
import 'package:ti/pages/SttnInsp/sgnl_failure_reg.dart';
import 'package:ti/pages/SttnInsp/sick_vechile_register.dart';
import 'package:ti/pages/SttnInsp/stable_load_Reg.dart';
import 'package:ti/pages/SttnInsp/staff_grievence_register.dart';
import 'package:ti/pages/SttnInsp/station_inspection_register.dart';
import 'package:ti/pages/SttnInsp/station_master_dairy.dart';
import 'package:ti/pages/SttnInsp/station_working_rule_registier.dart';
import 'package:ti/pages/SttnInsp/sttn_inspection.dart';
import 'package:ti/screens/apphome.dart';
import 'package:ti/screens/user_home.dart';
import 'package:ti/screens/common/change_password.dart';
import 'package:ti/screens/common/coming_soon.dart';
import 'package:ti/screens/login_page.dart';
import 'package:ti/screens/splash_screen.dart';
import 'package:ti/screens/user_profile.dart';
import 'package:ti/screens/userhome.dart';
import 'package:ti/screens/TILocation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'commonutils/styling.dart';
import 'generated/l10n.dart';
import 'model/SttnInspModels/station_inspection_registerModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // important

main() async {
  Logger.level = Level.debug;
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const TrafficApp());
}

class TrafficApp extends StatelessWidget {
  const TrafficApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return ChangeNotifierProvider<LanguageChangeProvider>(
              create: (contact) => LanguageChangeProvider(),
              child: Builder(
                builder: (context) {
                  return MaterialApp(
                    locale: Provider.of<LanguageChangeProvider>(context,listen: true).currentLocale,
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.currentTheme,
                    // home: user_profiledetails(userId: '',),
                    // home: StableLoadRegister(),
                    home: SplashScreen(),
                    initialRoute: '/',
                    onGenerateRoute: Routes.generateRoute, // Error here for now
                    localizationsDelegates: [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales, // important
                  );
                }
              ),
            );
          },
        );
      },
    );
  }
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            //builder: (context) => user_home());
            builder: (context) => AppHome());
        //   builder: (context) => user_profiledetails());
        break;
      case '/coming_soon':
        return MaterialPageRoute(
          builder: (context) => ComingSoon(),
        );
        break;
      case '/user_home':
        return MaterialPageRoute(
          builder: (context) => UserHomePageForm(),
          // builder: (context) => UserHome(),
        );
        break;
      case '/caution_or_reg':
        return MaterialPageRoute(
          builder: (context) => CautionOrdReg(),
        );
        break;
      case '/trn_sgnl_failure':
        return MaterialPageRoute(
          builder: (context) => TrnSgnlFailure(),
        );
        break;
      case '/sgnl_failure':
        return MaterialPageRoute(
          builder: (context) => SgnlFailure(),
        );
        break;
      case '/mnth_ST_failure':
        return MaterialPageRoute(
          builder: (context) => MnthSTFailure(),
        );
        break;
      case '/crank_hndl_reg':
        return MaterialPageRoute(
          builder: (context) => CrankHndlReg(),
        );
        break;
      case '/recon_discon_Reg':
        return MaterialPageRoute(
          builder: (context) => ReconDisconReg(),
        );
        break;
      case '/bioData_Reg':
        return MaterialPageRoute(
          builder: (context) => BioDataReg(),
        );

        break;

      case '/Station_Inspect_Reg':
        return MaterialPageRoute(
          builder: (context) => SttnInspReg(),
        );
        break;

      case '/Safty_meet_reg':
        return MaterialPageRoute(
          builder: (context) => SafetyMeetingRegister(),
        );
        break;

      case '/Night_insp_reg':
        return MaterialPageRoute(
          builder: (context) => NightInspectionRegister(),
        );
        break;
      case '/over_time_reg':
        return MaterialPageRoute(
          builder: (context) => OverTimeRegister(),
        );
        break;
      case '/accident_reg':
        return MaterialPageRoute(
          builder: (context) => AccidentRegister(),
        );
        break;
      case '/staff_grv_reg':
        return MaterialPageRoute(
          builder: (context) => StaffGreivence(),
        );
        break;
      case '/axle_counter_reg':
        return MaterialPageRoute(
          builder: (context) => AxleCounterRegister(),
        );
        break;
      case '/fog_reg_griv':
        return MaterialPageRoute(
          builder: (context) => FogSignalRegister(),
        );
        break;
      case '/dsl_dttn_reg':
        return MaterialPageRoute(
          builder: (context) => DieselDetention(),
        );
        break;
      case '/Stbl_load_reg':
        return MaterialPageRoute(
          builder: (context) => StableLoadRegister(),
        );
        break;

      case '/Sick_vech_reg':
        return MaterialPageRoute(
          builder: (context) => SickVechileRegister(),
        );
        break;
      case '/emrg_cross_over_reg':
        return MaterialPageRoute(
          builder: (context) => EmergencyCrossoverRegister(),
        );
        break;

      case '/attendance_reg':
        return MaterialPageRoute(
          builder: (context) => AttendanceRegister(),
        );
        break;

      case '/Sttn_wrkg_rule_reg':
        return MaterialPageRoute(
          builder: (context) => StationworkingRuleRegister(),
        );
        break;

      case '/sttn_mstr_diary':
        return MaterialPageRoute(
          builder: (context) => StationMasterDiary(),
        );
        break;

      case '/Failure_Memo_book':
        return MaterialPageRoute(
          builder: (context) => FailureMemoBook(),
        );

        break;

      case '/Essen_Safet_Equip':
        return MaterialPageRoute(
          builder: (context) => EssentialSafetyEquiments(),
        );

        break;

      case '/Rule_book_Manul':
        return MaterialPageRoute(
          builder: (context) => RuleBookManual(),
        );

        break;

      case '/Safety_cir_Bulletin':
        return MaterialPageRoute(
          builder: (context) => SafetyCircularBulletin(),
        );

        break;

      case '/First_Aid_Box_Stret':
        return MaterialPageRoute(
          builder: (context) => FirstAidBoxStetcher(),
        );

        break;

      case '/Pub_complnt_Book':
        return MaterialPageRoute(
          builder: (context) => PublicComplaintBox(),
        );

        break;

      case '/Panel_countr_Reg':
        return MaterialPageRoute(
          builder: (context) => PanelCounterRegister(),
        );
        break;

      case '/Power_traf_blck_reg':
        return MaterialPageRoute(
          builder: (context) => PowerTrafficBlockRegister(),
        );

        break;

      case '/Priv_Number_Book':
        return MaterialPageRoute(
          builder: (context) => PrivateNumberBook(),
        );

        break;

      

      case '/Point_Joint_insp_Reg':
        return MaterialPageRoute(
          builder: (context) => PointCrossingJointInspectRegister(),
        );

        break;
      case '/Miscellaneous':
        return MaterialPageRoute(
          builder: (context) => Miscellaneous(),
        );

        break;
      case '/TILocation':
        return MaterialPageRoute(
          builder: (context) => TILocation(),
        );

        break;
        break;
      case '/sttnInspList':
        return MaterialPageRoute(
          builder: (context) => SttnInspection(),
        );

        break;

      //
      case '/change_password':
        return MaterialPageRoute(
          builder: (context) => ChangePasswordForm(),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPageForm(),
          // builder: (context) => UserHomePageForm(),
        );
    }
  }
}
