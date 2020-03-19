class StringUtils {

  static bool isValidEmail(String str){
    RegExp exp = new RegExp(r"(\w+)");
    return exp.hasMatch(str);
  }
}