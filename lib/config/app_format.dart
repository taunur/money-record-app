import 'package:intl/intl.dart';

class AppFormat {
  //22-02-05
  static String date(String stringDate) {
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('dd MMM yyyy', 'id_ID').format(dateTime); // 05 Feb 2022
  }

  static String currency(String number) {
    return NumberFormat.currency(
      decimalDigits: 2,
      locale: 'id_ID',
      symbol: 'Rp. ',
    ).format(double.parse(number));
  }
}
