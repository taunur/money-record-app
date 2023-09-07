import 'package:intl/intl.dart';

class AppFormat {
  //22-02-05
  static String date(String stringDate) {
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('dd MMM yyyy', 'id_ID').format(dateTime); // 05 Feb 2022
  }
}
