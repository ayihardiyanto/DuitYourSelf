class RegexConstants {
  static final RegExp alphaCommaAndDotsWithSpace = RegExp(r'[^A-Za-z.,\s]');
  static final RegExp alphaNumericCommaAndDotWithSpace = RegExp(r'[^a-zA-Z0-9,.\s]');
  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp typeFormRegExp = RegExp(
    r'^(?=.*\btypeform.com\b)(?=.*\bemail\b)(?=.*\bdocid\b).*$',
  );


}
