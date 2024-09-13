class Validators {
  // Validate if the email format is correct
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Validate if the password meets the requirements
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Validate if the passwords matches
  static String? validateConfirmPassword(String? value, String? value2) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != value2) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Validate if the username is not empty and meets the requirements
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  // Validate if the amount is a positive number
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Enter a valid amount';
    }
    return null;
  }

  // Validate if the phone number is correct
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // Validate if the Aadhaar number is correct (assuming a 12-digit format)
  static String? validateAadhaarNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Aadhaar number is required';
    }
    final aadhaarRegExp = RegExp(r'^\d{12}$');
    if (!aadhaarRegExp.hasMatch(value)) {
      return 'Enter a valid Aadhaar number';
    }
    return null;
  }
}