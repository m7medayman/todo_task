class InputValidator {
  // Static method to validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (value.length < 3) {
      return "Invalid email: too short";
    }
    if (!value.contains("@")) {
      return "Email must contain '@'";
    }
    return validateRegularField(value);
  }

  // check the input of user is int or not
  static String? validateInt(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    if (int.tryParse(value) == null) {
      return "This field must be a number";
    }
    // check the value is lower than 60
    if (int.parse(value) > 60) {
      return "This field must be lower than 50";
    }
    return null; // valid input
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    if (value.length != 10 && value.length != 11) {
      return "Invalid phone number";
    }
    return validateRegularField(value);
  }

  // Static method to validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return validateRegularField(value);
  }

  // Static method to validate a regular (generic) input field
  static String? validateRegularField(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null; // valid input
  }
}
