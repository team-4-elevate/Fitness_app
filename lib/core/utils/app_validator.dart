class AppValidators {
  /// Validates email format
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.{0,1}[a-zA-Z]+)?$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  /// Validates phone number (specific to Egypt 010, 011, 012, 015)
  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return 'Please enter your phone number.';
    }

    final cleaned = phoneNumber.trim().replaceAll(' ', '');
    final phoneRegex = RegExp(r'^01(0|1|2|5)[0-9]{8}$');
    if (!phoneRegex.hasMatch(cleaned)) {
      return 'Please Enter a valid Number.\nExample: 01001234567';
    }

    return null;
  }

  // Validates password strength like Test@123
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    List<String> errors = [];

    if (!RegExp(r'(?=.*[a-z])').hasMatch(password)) {
      errors.add('at least one lowercase letter');
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      errors.add('at least one uppercase letter');
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(password)) {
      errors.add('at least one number');
    }
    if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(password)) {
      errors.add('at least one special character (@\$!%*?&)');
    }
    if (password.length < 8) {
      errors.add('minimum 8 characters');
    }

    if (errors.isEmpty) {
      return null;
    } else {
      return 'Password must have:\n- ${errors.join('\n- ')}';
    }
  }

  static String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required.';
    }

    final trimmed = value.trim();

    if (trimmed.length < 3 || trimmed.length > 30) {
      return 'Username must be between 3 and 30 characters.';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(trimmed)) {
      return 'Username can only contain letters and spaces.';
    }

    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Last name is required.';
    }

    final trimmed = value.trim();

    if (trimmed.length < 3 || trimmed.length > 30) {
      return 'Last name  must be between 3 and 30 characters.';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(trimmed)) {
      return 'Last name can only contain letters and spaces.';
    }

    return null;
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required.';
    }

    final trimmed = value.trim();

    if (trimmed.length < 3 || trimmed.length > 30) {
      return 'First name must be between 3 and 30 characters.';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(trimmed)) {
      return 'First name can only contain letters and spaces.';
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String originalPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password.';
    }

    if (confirmPassword != originalPassword) {
      return 'Passwords do not match.';
    }

    return null;
  }
}
