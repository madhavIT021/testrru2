/// Function to validate email
bool isValidEmail(String email) {
  // Regular expression for validating an email address with exactly 7 numbers before @ and domain as rru.ac.in
  final RegExp emailRegExp = RegExp(
    r'^\d{7}@rru\.ac\.in$',
  );

  return emailRegExp.hasMatch(email);
}

/// Function to validate password
bool isValidPassword(String password) {
  // Regular expression for validating a password
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
  );

  return passwordRegExp.hasMatch(password);
}