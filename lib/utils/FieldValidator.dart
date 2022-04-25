import 'AppString.dart';

class FieldValidator {
  static String? validateEmail(String? value) {

    if (value!.isEmpty) return AppString.emailRequired;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = new RegExp(pattern.toString());

    if (!regex.hasMatch(value.trim())) {
      return AppString.enterValidEmail;
    }

    return null;
  }


  static String? validateValueIsEmpty(String value) {
    if (value.isEmpty) {
      return "Value is Required";
    }
    return null;
  }



}
