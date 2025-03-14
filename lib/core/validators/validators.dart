class Validator {
    static String? validateEmptyField(String? value ) {
    if (value == null || value.trim().isEmpty) {
      return 'Fill the Field';
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter your Valid Email';
    }
    if (value.length < 4) {
      return 'Too short';
    }
    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return ' Please enter a valid email';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty || value.length > 2) {
      return 'Please Enter your Age';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please Enter Your Correct Age';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty || value.length < 9 ) {
      return 'Please Enter Your Valid Phone Number to recieve an OTP';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please Enter Your Valid Phone Number to recieve an OTP';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter Your Password';
    }
    if (!RegExp(
            r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()-_+=]).{8,}$')
        .hasMatch(value)) {
      return 'Password must contain at least 8 characters, including at least one uppercase letter, one lowercase letter, one digit, and one special character';
    }

    return null;
  }
}
