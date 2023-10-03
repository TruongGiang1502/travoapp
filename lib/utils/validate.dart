class Validator {
  static String emailValid = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))'
            r'@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
   static String? value(String? email){
    return 'test';
   }
  
  static bool isEmailValid(String email) {
    return RegExp(Validator.emailValid).hasMatch(email);
  }

  static String? emailValidator(String? email) {
    if (email!.isEmpty) {
      return 'Please enter email';
    } else if (!isEmailValid(email)) {
      return 'Email is not valid';
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Please enter Password';
    } else if (password.length < 8) {
      return 'Password must have at least 8 character';
    }
    return null;
  }

  static String? checkNull(String? text) {
    if (text!.isEmpty || text == '') {
      return 'Please enter this field';
    } 
    return null;
  }      
}
