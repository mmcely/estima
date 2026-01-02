class AppValidator {
  static String? validateTitleText(String? value, {bool isOptional = false}) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    if (value.length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

  /// Validator priority
  static String? validatePriority(String? value, {bool isOptional = false}) {
    if (value == null || value.isEmpty) {
      return 'Please enter a priority';
    }
    final priority = int.tryParse(value);
    if (priority == null || priority < 1) {
      return 'Priority must be a number greater than 0';
    }
    return null;
  }

  /// Validator for empty text
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  /// Username validator
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required.';
    }

    // Regular expression for username
    const pattern = r"^[a-zA-Z0-9_-]{3,20}$";

    // Create a RegExp instance from the pattern
    final regex = RegExp(pattern);

    // Check if the username matches the pattern
    bool isValid = regex.hasMatch(username);

    // Check that username doesn't start or end with underscore or hyphen
    if (isValid) {
      isValid =
          !username.startsWith('_') &&
          !username.startsWith('-') &&
          !username.endsWith('_') &&
          !username.endsWith('-');
    }

    if (!isValid) {
      return 'Username must be 3-20 characters and can only contain letters, numbers, underscores, and hyphens.';
    }

    return null;
  }

  /// Full name validator
  static String? validateFullName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Full name is required.';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters.';
    }
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(name)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes.';
    }
    return null;
  }

  /// Email validator
  static String? validateEmail(String? value, {bool isOptional = false}) {
    if (isOptional && (value == null || value.isEmpty)) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  /// Phone number validator
  static String? validatePhoneNumber(String? value, {String? countryCode}) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Clean phone number (remove spaces, dashes, parentheses)
    final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check minimum length
    if (cleanPhone.length < 8) {
      return 'Please enter a valid phone number (at least 8 digits).';
    }

    // Check that it contains only digits
    if (!RegExp(r'^\d+$').hasMatch(cleanPhone)) {
      return 'Phone number can only contain digits.';
    }

    // Country-specific validations (optional)
    if (countryCode != null) {
      switch (countryCode) {
        case '+1': // USA/Canada
          if (cleanPhone.length != 10) {
            return 'US/Canada phone numbers must be 10 digits.';
          }
          break;
        case '+33': // France
          if (cleanPhone.length != 9) {
            return 'French phone numbers must be 9 digits.';
          }
          break;
        case '+237': // Cameroon
          if (cleanPhone.length != 9) {
            return 'Cameroon phone numbers must be 9 digits.';
          }
          break;
      }
    }

    return null;
  }

  /// Password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check minimum length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_-]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  /// Password confirmation validator
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }

    if (value != password) {
      return 'Passwords do not match.';
    }

    return null;
  }

  /// OTP code validator
  static String? validateOTP(String? value, {int length = 6}) {
    if (value == null || value.isEmpty) {
      return 'Verification code is required.';
    }

    if (value.length != length) {
      return 'Please enter the full $length-digit code.';
    }

    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Code can only contain digits.';
    }

    return null;
  }

  /// Bio validator
  static String? validateBio(String? value, {int maxLength = 200}) {
    if (value == null || value.isEmpty) {
      return null; // Bio is optional
    }

    if (value.length > maxLength) {
      return 'Bio cannot exceed $maxLength characters.';
    }

    return null;
  }

  /// Terms and conditions validator
  static String? validateTerms(bool? value) {
    if (value == null || !value) {
      return 'You must accept the terms and conditions.';
    }
    return null;
  }

  /// General validator for text fields
  static String? validateTextField({
    required String? value,
    required String fieldName,
    bool isRequired = true,
    int minLength = 1,
    int? maxLength,
    RegExp? pattern,
  }) {
    if (isRequired && (value == null || value.isEmpty)) {
      return '$fieldName is required.';
    }

    if (value != null && value.isNotEmpty) {
      if (value.length < minLength) {
        return '$fieldName must be at least $minLength characters.';
      }

      if (maxLength != null && value.length > maxLength) {
        return '$fieldName cannot exceed $maxLength characters.';
      }

      if (pattern != null && !pattern.hasMatch(value)) {
        return 'Please enter a valid $fieldName.';
      }
    }

    return null;
  }

  /// Gender validator (updated with "Prefer not to say")
  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Gender is required.';
    }

    final validGenders = ['female', 'male', 'other', 'prefer_not_to_say'];
    if (!validGenders.contains(value.toLowerCase())) {
      return 'Please select a valid gender.';
    }

    return null;
  }

  /// Country validator
  static String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required.';
    }

    if (value.length < 2) {
      return 'Please select a valid country.';
    }

    return null;
  }

  /// Region validator
  static String? validateRegion(String? value, {String? country}) {
    if (country != null && (value == null || value.isEmpty)) {
      return 'Region is required for the selected country.';
    }

    if (value != null && value.isNotEmpty && value.length < 2) {
      return 'Please select a valid region.';
    }

    return null;
  }

  /// Birth date validator
  static String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Birth date is required.';
    }

    try {
      final date = DateTime.parse(value);
      final now = DateTime.now();
      final age = now.year - date.year;

      if (date.isAfter(now)) {
        return 'Birth date cannot be in the future.';
      }

      if (age < 13) {
        return 'You must be at least 13 years old.';
      }

      if (age > 120) {
        return 'Please enter a valid birth date.';
      }
    } catch (e) {
      return 'Please enter a valid date (YYYY-MM-DD).';
    }

    return null;
  }

  /// City validator
  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required.';
    }

    if (value.length < 2) {
      return 'City name must be at least 2 characters.';
    }

    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value)) {
      return 'City name can only contain letters, spaces, hyphens, and apostrophes.';
    }

    return null;
  }

  /// Sexual orientation validator
  static String? validateSexualOrientation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Sexual orientation is required.';
    }

    final validOrientations = [
      'heterosexual',
      'bisexual',
      'lesbian',
      'gay',
      'other',
    ];
    if (!validOrientations.contains(value.toLowerCase())) {
      return 'Please select a valid sexual orientation.';
    }

    return null;
  }
}
