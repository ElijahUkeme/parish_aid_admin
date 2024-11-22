

import 'package:intl/intl.dart';

String addNairaToAmount(String price) {
  return NumberFormat.currency(
    locale: 'en_NG',
    decimalDigits: 0,
    symbol: '₦',
  ).format(double.parse(price));
}


String formatDate(String date){

  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat("MMM d, yyyy").format(dateTime);

  // Add the ordinal suffix
  String dayWithSuffix = "${dateTime.day}${getOrdinalSuffix(dateTime.day)}";
  return  formattedDate.replaceFirst('${dateTime.day}', dayWithSuffix);
}


// Function to get the ordinal suffix
String getOrdinalSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}