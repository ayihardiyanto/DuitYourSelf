import 'package:duit_yourself/common/constants/regex_constants.dart';

class ValidatorsConstants {
  static bool alphanumCommaAndDotsWithSpace(String inputs) {
    return RegexConstants.alphaCommaAndDotsWithSpace.hasMatch(inputs);
  }

   static bool alphaNumericCommaAndDotsWithSpace(String inputs) {
    return RegexConstants.alphaNumericCommaAndDotWithSpace.hasMatch(inputs);
  }
  
  static bool isValidEmail(String email) {
    return RegexConstants.emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return RegexConstants.passwordRegExp.hasMatch(password);
  }

  static bool isValidTypeForm(String typeFromUrl) {
    return RegexConstants.typeFormRegExp.hasMatch(typeFromUrl);
  }
}