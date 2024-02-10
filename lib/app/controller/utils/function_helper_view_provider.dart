import 'package:flutter/cupertino.dart';

class FunctionHelperViewProvider with ChangeNotifier {

}
String convertMinutesToTime(int minutes) {
  int hours = minutes ~/ 60;
  int days = minutes ~/ (60 * 24);
  int weeks = minutes ~/ (60 * 24 * 7);
  int months = minutes ~/ (60 * 24 * 30);
  int years = minutes ~/ (60 * 24 * 30*12);

  String result = '';
  if (hours == 1) {
    result = '1 hour';
  } else if (hours > 1) {
    result = '$hours hours';
  }

  if (days == 1) {
    result = (result.isNotEmpty ? '' : '') + '1 day';
  } else if (days > 1) {
    result = (result.isNotEmpty ? '' : '') + '$days days';
  }

  if (weeks == 1) {
    result = (result.isNotEmpty ? '' : '') + '1 week';
  } else if (weeks > 1) {
    result = (result.isNotEmpty ? '' : '') + '$weeks weeks';
  }

  if (months == 1) {
    result = (result.isNotEmpty ? '' : '') + '1 month';
  } else if (months > 1) {
    result = (result.isNotEmpty ? '' : '') + '$months months';
  }

  if (years == 1) {
    result = (result.isNotEmpty ? '' : '') + '1 year';
  } else if (years > 1) {
    result = (result.isNotEmpty ? '' : '') + '$years years';
  }

  return result;
}