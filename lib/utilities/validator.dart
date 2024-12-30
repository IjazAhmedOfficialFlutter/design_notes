class Validator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Field is empty';
    } else {
      return null;
    }
  }

  static String? emailValidator(String? email) {
    final RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty) {
      return 'Email field is required';
    } else if (!regExp.hasMatch(email.trim())) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password field is required';
    } else if (password.length < 6) {
      return "Password can't be smaller than 6 characters";
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(
      String? confirmPassword, String password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password field is required';
    } else if (confirmPassword != password) {
      return "It doesn't matches with password";
    } else {
      return null;
    }
  }

  static String? validateTextField(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required Field';
    }
    return null;
  }
  static String? phoneValidator(String? phoneNumber) {
    // final RegExp regExp = RegExp(r'^\+?[1-9]\d{1,14}$'); // E.164 format
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number field is required';
    }
    //   if (!regExp.hasMatch(phoneNumber.trim())) {
    //   return 'Enter a valid phone number';
    // } else {
      return null;
    // }
  }

}

