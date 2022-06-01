bool isValidPhoneNumber(String string) {
  // Null or empty string is invalid phone number
  if (string.isEmpty) {
    return false;
  }

  // You may need to change this pattern to fit your requirement.
  // I just copied the pattern from here: https://regexr.com/3c53v
  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s) != null;
}
