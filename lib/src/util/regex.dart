class Regex {
  static RegExp _emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static RegExp _removeAllWhiteSpacesRegExp = RegExp(r"\ ");

  static Iterable<Match> emailRegex(String email) {
    return _emailRegExp.allMatches(email);
  }

  static Iterable<Match> removeAllWhiteSpacesRegex(String email) {
    return _removeAllWhiteSpacesRegExp.allMatches(email);
  }
}
