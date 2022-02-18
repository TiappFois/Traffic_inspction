class TiConstants {
  //static String webServiceUrl ="http://cms.indianrail.gov.in/cmswebservicejar/master/";
  //static String webServiceUrl ="https://cms.indianrail.gov.in/CMSWEBSERVICE/master/";
  static String webServiceUrl = "https://www.foistest.indianrail.gov.in:443/TiWebsrvc/resources/ti/";
  //static String webServiceUrl =
  //  "http://172.16.4.58:7101/TIWebService-TrafficInspectionRest-context-root/resources/TiAppService/";

 // static String webServiceUrl ="http://10.60.201.196:50010/TiWebsrvc/resources/ti/";
  //static String webServiceUrl = "http://172.16.25.45:9081/CMSWEBSERVICE/master/";
  //static String webServiceUrl = "http://10.60.200.168/CMSWEBSERVICE/master/";
  static String contextPath = "https://cms.indianrail.gov.in";
  static String loginUserId = "";
  static const APP_STORE_URL =
      'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=in.org.cris.cmsm&mt=8';
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.cris.cmsm';
   static String token ="eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdmluZXNoIiwiZXhwIjoxNjA2MzI0NTg5LCJpYXQiOjE2MDYzMDY1ODl9.-HMhMqK8VsccfrIxb6liKvDZ3desaG6gHcjkP8Cm8FpHA8Cnk8ZpEgDslM8l_-9zQTH2VZj4oFmEMVbb_Dop7Q";
  static Map<String, String> headerInput = {
    //"Accept": "application/json",
    "Accept": "*/*",
    "Content-Type": "application/json",
    //"Access-Control-Allow-Origin": "*",
    // "Authorization": "Bearer $token",
    //"Content-Type": "application/x-www-form-urlencoded"
  };
  static Map<String, String> headerInputText = {
    "Accept": "*/*",
    "Content-Type": "text/plain"
    //"application/x-www-form-urlencoded"
  };
}
