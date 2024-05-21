extension StringExtension on String? {
  //return true if given string is empty or null
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this!.isEmpty);
}
