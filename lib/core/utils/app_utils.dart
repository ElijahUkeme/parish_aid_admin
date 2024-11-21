
String splitDateTime(String date){
  return date.split('T')[0];
}
String splitDateWithoutT(String date){
  return date.split(' ')[0];
}
String splitDateOfBirth(String dob){
  String day = dob.split(' ')[0];
  String date = dob.split(' ')[1];
  String month = dob.split(' ')[2];
  String year = dob.split(' ')[3];
  return '$day $date $month $year';
}