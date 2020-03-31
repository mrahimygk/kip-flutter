class StringUtils {

  static bool isValidEmail(String str){
    RegExp exp = new RegExp(r"\w{2,}@\w+\.\w{2,}");
    return exp.hasMatch(str);
  }
}