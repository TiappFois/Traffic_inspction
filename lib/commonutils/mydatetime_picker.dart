import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTimePicker {
  //date picker
  static Future<String> myDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(Duration(days: -9999)),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      return DateFormat('dd-MM-yyyy').format(picked);
    else
      return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  //time picker
  static Future<String> myTimePicker(BuildContext context) async {
    final TimeOfDay response = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (response != null) {
      return formatTimeOfDay(response);
    } else
      return formatTimeOfDay(TimeOfDay.now());
  }

  //date time pickers
  static Future<String> myDateTimePicker(BuildContext context) async {
    String myDate = await myDatePicker(context);
    String myTime = await myTimePicker(context);
    return myDate + ' ' + myTime;
  }

  //format time of day
  static String formatTimeOfDay(TimeOfDay tod) {
    final dt = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, tod.hour, tod.minute);
    return DateFormat("HH:mm").format(dt);
  }

 

}
