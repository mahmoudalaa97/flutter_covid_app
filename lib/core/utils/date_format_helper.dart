import 'package:intl/intl.dart';

class DateFormatHelper {
  DateFormatHelper._();

  static String getDateFormat(DateTime? dateTime) {
    final f = new DateFormat('yyyy-MM-dd');
    return f.format(new DateTime.fromMillisecondsSinceEpoch(
        dateTime!.millisecondsSinceEpoch));
  }
}